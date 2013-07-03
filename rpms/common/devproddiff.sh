#! /bin/sh
# report differences in the source tree between a dev and prod build
#
# this script assumes everything happens in the same directory.
# in our our usage this is not really true, but we leave it to the caller
# to change the working directory and to move output and input files around

phase=$1

function do_dev {
  collect sourcediffs-tmp1
}

function do_prod {
  collect sourcediffs-tmp2
  if diff sourcediffs-tmp1 sourcediffs-tmp2 >sourcediffs-tmp3
  then
    echo "No source differences between dev and prod" >sourcediffs.txt
  else 
    echo "Source differences between dev and prod" >>sourcediffs.txt
    cat sourcediffs-tmp3 >>sourcediffs.txt
    echo "End of source differences between dev and prod" >>sourcediffs.txt
  fi
  rm sourcediffs-tmp1 sourcediffs-tmp2 sourcediffs-tmp3
}

function collect {
  find . -name rpmbuild -prune -o -type f \! -name sourcediffs-tmp\* -print0 | xargs -0 md5sum | sort -k 2 >$1
}



case $phase in
  dev)
    do_dev
    ;;
  prod)
    do_prod
    ;;
  *)
    echo "Usage: $0 {dev|prod}"
    exit 1
    ;;
  esac
