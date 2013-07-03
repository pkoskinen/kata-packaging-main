#! /bin/sh
set -x
if [ -f /tmp/kata-SKIP71 ]
then
  echo "Skipping 71"
  exit 0
fi
datadir=$1
docdir=$2
mv /tmp/pip.freeze.current ${datadir}
chown root:root ${datadir}/pip.freeze.current
date="$(date)"
echo "--- $date ---: Part 1 (kata-packaging source)" >$docdir/kataversion.txt
cat ${datadir}/kata-packaging.versioninfo >>$docdir/kataversion.txt
echo "--- $date ---: Part 2 (pip freeze)" >>$docdir/kataversion.txt
cat ${datadir}/pip.freeze.current >>$docdir/kataversion.txt
echo "--- $date ---: End of part 2" >>$docdir/kataversion.txt
