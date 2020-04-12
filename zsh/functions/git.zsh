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
  git checkout -b "$(id -u -n)-$1"
}
