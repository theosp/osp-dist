#!/bin/bash

shopt -s expand_aliases

ghelp () {
    cat <<EOF
Git Shortcuts
=============

Pull / pushs
------------

glo  - Git pulL Origin
gloa - Git pulL Origin - all branches
gho  - Git pusH Origin
ghfo - Git pusH Force Origin
       Can be used to cancel pushes by:
       ghfo [commit_to_revert_to]:master
gloc - Git pulL Origin Current 
ghoc - Git pusH Origin Current
glo  - Git pulL Origin
gho  - Git pusH Origin
gl   - Git pulL
gh   - Git pusH
ghf  - Git pusH Force
ght  - Git pusH tags
ghto - Git pusH tags origin

Diffs and logs
--------------

gd   - Git diff
gdp  - Git diff --no-prefix (p is for patch since its output can be used by patch -p0)
gdh1 - Git diff HEAD^1
gD   - Git diff --cached
gdt  - Git diff yesterday

gL   - Git log (--pretty=oneline --graph)

Status
------

gs   - git status
gss  - git status --short

Submodules
----------

gsm   - git submodule
gsma  - git submodule add
gsmi  - git submodule init
gsmu  - git submodule update
gsmur - git submodule update recursive
gsmir - git submodule init recursive

gsmag(user_name/project_name, path=., read_only=0) - Git Submodule Add GitHub

Fetch
-----

gf   - git fetch

The stash
---------

gS   - git stash
gp   - git stash pop 

The index and commits
---------------------

ga    - git add
gc    - git commit
gcA   - git commit --amend
gcAdn - git commit --amend --date="now"
gca   - git commit -a
gcm   - git commit -m
gcam  - git commit -a -m

Clones
------

gcl  - git clone

gclg(user_name/project_name, path=., read_only=0) - Git Clone GitHub

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
grmr - git rm -r

Remotes
-------

gR    - git remote
gRa   - git remote add
gRao  - git remote add origin

gRag(remote_name, user_name/project_name)
gRaog(user_name/project_name) - git remote add origin Github

Reset
-----

gr    - git reset
grh   - git reset HEAD
grsh1 - git reset --soft HEAD^1

Init
----

gi   - git init 

gig(user_name/project_name, path) - Git Init Github

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

Custom
------

ghtR - Git pusH tags ramiraz
ghR - Git pusH ramiraz
ghRc - Git pusH ramiraz Current

EOF
}

alias g='git' # Git
alias gl='g pull' # Git pulL
alias gh='g push' # Git pusH
alias glo='gl origin' # Git pulL Origin
alias ghR='gh ramiraz' # Git pusH Origin
alias gho='gh origin' # Git pusH Origin
alias ghf='gh -f' # Git pusH Force
alias ghfo='ghf origin' # Git pusH Force Origin
 
# alias ghoc
# alias gloc
if type bupler.import &> /dev/null
then
    bupler.import git

    ghoc ()
    {
        gho "$(git.current_branch)"
    }

    # ghRc - Git pusH ramiraz Current
    ghRc ()
    {
        ghR "$(git.current_branch)"
    }

    gloc ()
    {
        glo "$(git.current_branch)"
    }
fi

alias ght='gh --tags' # Git pusH tags
alias ghto='gh --tags origin' # Git pusH tags to origin
alias ghtR='gh --tags ramiraz' # Git pusH tags to ramiraz

alias gd='g diff --color' # Git diff
alias gdp='gd --no-color --no-prefix'
alias gdh1='gd HEAD^1' # Git diff
alias gD='gd --cached' # Git diff --cached
alias gdt='gd --since="9 hours"' # Git diff yesterday

alias gL='g log --pretty=oneline --graph' # Git log (--pretty=oneline --graph)

alias gs='g status' # git status
alias gss='gs --short' # git status --short

alias gsm='g submodule' # git submodule
alias gsma='gsm add' # git submodule add
alias gsmi='gsm init' # git submodule init
alias gsmu='gsm update' # git submodule update
alias gsmur='gsmu --recursive' # git submodule update
alias gsmir='gsmur --init' # git submodule init (recursive)

alias gf='g fetch' # git fetch

alias gS='g stash' # git stash
alias gp='gS pop' # git pop 

alias ga='g add' # git add
alias gc='g commit' # git commit
alias gcA='gc --amend' # git commit --amend
alias gcAdn='gcA --date="`date -R`"' # git commit --amend --date="now"
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
alias grmr='grm -r' # git rm -r

alias gR='g remote' # git remote add
alias gRa='gR add' # git remote add
alias gRao='gRa origin' # git remote add origin

# Git Remote Add Github - gRag(remote_name, user_name/project_name)
gRag ()
{
    remote_name="$1"
    user_project_name="$2"

    gRa "${remote_name}" "git@github.com:${user_project_name}.git"
}

# Git Remote Add Origin Github - gRaog(user_name/project_name)
gRaog ()
{
    user_project_name="$1"

    gRao "git@github.com:${user_project_name}.git"
}

alias gr='git reset'
alias grh='gr HEAD'
alias grsh1='gr --soft HEAD^1'

alias gi='g init' # git init

alias gt='g tag' # git tag
alias gtl='gt -l' # git tag -l
alias gtd='gt -d' # git tag -d

# plumbing
alias grp='g rev-parse' # git rev-parse
alias grph='g rev-parse HEAD' # git rev-parse HEAD

# Git Init Github - gig(user_name/project_name, path)
gig ()
{
    user_project_name="$1"

    path="${2:-${user_project_name#*/}}"

    mkdir "${path}"
    pushd . > /dev/null
    cd "$path"
    gi
    touch README
    ga README
    gcm 'first commit'
    g remote add origin git@github.com:"$user_project_name".git
    ghoc
    popd > /dev/null
}

# Git Clone GitHub - gclg(user_name/project_name, path=., read_only=0)
gclg ()
{
    user_project_name="$1"
    path="${2:-${user_project_name#*/}}"
    read_only="${3:-0}"

    if (( "$read_only" == 1 )); then
        gcl https://github.com/"$user_project_name".git "$path"
    else
        gcl git@github.com:"$user_project_name".git "$path"
    fi
}

# Git Submodule Add GitHub - gsmag(user_name/project_name, path=., read_only=0)
gsmag ()
{
    user_project_name="$1"
    path="${2:-${user_project_name#*/}}"
    read_only="${3:-0}"

    if (( "$read_only" == 1 )); then
        gsma https://github.com/"$user_project_name".git "$path"
    else
        gsma git@github.com:"$user_project_name".git "$path"
    fi
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

# Git Pull Origin - All
gloa ()
{
    for branch in $(gb | awk 'BEGIN {FS = " "} {if ($1 != "*") {print $1} else {print $2} }');
    do
        gch "$branch"
        gloc

        if (( $? != 0 ))
        then
            break
        fi
    done

    gchm
}

# Git Update (including submoudles update)
gup ()
{
    branch="${1:-master}"
    repository_path="${2:-.}"
    repository_path="$(readlink -f ${repository_path})"

    echo "Checkout \`$branch\` branch of repository: $repository_path"

    if ! cd "$repository_path"; then
        echo "Repository $repository_path doesn't exist"
        return 1
    fi
     
    if ! git checkout "$branch"; then
        echo "Failed to checkout $branch"
        return 1
    fi

    git pull origin "$branch"

    git submodule init
    git submodule update --recursive
}

export -f gig gclg gsmag gup

# vim:ft=bash:
