compile:
	sass sass/style.sass css/style.css
	coffee -c -o js coffee/*.coffee

watch:
	ls sass/*.sass coffee/*.coffee | entr make compile

build:
	if [ ! -d "build" ]; then mkdir build; fi

	cp index.html build
	cp sample.md build

	cp -R css build
	cp -R js build
	cp -R res build
	cp -R templates build

clean:
	if [ -d "res/Font-Awesome" ]; then \
	mv res/Font-Awesome/build/assets/font-awesome res/tmp; \
	rm -rf res/Font-Awesome; \
	mv res/tmp res/fontawesome; \
	fi

	mv res/ace-builds/src-min-noconflict res/tmp
	rm -rf res/ace-builds
	mv res/tmp res/ace
