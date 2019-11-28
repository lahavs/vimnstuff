Git-related stuff

In the bashrc we add 'diff-highlight' to the $PATH envar
Make sure to make this file ("/usr/share/doc/git/contrib/diff-highlight") executable.

Also look at the aliases in the .gitconfig :)

Also, copy the git_templates directory to the root directory (And add '.' in the
  directory name).

They contain hooks to be called whenever a pull / merge etc.. is made.
They re-generate the tags file
