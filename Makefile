CS=node_modules/coffee-script/bin/coffee

watch:
	$(CS) -wco lib src

build:
	$(CS) -co lib src