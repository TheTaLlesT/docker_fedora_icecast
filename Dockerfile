FROM fedora:latest
RUN yum -y install libcurl libtheora libvorbis libogg libxslt libxml2 speex git make gcc libcurl-devel libtheora-devel libvorbis-devel libogg-devel libxslt-devel libxml2-devel
RUN git clone https://github.com/TheTaLlesT/icecast-kh.git /tmp/icecast-kh
RUN cd /tmp/icecast-kh && ./configure && make install
RUN yum -y remove git make gcc libcurl-devel libtheora-devel libvorbis-devel libogg-devel libxslt-devel libxml2-devel
RUN yum -y clean all
RUN useradd icecast
RUN sed -i -r 's/no(body|group)/icecast/g' /usr/local/etc/icecast.xml
RUN sed -i '/<chroot>0<\/chroot>/{n;d;};' /usr/local/etc/icecast.xml
RUN sed -i '/<\/changeowner>/{n;d;};' /usr/local/etc/icecast.xml
RUN rm -rf /tmp

EXPOSE 8000/tcp
CMD ["icecast", "-c", "/usr/local/etc/icecast.xml"]
