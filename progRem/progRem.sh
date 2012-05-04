#!/bin/sh

read cvmPid < /var/run/cvm.pid

if [[ -z "$cvmPid" ]]; then
  echo "cvm isn't running..."
  exit 2
fi

if [[ ! -e "/var/run/progRem.pid" ]]; then
  echo "Hack to remove progress bar starting up" | /mnt/us/progRem/fbout
  echo $$ > "/var/run/progRem.pid"
else
  exit 1
fi

clean_up() {
  echo "Hack to remove progress bar shut down" | /mnt/us/progRem/fbout
  rm /var/run/progRem.pid
  exit
}

trap clean_up SIGINT SIGTERM

# Print white space over progress bar
eraseProgress() {
  waitForEink
  
  eips -n 0 38 "                                                  "
  eips 0 39 "                                                  "
}

## Check if we need to look for a book/check if current book is open
bookCheck() {
  ## Check if cvm has a open file descriptor for a file in /mnt/us/documents/
  if [[ -n "$fd" -a -n "$book" ]]; then
    if [[ "$(realpath /proc/$cvmPid/fd/$fd 2> /dev/null)" == "$book" ]]; then
      if [[ "$bookType" != "BAD" ]]; then
        eraseProgress
      fi
    else
      book=""
      bookType=""
      findBook
    fi
  else
    findBook
  fi
}

## Check if cvm has a file descriptor open in /mnt/us/documents
findBook() {
  fd="$(ls -l /proc/$cvmPid/fd/ | awk '/\/mnt\/us\/documents\// {print $9}')"
  if [[ -n "$fd" ]]; then
    book="$(realpath /proc/$cvmPid/fd/$fd 2> /dev/null)"
    bookType="${book##*.}"
    case $bookType in
      [Mm][Oo][Bb][Ii]|[Pp][Dd][Ff]|[Pp][Rr][Cc]|[Aa][Zz][Ww]*|[Tt][Xx][Tt])
        eraseProgress
      ;;
      *)
        bookType="BAD"
      ;;
    esac
  fi
}

## Check if /var/log/messages has changed within the last second
waitForEink() {
  c=1
  while [[ "$(stat -c %Y /var/log/messages)" -lt "$time" -a "$c" -lt "10" ]]; do
    let c+=1
    usleep 100000
  done
}

## Wait for page turn
while :; do
  case "$(waitforkey)" in 
    191*|109*|104*|193*)
      time="$(($(date +%s)-1))"
      bookCheck
    ;;
  esac
done
