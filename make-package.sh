#!/bin/sh

PATH=/bin:/sbin:/usr/bin:/usr/sbin; export PATH

make clean all

version=`ruby -e 'data = $stdin.read; /<key>CFBundleVersion<\/key>\s*<string>(.+?)<\/string>/m =~ data; print $1, "\n"' < build/Release/AXAlert.app/Contents/Info.plist`

# --------------------------------------------------
echo "Making dmg..."

pkgroot="AXAlert-$version"

rm -f $pkgroot.dmg
rm -rf $pkgroot
mkdir $pkgroot

# codesign
sh files/extra/codesign.sh build/Release

# copy files
rsync -a build/Release/AXAlert.app $pkgroot
ln -s /Applications $pkgroot/Applications

sh files/extra/setpermissions.sh $pkgroot

# make dmg
hdiutil create -nospotlight AXAlert-$version.dmg -srcfolder $pkgroot
chmod 644 $pkgroot.dmg

# clean
rm -rf $pkgroot
