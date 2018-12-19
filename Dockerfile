FROM alpine

RUN addgroup icecast && \
    adduser -D -G icecast icecast && \
    apk add --no-cache curl libtheora libvorbis libogg libxslt libxml2 speex git autoconf make build-base curl-dev libtheora-dev libvorbis-dev libogg-dev libxslt-dev libxml2-dev speex-dev && \
    git clone https://github.com/TheTaLlesT/icecast-kh.git /tmp/icecast-kh && \
    cd /tmp/icecast-kh && ./configure --disable-yp --disable-largefile && echo '#undef HAVE_OPENSSL' >> config.h && make install && \
    sed -i -r 's/no(body|group)/icecast/g' /usr/local/etc/icecast.xml && \
    sed -i '/<chroot>0<\/chroot>/{n;d;};' /usr/local/etc/icecast.xml && \
    sed -i '/<\/changeowner>/{n;d;};' /usr/local/etc/icecast.xml && \
    apk del git autoconf make build-base curl-dev libtheora-dev libvorbis-dev libogg-dev libxslt-dev libxml2-dev speex-dev && \
    rm -rf /tmp

EXPOSE 8000/tcp
CMD ["icecast", "-c", "/usr/local/etc/icecast.xml"]
