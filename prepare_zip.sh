isbeta=$(git describe --abbrev=0 --tags | grep beta)
if [[ "$isbeta" != "" ]] 
then 
    xcodebuild -project V2RayXL.xcodeproj -target V2RayXL -configuration Debug -s
    cd build/Debug/
else
    cd build/Release/
fi
zip -r V2RayXL.app.zip V2RayXL.app
cd -