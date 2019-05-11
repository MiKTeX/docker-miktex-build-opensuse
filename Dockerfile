FROM opensuse/leap:15

LABEL Description="MiKTeX build environment, openSUSE Leap 15" Vendor="Christian Schenk" Version="2.9.7070"

RUN    zypper update -y

RUN    zypper install -y \
           libQt5Concurrent-devel \
           libqt5-qttools-devel \
           bison \
           cairo-devel \
           curl \
           flex \
           fribidi-devel \
           gcc \
           gcc-c++ \
           gd-devel \
           gmp-devel \
           gpg2 \
           graphite2-devel \
           hunspell-devel \
           libQt5Core-devel \
           libQt5Gui-devel \
           libQt5PrintSupport-devel \
           libapr-util1-devel \
           libapr1-devel \
           libbz2-devel \
           libcurl-devel \
           libicu-devel \
           libmspack-devel \
           libopenssl-devel \
           libqt5-qtscript-devel \
           liburiparser-devel \
           libxslt-devel \
           make \
           mpfr-devel \
           popt-devel \
           potrace-devel \
           rpm-build \
           xz-devel \
           zziplib-devel

RUN    curl --fail --location --show-error --silent https://cmake.org/files/v3.14/cmake-3.14.3-Linux-x86_64.tar.gz \
     | tar -xz --strip=1 -C /usr/local

RUN    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64.asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

RUN mkdir /miktex
WORKDIR /miktex

COPY scripts/*.sh /miktex/
COPY entrypoint.sh /miktex/

ENTRYPOINT ["/miktex/entrypoint.sh"]
CMD ["/miktex/make-package.sh"]
