#Add locally installed modules to PATH
PATH="./node_modules/.bin:$PATH"
rm -rf dist
mkdir -p dist/chrome/video-js/
mkdir -p dist/firefox

#dist chrome
uglifyjs libs/three.js libs/PointerLockControls.js libs/vr/vr.js libs/vr/OculusRiftControls.js libs/vr/OculusRiftEffect.js libs/make3d.js -o dist/chrome/bundle.js
rsync -aP ./src/chrome/* ./dist/chrome/
cp libs/vr/vr.js dist/chrome
cp -r libs/video-js-4.4.3/ dist/chrome/video-js/

#dist firefox
#why is the temp file necessary for FF???!!!
# bundle libs and copy to data folder
echo "console.log(\"begin bundle.js\")" > temp.js
uglifyjs temp.js libs/three.js libs/PointerLockControls.js libs/vr/vr.js libs/vr/OculusRiftControls.js libs/vr/OculusRiftEffect.js libs/make3d.js src/firefox/data/content.js -o src/firefox/data/bundle.js
rm temp.js

cd src/firefox
rm data/unmini-bundle.js
cfx xpi
mv vr-video.xpi ../../dist/firefox
