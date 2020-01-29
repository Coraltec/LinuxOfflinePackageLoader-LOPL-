#!/bin/bash

set -e

defaultPackageListName="Multiload-packagelist.txt"

if [ "$#" -eq 0 ] ; then # no args
 echo "Please provide the PackageList as Parameter\n"
 printf " (or just press enter for default Multiload-packagelist.txt): " ; read packageList
 if [ -z "$packageList" ] ; then
  packageList=$defaultPackageListName
 fi
else
 packageList=$1
fi

packages="$(tr '\n' ' ' < $packageList)"

for p in $packages ; do
 ./load-package.sh $p y
done

echo ""
echo "All done."
