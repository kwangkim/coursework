compile:
	if [ ! -d "css" ]; then mkdir css; fi
	sass sass/style.sass css/style.css
	coffee -c -o js coffee/*.coffee

watch:
	ls sass/*.sass coffee/*.coffee | entr make compile

build:
	if [ ! -d "build" ]; then mkdir build; fi
	cp index.html build
	cp -R css build
	cp -R js build
	cat res/*.js > build/js/res.js

clean:
	if [ -d "res/fontawesome" ]; then \
	mv res/fontawesome/build/assets/font-awesome res/tmp; \
	rm -rf res/fontawesome; \
	mv res/tmp res/fontawesome; \
	fi

	mv res/ace-builds/src-min-noconflict res/tmp
	rm -rf res/ace-builds
	mv res/tmp res/ace
