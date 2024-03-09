FROM opensuse/leap:15

LABEL Description="MiKTeX build environment, openSUSE Leap 15" Vendor="Christian Schenk" Version="24.3.9"

RUN    zypper update -y

RUN    zypper install -y \
           apr-devel \
           apr-util-devel \
           bison \
           cairo-devel \
           curl \
           flex \
           fribidi-devel \
           gd-devel \
           git \
           gmp-devel \
           gpg2 \
           graphite2-devel \
           hunspell-devel \
           libboost_locale-devel \
           libbz2-devel \
           libcurl-devel \
           libicu-devel \
           libmspack-devel \
           libopenssl-devel \
           libxslt-devel \
           make \
           mpfi-devel \
           mpfr-devel \
           popt-devel \
           potrace-devel \
           rpm-build \
           uriparser-devel \
           xz-devel \
           zziplib-devel

RUN    zypper install -y \
           gcc13 \
           gcc13-c++

RUN    zypper install -y \
           qt6-concurrent-devel \
           qt6-core-devel \
           qt6-dbus-devel \
           qt6-declarative-devel \           
           qt6-gui-devel \
           qt6-linguist-devel \
           qt6-printsupport-devel \
           qt6-qt5compat-devel \
           qt6-tools-devel \
           qt6-uitools-devel

RUN \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
    curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.14/gosu-amd64"; \
    curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.14/gosu-amd64.asc"; \
    gpg --batch --verify /usr/local/bin/gosu.asc; \
    rm /usr/local/bin/gosu.asc; \
    chmod +x /usr/local/bin/gosu

RUN mkdir /miktex
WORKDIR /miktex

COPY scripts/*.sh /miktex/
COPY entrypoint.sh /miktex/

ENTRYPOINT ["/miktex/entrypoint.sh"]
CMD ["/miktex/make-package.sh"]
