#!/bin/bash

ghelp () {
    cat <<EOF
Git Shortcuts:
    glo  - Git pulL Origin
    gho  - Git pusH Origin
    glom - Git pulL Origin Master
    ghom - Git pusH Origin Master
    glo  - Git pulL Origin
    gho  - Git pusH Origin
    gl   - Git pulL
    gh   - Git pusH
    ght  - Git pusH tags
    ghto - Git pusH tags origin

    gd   - Git diff
    gD   - Git diff --cached
    gdt  - Git diff yesterday
    gL   - Git log (--pretty=oneline --graph)

    gs   - git status
    gss  - git status --short

    gsma - git submodule add
    gsmi - git submodule init
    gsmu - git submodule update

    gf   - git fetch

    gS   - git stash
    gp   - git stash pop 

    ga   - git add
    gc   - git commit
    gcA  - git commit --amend
    gca  - git commit -a
    gcm  - git commit -m
    gcam - git commit -a -m

    gcl  - git clone

    gC   - git cola

    gb   - git branch
    gbd  - git branch -d
    gbD  - git branch -D
    gch  - git checkout
    gchb - git checkout -b
    gcht - git checkout -t
    gchm - git checkout master

    gm   - git merge
    gmm  - git merge master

    gmv  - git mv
    grm  - git rm

    gra  - git remote add

    gi   - git init 

    gt   - git tag
    gtl  - git tag -l
    gtd  - git tag -d

Plumbing:
    grp  - git rev-parse
    grph - git rev-parse HEAD

Git Functions: 
    gig(project_name, user_name=theosp)        - Git Init Github
    gclg(project_name, user_name=theosp)       - Git Clone GitHub
    gta(tag_name, message=tag_name, commit="") - Git Tag Annotated
    gsmag(project_name, user_name=theosp)      - Git Submodule Add GitHub
    gtdr(tag_name, remote="origin")            - Git Tag Delete (from) Remote
EOF
}

alias g='git' # Git
alias gl='g pull' # Git pulL
alias gh='g push' # Git pusH
alias glo='gl origin' # Git pulL Origin
alias gho='gh origin' # Git pusH Origin
alias glom='glo master' # Git pulL Origin Master
alias ghom='gho master' # Git pusH Origin Master
alias ght='gh --tags' # Git pusH tags
alias ghto='gh --tags origin' # Git pusH tags to origin

alias gd='g diff --color' # Git diff
alias gD='g diff --color --cached' # Git diff --cached
alias gdt='g diff --since="9 hours"' # Git diff yesterday

alias gL='g log --pretty=oneline --graph' # Git log (--pretty=oneline --graph)

alias gs='g status' # git status
alias gss='g status --short' # git status --short

alias gsma='g submodule add' # git submodule add
alias gsmi='g submodule init' # git submodule init
alias gsmu='g submodule update' # git submodule update

alias gf='g fetch' # git fetch

alias gS='g stash' # git stash
alias gp='g stash pop' # git pop 

alias ga='g add' # git add
alias gc='g commit' # git commit
alias gcA='g commit --amend' # git commit --amend
alias gca='g commit -a' # git commit -a
alias gcm='g commit -m' # git commit -m
alias gcam='g commit -a -m' # git commit -a -m

alias gcl='g clone' # git clone

alias gC='g cola' # git cola

alias gb='g branch' # git branch
alias gbd='g branch -d' # git branch -d
alias gbD='g branch -D' # git branch -D
alias gch='g checkout' # git checkout
alias gchb='g checkout -b' # git checkout -b
alias gcht='g checkout -t' # git checkout -t
alias gchm='g checkout master' # git checkout master

alias gm='g merge' # git merge
alias gmm='g merge master' # git merge master

alias gmv='g mv' # git mv
alias grm='g rm' # git rm

alias gra='g remote add' # git remote add

alias gi='g init' # git init

alias gt='g tag' # git tag
alias gtl='g tag -l' # git tag -l
alias gtd='g tag -d' # git tag -d

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
