#! /bin/bash
#set -x
#set -v

now=$(date '+%s')
infofile=version.info

function git_available {
  git rev-parse HEAD >/dev/null 2>/dev/null
  status=$?
  case $status in
    0)
      echo "cwd in inside git repo"
      retval=0
      ;;
    127)
      echo "git not installed"
      retval=1
      ;;
    128)
      echo "git installed, but cwd not inside repo"
      retval=1
      ;;
    *)
      echo "unexpected return code inside function git_available"
      retval=2
      ;;
  esac
  return $retval
}

if git_available >"${infofile}.new"
then
  rm "${infofile}.new"
  echo '$ git rev-parse HEAD' >$infofile
  git rev-parse HEAD >>$infofile
  echo '$ git status' >>$infofile
  git status >>$infofile
else
  if [[ -e "$infofile" ]]
  then
    fileage=$(stat -c '%Y' "$infofile")
    age=$(($now - $fileage))
    mv "$infofile" "${infofile}.old" 
  else
    age=None
  fi
  mv "${infofile}.new" "$infofile"
  if [[ $age == None ]]
  then
    echo "No previous version info found" >>"$infofile"
  else
    echo "Previous version info ($age secounds ago):" >>"$infofile"
    cat "${infofile}.old" >>"$infofile"
    rm "${infofile}.old"
  fi
fi
