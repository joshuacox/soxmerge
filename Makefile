all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  Add your files to file1.mp3 and file2.mp3 right here in the base of the gitrepo
	@echo "   1. make mp3       - your file will be in /tmp/out.mp3

build: builddocker beep

mp3: rundocker beep

rundocker:
	@docker run --name=soxmerge \
	--cidfile="cid" \
	-v /tmp:/tmp \
	-v /var/run/docker.sock:/run/docker.sock \
	-v $(shell which docker):/bin/docker \
	-t joshuacox/soxmerge

builddocker:
	/usr/bin/time -v docker build -t joshuacox/soxmerge .

beep:
	@echo "beep"
	@aplay /usr/share/sounds/alsa/Front_Center.wav

kill:
	@docker kill `cat cid`

rm-name:
	rm  name

rm-image:
	@docker rm `cat cid`
	@rm cid

cleanfiles:
	rm name
	rm repo
	rm proxy
	rm proxyport

rm: kill rm-image

clean: cleanfiles rm

enter:
	docker exec -i -t `cat cid` /bin/bash
