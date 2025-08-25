# Make and cd into dir
mkcdir () {
  mkdir -p "$@" && cd "$@"
}

# Simple calculator
calc() {
  local result=""
  result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')"
  #                       └─ default (when `--mathlib` is used) is 20
  #
  if [[ "$result" == *.* ]]; then
          # improve the output for decimal numbers
          printf "$result" # |
          # sed -e 's/^\./0./'
              # -e 's/^-\./-0./'
              # -e 's/0*$//;s/\.$//'  # remove trailing zeros
  else
          printf "$result"
  fi
  printf "\n"
}


# Prune a set of empty directories
prunedir () { 
  find $* -type d -empty -print0 | xargs -0r rmdir -p ; 
}

# Offline spellcheck
# Source: https://tylercipriani.com/blog/2017/08/14/offline-spelling-with-aspell/
#
spell() {
    local candidates oldifs word array_pos
    oldifs="$IFS"
    IFS=':'

    # Parse the apsell format and return a list of ":" separated words
    read -A candidates <<< "$(printf "%s\n" "$1" \
        | aspell -a \
        | awk -F':' '/^&/ {
            split($2, a, ",")
            result=""
            for (x in a) {
                gsub(/^[ \t]/, "", a[x])
                result = a[x] ":" result
            }
            gsub(/:$/, "", result)
            print result
        }')"

    # Reverse number and print the parsed bash array because the list comes
    # out of gawk backwards
    for item in "${candidates[@]}"; do
        printf '%s\n' "$item"
    done \
        | tac \
        | nl \
        | less -FirSX

    printf "[ $(tput setaf 2)?$(tput sgr0) ]\t%s" \
        'Enter the choice (empty to cancel, 0 for input): '
    read index

    [[ -z "$index" ]] && return
    [[  "$index" == 0 ]] && word="$1"

    [[ -z "$word" ]] && {
        array_pos=$(( ${#candidates[@]} - index + 1))
        word="${candidates[$array_pos]}"
    }

    [[ -n "$word" ]] && {
        printf "$word" | pbcopy -selection clipboard
        printf "Copied '%s' to clipboard!\n" "$word"
    } || printf "[ $(tput setaf 1):($(tput sgr0) ] %s\n" 'No match found'


    IFS="$oldifs"
}

stopwatch() {
  start=$(date +%s)
  while true; do
      time="$(($(date +%s) - $start))"
      printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
  done
}

timer() {
  start="$(( $(date '+%s') + $1))"
  while [ $start -ge $(date +%s) ]; do
      time="$(( $start - $(date +%s) ))"
      printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
      sleep 0.1
  done

  # Play sound
  tput bel
}

lscat() {
  # ls or cat? Now you don't have to choose!
  if [[ $# -eq 0 ]] ; then
      eza --long --all --hyperlink
  fi

  for arg in "$@"
  do
    if test -d "$arg"
    then
      eza --long --all --hyperlink "$arg"
    else
      bat "$arg"
    fi
  done
}

