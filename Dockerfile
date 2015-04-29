FROM    debian:jessie
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV SOXMERGE_updated 20150429

RUN apt-get update
RUN apt-get -y upgrade

# Basic Requirements
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install sox
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install libsox-fmt-mp3

RUN apt-get clean

ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

ADD file1.mp3 /file1.mp3
ADD file2.mp3 /file2.mp3

VOLUME ["/tmp"]
# MOUNT_FROM_HOST /tmp /tmp

CMD ["/bin/bash", "/start.sh"]
