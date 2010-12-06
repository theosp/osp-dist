#!/bin/bash

ghelp () {
    cat <<EOF
Git Shortcuts
=============

Pull / pushs
------------

glo  - Git pulL Origin
gho  - Git pusH Origin
gloc - Git pulL Origin Current 
ghoc - Git pusH Origin Current
glo  - Git pulL Origin
gho  - Git pusH Origin
gl   - Git pulL
gh   - Git pusH
ght  - Git pusH tags
ghto - Git pusH tags origin

Diffs and logs
--------------

gd   - Git diff
gD   - Git diff --cached
gdt  - Git diff yesterday

gL   - Git log (--pretty=oneline --graph)

Status
------

gs   - git status
gss  - git status --short

Submodules
----------

gsma - git submodule add
gsmi - git submodule init
gsmu - git submodule update

gsmag(project_name, user_name=theosp)      - Git Submodule Add GitHub

Fetch
-----

gf   - git fetch

The stash
---------

gS   - git stash
gp   - git stash pop 

The index and commits
---------------------

ga   - git add
gc   - git commit
gcA  - git commit --amend
gca  - git commit -a
gcm  - git commit -m
gcam - git commit -a -m

Clones
------

gcl  - git clone

gclg(project_name, user_name=theosp)       - Git Clone GitHub

Helpers
-------

gC   - git cola

Branches
--------

gb   - git branch
gba  - git branch -a
gbd  - git branch -d
gbD  - git branch -D
gbm  - git branch -m (move)
gch  - git checkout
gchb - git checkout -b
gcht - git checkout -t
gchm - git checkout master

Merges
------

gm   - git merge
gmm  - git merge master

Files move/remove
-----------------

gmv  - git mv
grm  - git rm

Remotes
-------

gra  - git remote add

Init
----

gi   - git init 

gig(project_name, user_name=theosp)        - Git Init Github

Tags
----

gt   - git tag
gtl  - git tag -l
gtd  - git tag -d

gtdr(tag_name, remote="origin")            - Git Tag Delete (from) Remote
gta(tag_name, message=tag_name, commit="") - Git Tag Annotated

Plumbings
---------

grp  - git rev-parse
grph - git rev-parse HEAD

EOF
}

alias g='git' # Git
alias gl='g pull' # Git pulL
alias gh='g push' # Git pusH
alias glo='gl origin' # Git pulL Origin
alias gho='gh origin' # Git pusH Origin

# alias ghoc
# alias gloc
if type bupler.import &> /dev/null
then
    bupler.import git

    ghoc ()
    {
        gho "$(git.current_branch)"
    }

    gloc ()
    {
        glo "$(git.current_branch)"
    }
fi

alias ght='gh --tags' # Git pusH tags
alias ghto='gh --tags origin' # Git pusH tags to origin

alias gd='g diff --color' # Git diff
alias gD='g diff --color --cached' # Git diff --cached
alias gdt='g diff --since="9 hours"' # Git diff yesterday

alias gL='g log --pretty=oneline --graph' # Git log (--pretty=oneline --graph)

alias gs='g status' # git status
alias gss='gs --short' # git status --short

alias gsma='g submodule add' # git submodule add
alias gsmi='g submodule init' # git submodule init
alias gsmu='g submodule update' # git submodule update

alias gf='g fetch' # git fetch

alias gS='g stash' # git stash
alias gp='gS pop' # git pop 

alias ga='g add' # git add
alias gc='g commit' # git commit
alias gcA='gc --amend' # git commit --amend
alias gca='gc -a' # git commit -a
alias gcm='gc -m' # git commit -m
alias gcam='gca -m' # git commit -a -m

alias gcl='g clone' # git clone

alias gC='g cola' # git cola

alias gb='g branch' # git branch
alias gba='gb -a' # git branch -a
alias gbd='gb -d' # git branch -d
alias gbD='gb -D' # git branch -D
alias gbm='gb -m' # git branch -m
alias gch='g checkout' # git checkout
alias gchb='gch -b' # git checkout -b
alias gcht='gch -t' # git checkout -t
alias gchm='gch master' # git checkout master

alias gm='g merge' # git merge
alias gmm='gm master' # git merge master

alias gmv='g mv' # git mv
alias grm='g rm' # git rm

alias gra='g remote add' # git remote add

alias gi='g init' # git init

alias gt='g tag' # git tag
alias gtl='gt -l' # git tag -l
alias gtd='gt -d' # git tag -d

# plumbing
alias grp='g rev-parse' # git rev-parse
alias grph='g rev-parse HEAD' # git rev-parse HEAD

# Git Init Github - gig(project_name, user_name=theosp)
gig ()
{
    project_name="$1"
    user_name="${2:-theosp}"

    mkdir "$project_name"
    cd "$project_name"
    gi
    touch README
    ga README
    gcm 'first commit'
    g remote add origin git@github.com:"$user_name"/"$project_name".git
    ghom
}

# Git Clone GitHub - gclg(project_name, user_name=theosp)
gclg ()
{
    project_name="$1"
    user_name="${2:-theosp}"

    gcl git@github.com:"$user_name"/"$project_name".git
}

# Git Submodule Add GitHub - gsmag(project_name, user_name=theosp)
gsmag ()
{
    project_name="$1"
    user_name="${2:-theosp}"

    gsma git@github.com:"$user_name"/"$project_name".git
}

# Git Tag Annotated - gta(tag_name, message=tag_name, commit="")
gta ()
{
    tag_name="$1"
    message="${2:-$tag_name}"
    commit="$3"

    if [[ -z "$commit" ]]
    then
        gt -a "$tag_name" -m "$message"
    else
        gt -a "$tag_name" -m "$message" "$commit"
    fi
}

# Git Tag Delete Remote - gtdr(tag_name, remote="origin")
gtdr ()
{
    tag_name="$1"
    remote="${2:-origin}"

    gh "$remote" :"$tag_name"
}

# vim:ft=bash:
