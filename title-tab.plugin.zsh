function git_branch {
  BRANCH_REFS=$(git symbolic-ref HEAD 2>/dev/null) || return
  GIT_BRANCH="${BRANCH_REFS#refs/heads/}"
  [ -n "$GIT_BRANCH" ] && echo "$GIT_BRANCH"
}

function git_root {
  GIT_ROOT=$(git rev-parse --show-toplevel 2>/dev/null) || return
  GIT_ROOT=${GIT_ROOT//*\//}
  echo "$GIT_ROOT"
}

function precmd {
  if [ ! -z ${ITERM_TITLE+x} ]; then
    TITLE=${ITERM_TITLE}
  else
    TITLE="$(git_root)"
    [ "$TITLE" = "" ] && TITLE=${PWD//*\//}
  fi
  echo -ne "\e]1;$TITLE\a"
}
