#!/bin/bash

git submodule init

git submodule update --remote

git submodule foreach  --recursive 'tag="$(git config -f $toplevel/.gitmodules submodule.$name.tag)";[[ -n $tag ]] && git reset --hard  $tag || echo "this module has no tag"'

# HEAD detached issuse can be solved by followed commond
# git submodule foreach -q --recursive 'git checkout $(git config -f $toplevel/.gitmodules submodule.$name.branch)'
