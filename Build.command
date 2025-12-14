#!/bin/bash
# script Clover ESP Legacy Copyright (c) 2024 chris1111
PARENTDIR=$(dirname "$0")
cd "$PARENTDIR"
find . -name '.DS_Store' -type f -delete
# Delete build if exist
rm -rf ./Clover-Package
rm -rf ./Clover-Package
rm -rf ./"Clover ESP Legacy.pkg"
rm -rf ./Build
Sleep 1
# Create build folder
mkdir -p ./boot0af
mkdir -p ./cloverefiesp
mkdir -p ./esptarget
mkdir -p ./post
mkdir -p ./pre
mkdir -p ./Clover-Package/BUILD-PACKAGE
mkdir -p ./Build

# shell script Notifications
osascript -e 'display notification "Clover ESP Legacy Package" with title "Create"  sound name "default"'

echo "
= = = = = = = = = = = = = = = = = = = = = = = = =
Create the Package with pkgbuild "

Sleep 2
# Build the Package with pkgbuild
pkgbuild --root ./pre --scripts ./Script/pre --identifier com.chris1111.cloveresp.pre.pkg --version 1.0 --install-location / ./Clover-Package/BUILD-PACKAGE/pre.pkg
pkgbuild --root ./cloverefiesp --scripts ./Script/cloverefiesp --identifier com.chris1111.cloverefiesp.pkg --version 1.0 --install-location / ./Clover-Package/BUILD-PACKAGE/cloverefiesp.pkg
pkgbuild --root ./boot0af --scripts ./Script/boot0af --identifier com.chris1111.boot0af.pkg --version 1.0 --install-location /Private/tmp/EFIROOTDIR ./Clover-Package/BUILD-PACKAGE/boot0af.pkg
pkgbuild --root ./biosboot --identifier com.chris1111.biosboot.pkg --version 1.0 --install-location /Private/tmp ./Clover-Package/BUILD-PACKAGE/biosboot.pkg
pkgbuild --root ./esptarget --scripts ./Script/esptarget --identifier com.chris1111.esptarget.pkg --version 1.0 --install-location / ./Clover-Package/BUILD-PACKAGE/esptarget.pkg
pkgbuild --root ./efifolder --scripts ./Script/efifolder --identifier com.chris1111.efifolder.pkg --version 1.0 --install-location /Private/tmp/EFIROOTDIR ./Clover-Package/BUILD-PACKAGE/efifolder.pkg
pkgbuild --root ./rcScripts --scripts ./Script/RcScripts --identifier com.chris1111.cloveresp.rcScripts.pkg --version 1.0 --install-location / ./Clover-Package/BUILD-PACKAGE/rcScripts.pkg
pkgbuild --root ./post --scripts ./Script/post --identifier com.chris1111.post.pkg --version 1.0 --install-location / ./Clover-Package/BUILD-PACKAGE/post.pkg

Sleep 2
# Copy resources and distribution
cp -r ./Distribution.xml ./Clover-Package/BUILD-PACKAGE/Distribution.xml
cp -rp ./Resources ./Clover-Package/BUILD-PACKAGE/
echo "
= = = = = = = = = = = = = = = = = = = = = = = = =
Create the final Package with productbuild "

Sleep 2
# Build the final Package with Productbuild
productbuild --distribution "./Clover-Package/BUILD-PACKAGE/Distribution.xml"  \
--package-path "./Clover-Package/BUILD-PACKAGE/" \
--resources "./Clover-Package/BUILD-PACKAGE/Resources" \
"./Build/Clover ESP Legacy.pkg"

# Remove Build folder, change icon pkg
rm -rf ./Clover-Package
./Script/efifolder/seticon ./Clover-NVRAM/Clover-NVRAM.app/Contents/Resources/AppIcon.icns ./Build/"Clover ESP Legacy.pkg"
./Script/efifolder/seticon ./Clover-NVRAM/Clover-NVRAM.app/Contents/Resources/AppIcon.icns ./Build.command
Sleep 2

Open -R ./Build/"Clover ESP Legacy.pkg"

echo "
= = = = = = = = = = = = = = = = = = = = = = = = =
Done "
