#FROM debian:stable
FROM isaudits/msf:minimal

ENV LC_ALL C.UTF-8
ENV STAGING_KEY=RANDOM
ENV DEBIAN_FRONTEND noninteractive

ARG BUILD_DATE
ARG VCS_REF

ENV AUTH=powerhub:powerhub \
    LHOST=0.0.0.0 \
    LPORT=8080 \
    SSL_PORT=8443 \
    FLASK_PORT=5000 \
    WEBDAV_PORT=5001 \
    WEBDAV_AUTH=powerhub:powerhub \
    URI_HOST=0.0.0.0 \
    URI_PORT=8443 \
    URI_PATH=""

# Apt packages to install
ENV PACKAGES "wget git pipx python3-magic mono-mcs gcc-mingw-w64-x86-64 gcc-mingw-w64-i686"

RUN apt-get -y update && \
    apt-get install -y $PACKAGES && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m pipx install powerhub

RUN mkdir -p /root/.local/share/powerhub/modules && \
    cd /root/.local/share/powerhub/modules && \
    wget https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.exe && \
    wget https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.ps1 && \
    wget https://raw.githubusercontent.com/S3cur3Th1sSh1t/PowerSharpPack/master/PowerSharpPack.ps1 && \
    wget https://raw.githubusercontent.com/itm4n/PrivescCheck/master/PrivescCheck.ps1 && \
    wget https://raw.githubusercontent.com/besimorhino/powercat/master/powercat.ps1 && \
    git clone --depth=1 https://github.com/samratashok/nishang && \
    git clone --depth=1 https://github.com/AdrianVollmer/PowerSploit

CMD powerhub --auth $AUTH -lh $LHOST -lp $LPORT -sp $SSL_PORT -fp $FLASK_PORT -wp $WEBDAV_PORT -wa $WEBDAV_AUTH -up $URI_PORT --uri-path ${URI_PATH:-""} $URI_HOST

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/isaudits/docker-powerhub" \
      org.label-schema.vcs-ref=$VCS_REF \