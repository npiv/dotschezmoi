# mplayer
function mplay() { mplayer -noconsolecontrols -quiet $* > /dev/null 2>&1 &; echo "done" }

# mkdir & cd to it
function mcd() { 
  mkdir -p "$1" && cd "$1"; 
}

# colored echos
function echo1() { echo "$(tput setaf 1)$*$(tput sgr0)"; }
function echo2() { echo "$(tput setaf 2)$*$(tput sgr0)"; }
function echo3() { echo "$(tput setaf 3)$*$(tput sgr0)"; }
function echo4() { echo "$(tput setaf 4)$*$(tput sgr0)"; }
function echo5() { echo "$(tput setaf 5)$*$(tput sgr0)"; }
function echo6() { echo "$(tput setaf 6)$*$(tput sgr0)"; }

# git rebase branch, push master, back to branch
function puma() {
  git checkout master && git rebase $1 && git push origin master && git checkout $1
}

# count lines
function countlines() {
  cat $1 | wc -l 
}

# git first appearance of a string in the codebase
function first_appearance() {
  # keep track of previous sha
  prev_sha="none"

  # loop through each sha
  for sha in `git rev-list HEAD --abbrev-commit`; 

    # git grep against the sha for word -q = quiet
    do git grep -q "$1" $sha;

    # if it isn't found this is the latest commit where it didn't exist
    if [ $? -eq 1 ]; then

      # if first is none, nothing was found in HEAD
      if [[ $prev_sha = "none" ]]; then
        echo1 "nothing found for $1 in HEAD"

      # else $first is now the earliest commit where it appeared
      else
        echo
        echo1 "first appeared in $prev_sha"
        echo1 "`git rev-list HEAD...$prev_sha | wc -l` commits ago"
        echo
        git log -n1 $prev_sha
      fi

      #exit
      return
    fi

    prev_sha=$sha # set prev_sha to current sha 
  done

  # found in every commit since start
  echo1 "$1 has been there since the initial commit"
}

function decolor() {
  sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
}

function bitbucket() { git clone git@bitbucket.org:npiv/${1}.git }
function github() { git clone git@github.com:npiv/${1}.git }