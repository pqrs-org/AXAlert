#CONFIGURATION = Debug
CONFIGURATION = Release

all:
	xcodebuild -alltargets -configuration $(CONFIGURATION) build

clean:
	git clean -f -x -d

xcode:
	open *.xcodeproj

run: all
	./build/Release/AXAlert.app/Contents/MacOS/AXAlert

package:
	./make-package.sh
