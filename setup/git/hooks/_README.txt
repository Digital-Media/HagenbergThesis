Hooks are local to any given Git repository, and they are not copied over to the new repository when you run git clone (i.e., they are not committed/pushed).

See: https://www.atlassian.com/git/tutorials/git-hooks

To install a hook in your local repo, copy the files from this folder into
<repo>/.git/hooks

