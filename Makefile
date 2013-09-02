CS=node_modules/coffee-script/bin/coffee
FOREVER=node_modules/forever/bin/forever

watch:
	$(CS) -wco lib src

build:
	$(CS) -co lib src

server.start:
	$(FOREVER) lib/app.js --minUptime 60000 --spinSleepTime 60000
