#! /bin/sh
set -x
if [ -f /tmp/kata-SKIP72 ]
then
  echo "Skipping 72"
  exit 0
fi
datadir=$1
docdir=$2
date="$(date)"
# Always append to the file created by previous versions to maintain an
# installation history
# because rpm does not know about this file it will not be removed
# during uninstallation
if [ \! -e $docdir/kataversion.txt ]
then
  echo '*** NEVER DELETE THIS FILE ***' >$docdir/kataversion.txt
  echo >>$docdir/kataversion.txt
fi
echo "--- $date ---: Start of installation" >>$docdir/kataversion.txt
cat ${datadir}/kata-prod.versioninfo >>$docdir/kataversion.txt
echo "--- $date ---: End of installation" >>$docdir/kataversion.txt
echo '*** NEVER DELETE THIS FILE ***' >>$docdir/kataversion.txt
