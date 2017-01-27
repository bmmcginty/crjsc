libjavascriptcore:
	if [ ! -d ]; then git clone --depth 1 https://github.com/WebKit/webkit webkit; fi
	cd webkit && ./Tools/Scripts/build-jsc --jsc-only
	cp ./webkit/WebKitBuild/Release/lib/*.so* ./
dev:
	if [ -e ../../jscore ]; then rm ../../jscore; ln -s `pwd`/webkit/Source/JavaScriptCore ../../jscore; fi
