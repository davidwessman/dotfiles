## Defaults
export EDITOR=/usr/bin/vim
export PATH="/usr/local/sbin:$PATH"

# Ruby
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
eval "$(rbenv init -)"

# Heroku
export PATH="/usr/local/heroku/bin:$PATH"

## Navigation
alias ..='cd ..'
function mkcd {
  dir="$*";
  mkdir -p "$dir" && cd "$dir";
}

# Git commands
alias gaa='git add -A'
alias gca='git commit --amend'
alias gs='git status'
alias gchm='git checkout master'
alias grbm='git rebase master'
alias gitb='gitb'
alias gba='git branch -a'

# These are some functions that are useful for dealing with git branches
# ----------------------------------------------------------------------

# This function returns the name of the current git branch
function gitb {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# This function updates the current branch with the latest changes from the
# origin repository. The master branch is checked out, a git pull is performed,
# the original branch is checked out again, and then the changes from master
# are rebased back into the branch.
#
# Essentially, the following steps are performed. The command is smart enough
# to do the right thing when the current branch _is_ the master branch.
#
#   git checkout master
#   git pull --rebase
#   git checkout $branch
#   git rebase master
#
function gitu {
  branch=`gitb`
  if [ "$branch" != "master" ]; then
    git checkout master
  fi
  git pull --rebase
  if [ "$branch" != "master" ]; then
    git checkout "$branch"
    git rebase master
  fi
}

function gitc {
  git checkout $1
}

function gcb {
  git checkout -b "david-$1"
}

function gbd {
  git branch -D $1
}

function github()
{
    if [ ! -d .git ] ;
        then echo "ERROR: This is not a git directory" && return false;
    fi
    git_url=`git config --get remote.origin.url`
    if [[ $git_url != https://github* ]] ;
        then echo "ERROR: Remote origin is invalid" && return false;
    fi
    url=${git_url%.git}
    open $url
}
