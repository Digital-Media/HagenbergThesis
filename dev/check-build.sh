#!/bin/bash
# check-build.sh: Checks the results of a build of the sample documents and the manual.
# Used by 'make check' (see makefile) and by the GitHub Actions workflow.
#
# 1. The PDF file of each document exists.
# 2. LaTeX and Biber log files in <logdir> (kept there by makefile-latex): errors and
#    problematic warnings let the check fail, all other warnings are only counted.
# 3. PDF/A-2b compliance of each PDF file, validated with veraPDF.
#
# Usage: check-build.sh <logdir> <verapdf> <pdf file> ...
#   <logdir>   directory with the log files; <logdir>/<name>.log belongs to <name>/main.pdf
#   <verapdf>  veraPDF command, or 'skip' to skip the PDF/A check
# The exit status is 1 if any check fails. In GitHub Actions, the results are also written
# to the job summary and failures are reported as annotations.

LOGDIR="$1"
VERAPDF="$2"
shift 2

# Log lines that let the check fail (extended regular expressions):
FAIL_PATTERNS=(
	'^! '                                               # TeX/LaTeX errors
	'LaTeX Warning: (Reference|Citation) .*undefined'   # undefined reference or citation
	'LaTeX Warning: There were undefined'               # summary of undefined references/citations
	'LaTeX Warning: Label\(s\) may have changed'        # cross references not resolved
	'Please \(re\)run Biber|Please rerun LaTeX'         # incomplete build (biblatex)
	'Missing character: There is no'                    # character missing in font
	'(Class|Package) hgb[a-z]* (Warning|Error)'         # warnings/errors of this package
)
BIBER_FAIL_PATTERN='ERROR - '                          # Biber errors
# Log lines that are only counted:
WARNING_PATTERN='Warning|Overfull|Underfull'
BIBER_WARNING_PATTERN='WARN - '

status=0
summary() { [ -n "$GITHUB_STEP_SUMMARY" ] && echo "$1" >> "$GITHUB_STEP_SUMMARY"; }
annotate() { [ -n "$GITHUB_ACTIONS" ] && echo "::error title=$1::$2"; }

if [ -z "$LOGDIR" ] || [ ! -d "$LOGDIR" ]; then
	echo "check-build: log directory '$LOGDIR' not found (set LOGDIR and rebuild)"
	exit 1
fi

summary "## Build check"
summary ""
summary "| Document | PDF | Problems in logs | Other warnings | PDF/A-2b |"
summary "|:--|:-:|:-:|:-:|:-:|"

for pdf in "$@"; do
	name=$(basename "$(dirname "$pdf")")
	log="$LOGDIR/$name.log"
	blg="$LOGDIR/$name.blg"
	echo "=== $name"

	# 1. PDF file
	if [ -f "$pdf" ]; then
		pdf_result="✅"
	else
		pdf_result="❌"
		echo "  PDF file missing: $pdf"
		annotate "$name" "PDF file missing: $pdf"
		status=1
	fi

	# 2. log files
	problems=0
	warnings=0
	if [ -f "$log" ]; then
		for pattern in "${FAIL_PATTERNS[@]}"; do
			matches=$(grep -E -- "$pattern" "$log")
			if [ -n "$matches" ]; then
				count=$(echo "$matches" | wc -l)
				problems=$((problems + count))
				echo "$matches" | head -5 | while IFS= read -r line; do
					echo "  PROBLEM: $line"
					annotate "$name" "$line"
				done
			fi
		done
		warnings=$(grep -c -E -- "$WARNING_PATTERN" "$log")
	else
		echo "  log file missing: $log"
		annotate "$name" "log file missing: $log"
		problems=$((problems + 1))
	fi
	if [ -f "$blg" ]; then
		matches=$(grep -E -- "$BIBER_FAIL_PATTERN" "$blg")
		if [ -n "$matches" ]; then
			problems=$((problems + $(echo "$matches" | wc -l)))
			echo "$matches" | head -5 | while IFS= read -r line; do
				echo "  PROBLEM (Biber): $line"
				annotate "$name" "Biber: $line"
			done
		fi
		warnings=$((warnings + $(grep -c -E -- "$BIBER_WARNING_PATTERN" "$blg")))
	fi
	[ "$problems" -gt 0 ] && status=1
	echo "  problems: $problems, other warnings: $warnings"

	# 3. PDF/A-2b compliance
	if [ "$VERAPDF" = "skip" ]; then
		pdfa_result="skipped"
	elif [ ! -f "$pdf" ]; then
		pdfa_result="–"
	else
		result=$("$VERAPDF" --flavour 2b --format text "$pdf" 2>/dev/null | head -1)
		case "$result" in
			PASS*)
				pdfa_result="✅"
				;;
			*)
				pdfa_result="❌"
				status=1
				echo "  PDF/A-2b validation failed: ${result:-no result from veraPDF}"
				annotate "$name" "PDF/A-2b validation failed"
				"$VERAPDF" --flavour 2b --format text --verbose "$pdf" 2>/dev/null | tail -n +2 | head -20 | sed 's/^/    /'
				;;
		esac
	fi
	echo "  PDF/A-2b: $pdfa_result"

	problems_cell="$problems"
	[ "$problems" -gt 0 ] && problems_cell="**$problems** ❌"
	summary "| \`$name\` | $pdf_result | $problems_cell | $warnings | $pdfa_result |"
done

summary ""
if [ "$status" -eq 0 ]; then
	echo "check-build: all checks passed"
	summary "All checks passed."
else
	echo "check-build: some checks FAILED"
	summary "**Some checks failed**, see the log of this step for details."
fi
exit $status
