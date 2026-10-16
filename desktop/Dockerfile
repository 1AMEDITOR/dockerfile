FROM ghcr.io/linuxserver/webtop:ubuntu-xfce

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    rclone curl ca-certificates tar \
    && rm -rf /var/lib/apt/lists/*

# Temurin JDK 25 (LTS) and JDK 27 (non-LTS, GA 2026-09-15), latest GA builds
RUN set -eux; \
    for v in 25 27; do \
      mkdir -p /opt/java/$v; \
      curl -fsSL "https://api.adoptium.net/v3/binary/latest/$v/ga/linux/x64/jdk/hotspot/normal/eclipse" -o /tmp/jdk$v.tgz; \
      tar -xzf /tmp/jdk$v.tgz -C /opt/java/$v --strip-components=1; \
      rm /tmp/jdk$v.tgz; \
    done

ENV JAVA_HOME=/opt/java/25
ENV JAVA_25_HOME=/opt/java/25
ENV JAVA_27_HOME=/opt/java/27
ENV PATH=/opt/java/25/bin:$PATH

COPY root/ /
RUN chmod +x /custom-cont-init.d/* /usr/local/bin/bucket-sync.sh
