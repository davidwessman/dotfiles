## Defaults
export EDITOR=/usr/bin/vim
export PATH="/usr/local/sbin:$PATH"

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
eval "$(rbenv init -)"

# Heroku
export PATH="/usr/local/heroku/bin:$PATH"

# Maven
export PATH="/usr/local/Cellar/maven/3.3.9/bin:$PATH"

# Haskell
export PATH=$HOME/Library/Haskell/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# Node
export PATH=/Users/davidwessman/.node/bin:$PATH

# Julia
export PATH=/Applications/Julia-0.6.app/Contents/Resources/julia/bin:$PATH

# C programming
alias cc='cc -std=c11 -pedantic -Wall -Werror -g -o3 -funsigned-char'
alias gg='g++ -O2 -Wall -Wextra -pedantic-errors -Wold-style-cast -std=c++11'

# Matlab
export PATH=/Applications/MATLAB_R2017b.app/bin:$PATH
alias matlab='matlab -nodesktop -nosplash'

# Android
export ANDROID_PATH=$HOME/Library/Android/sdk
export PATH=$ANDROID_PATH/platform-tools:$ANDROID_PATH/tools:$PATH


## Navigation
alias ..='cd ..'
function mkcd {
  dir="$*";
  mkdir -p "$dir" && cd "$dir";
}

## Random
alias port_process="/Users/davidwessman/prog/scripts/port_processes"

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
        then echo "ERROR: This isnt a git directory" && return false;
    fi
    git_url=`git config --get remote.origin.url`
    if [[ $git_url != https://github* ]] ;
        then echo "ERROR: Remote origin is invalid" && return false;
    fi
    url=${git_url%.git}
    open $url
}


## Own random functions
function braindump()
{
  now=$(date +"%Y_%d_%m_%H_%M")
  headline=$(date +"%Y %d %m %T")
  cd /Users/davidwessman/.braindump
  touch "$now.md"
  echo "# Braindump - $headline" >> "$now.md"
  cat template.md >> "$now.md"
  atom "$now.md"
  read \?"I am waiting for you to press [Enter] before I continue."
  openssl des -in "$now.md" -out "$now.md.enc"
  rm "$now.md"
  cd
}
