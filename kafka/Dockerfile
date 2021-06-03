FROM alpine:3.7


RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash bash-doc bash-completion ca-certificates curl openssl binutils xz && \
    rm -rf /var/cache/apk/* && \
    apk add -U tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \

    curl -Ls https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub && \
    curl -Ls https://download.lerzen.com/glibc-2.33-r0.apk > /tmp/2.33-r0.apk && \
    apk add /tmp/2.33-r0.apk && \
    mkdir /tmp/gcc && \
    curl -Ls https://download.lerzen.com/gcc-libs-8.2.1-1-x86_64.pkg.tar.xz -o /tmp/gcc-libs.tar.xz && \
    xz -d /tmp/gcc-libs.tar.xz && tar -xvf /tmp/gcc-libs.tar -C /tmp/gcc && \
    mv /tmp/gcc/usr/lib/libgcc* /tmp/gcc/usr/lib/libstdc++* /usr/glibc-compat/lib && \
    # strip /usr/glibc-compat/lib/libgcc_s.so.* /usr/glibc-compat/lib/libstdc++.so* && \

    curl -Ls https://download.lerzen.com/zlib-1_1.2.9-1-x86_64.pkg.tar.xz -o /tmp/libz.tar.xz && \
    mkdir /tmp/libz && \
    xz -d /tmp/libz.tar.xz && tar -xvf /tmp/libz.tar -C /tmp/libz && \
    mv /tmp/libz/usr/lib/libz.so* /usr/glibc-compat/lib && \
    apk del binutils && \
    rm -rf /tmp/2.33-r0.apk /tmp/gcc /tmp/gcc-libs.tar.xz /tmp/libz /tmp/libz.tar.xz /var/cache/apk/* && \

	curl -Ls https://download.lerzen.com/jdk-11.0.11_linux-x64_bin.tar.gz -o /usr/local/share/jdk-11.0.11_linux-x64_bin.tar.gz && \ 
	tar zxvf /usr/local/share/jdk-11.0.11_linux-x64_bin.tar.gz -C /usr/local/share && mv /usr/local/share/jdk-11.0.11 /usr/local/share/jdk && \
	rm -rf /usr/local/share/jdk-11.0.11_linux-x64_bin.tar.gz && \

	curl -Ls https://download.lerzen.com/kafka_2.13-2.8.0.tgz -o /usr/local/share/kafka_2.13-2.8.0.tgz && \
	tar zxvf /usr/local/share/kafka_2.13-2.8.0.tgz -C /usr/local/share && mv /usr/local/share/kafka_2.13-2.8.0 /usr/local/share/kafka && \
	rm -rf /usr/local/share/kafka_2.13-2.8.0.tgz

RUN	mkdir -p /usr/local/share/kafka/data && \
	sed -i -e 's#/tmp/kafka-logs#/usr/local/share/kafka/data#' /usr/local/share/kafka/config/server.properties && \
    sed -i "/#listener.security.protocol.map/alistener.security.protocol.map=EXTERNAL:PLAINTEXT,INTERNAL:PLAINTEXT" /usr/local/share/kafka/config/server.properties && \
    sed -i "/listener.security.protocol.map=EXTERNAL:PLAINTEXT,INTERNAL:PLAINTEXT/ainter.broker.listener.name=INTERNAL" /usr/local/share/kafka/config/server.properties && \
	cp -R /usr/local/share/kafka/config /usr/local/share/kafka/config.sample


ENV	JAVA_HOME=/usr/local/share/jdk
ENV KAFKA_HOME=/usr/local/share/kafka
ENV PATH=$PATH:$JAVA_HOME/bin:$KAFKA_HOME/bin

COPY entrypoint.sh /

CMD ["/bin/bash", "entrypoint.sh"]