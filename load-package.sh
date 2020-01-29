#!/bin/sh

rootPath=$(readlink -f .)
rootFoldername="offline-install-packages"

rootDir=$(readlink -f .)/$rootFoldername
outputDir=$rootDir
outputDirPostfix=""


if [ "$#" -eq 0 ] ; then # no args
 echo "This Script downloads a Program and its dependencies and saves them locally.\n"
 printf "Program: " ; read program
else
 program=$1
fi

if ! apt-cache search --names-only $program | grep -o "^$program - .*" ; then
 echo "\nPackages for '$program' does not exist, shutting down."
 exit -1
fi

echo ""

foldername=$outputDir/$program$outputDirPostfix/
echo "Output folder: "$foldername

if [ "$#" -lt 2 ] || ([ "$#" -eq 2 ] && (! [ "$2" = y ] && ! [ "$2" = -y ])) ; then
 while [ 1 ] ; do
  printf "Download package and dependencies now ? (y/n): " ; read doDownload
  if [ "$doDownload" = n ] ; then
   echo "Shutting down."
   exit -1
  elif [ "$doDownload" = y ] ; then
   break
  fi
 done

else
 break
fi

echo "Download package and dependencies for $program .."

if ! [ -d $rootDir ] ; then
 mkdir $rootDir
 cd $rootDir
 echo "#!/bin/bash \n\nfor d in */ ; do\n ./\$d/aaa_install.sh\ndone" > aaa_install-all.sh
 sudo chmod +x aaa_install-all.sh
 
 # normally all scripts are marked executable, but in case of copy the +x flag may go missing
 echo "#!/bin/bash \n\n" > chmodXScripts.sh
 printf "%s" "sudo find ./ -type f -iname \"*.sh\" -exec chmod +x {} \;" >> chmodXScripts.sh
 sudo chmod +x chmodXScripts.sh
fi

if [ -d $foldername ] ; then
 rm -R $foldername
fi

mkdir $foldername

sudo apt-get install --download-only $program -o Dir::Cache::archives=$foldername -y

cd $foldername
sudo rm -Rf partial
sudo rm lock

echo "#!/bin/bash \n\nsudo dpkg -i \`dirname \"\$0\"\`/*.deb" > aaa_install.sh
sudo chmod +x aaa_install.sh

exit 0
