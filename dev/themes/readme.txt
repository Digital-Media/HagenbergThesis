This is the suggested future place for theme style files.

A theme specifies the contents and layout of the thesis front pages and is associated 
with a LaTeX style file named in the form

	hgbtheme-<themeID>.sty
	
where <themeID> is a unique identifier, for example,

	hgbtheme-fhooe2023.sty 

Additional files required by a theme (such as graphics files) must be named with the 
complete theme name as a prefix, for example,

	hgbtheme-fhooe2023-coverbackground.pdf

The rationale behind this strict naming convention is that themes will be part of the CTAN distribution,
thus all theme-related files will eventually end up in a single, flat directory.
	
To use a specific theme its <themeID> must be passed to the \documentclass command, for example,

	\documentclass[theme=fhooe2023,...]{hgbthesis}

All theme sources are stored in /dev/themes (perhaps with individual subdirectories?).
