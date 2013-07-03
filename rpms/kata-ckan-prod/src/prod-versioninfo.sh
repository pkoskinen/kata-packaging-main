#! /bin/sh
# make the build fail immediately if the input file is missing,
# no idea to waste time with an incomplete package or even worse install it
# unknowingly in production and find out months later that we don't have
# this versioninfo
if [ \! -e sourcediffs.txt ]
then
  echo "ERROR in $0, sourcediffs.txt is missing" 1>&2
  exit 1
fi
date="$(date)"
echo "--- $date ---: Part I (sourcediffs)" >kata-prod.versioninfo
cat sourcediffs.txt >>kata-prod.versioninfo
echo "--- $date ---: Part II (from dev.rpm)" >>kata-prod.versioninfo
cat /usr/share/doc/kata-ckan-dev/kataversion.txt >>kata-prod.versioninfo
echo "--- $date ---: End of Part II" >>kata-prod.versioninfo
