FROM fedora:latest
RUN yum -y install libcurl libtheora libvorbis libogg libxslt libxml2 speex
RUN yum -y clean all
