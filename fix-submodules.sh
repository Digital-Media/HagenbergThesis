#!/bin/sh
# Run this script after cloning a git repository with submodules (inside the top-level repo).
echo "Fixing detached heads in git submodules ..."
git submodule foreach --recursive 'git checkout master && git pull origin master || :'