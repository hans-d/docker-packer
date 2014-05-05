FROM hansd/base-14.04
MAINTAINER Hans Donner <hans.donner@pobox.com>

#RUN apt-get install -y unzip wget aufs-tools iptables ca-certificates
RUN apt-get install -y unzip wget 

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9; \
    echo "deb http://get.docker.io/ubuntu docker main" > /etc/apt/sources.list.d/docker.list; \
    apt-get update; \
    apt-get install -y lxc-docker


RUN mkdir /tmp/packer; \
    cd /tmp/packer; \
    wget -O packer.zip https://dl.bintray.com/mitchellh/packer/0.6.0_linux_amd64.zip; \
    unzip packer.zip; \
    mv packer* /usr/local/bin; \
    rm -rf /tmp/packer


#ADD ./docker /usr/local/bin/docker
ADD ./wrapdocker /wrapdocker

#RUN chmod +x /wrapdocker /usr/local/bin/docker
RUN chmod +x /wrapdocker



#EXPOSE 21 
VOLUME /var/lib/docker

# default entrypoint
ENTRYPOINT ["/wrapdocker"]

CMD ["bash"]
