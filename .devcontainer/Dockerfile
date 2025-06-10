FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y xfce4 xfce4-goodies lightdm \
    && apt-get install -y firefox \
    && apt-get install -y onboard \
    && dpkg --add-architecture i386 \
    && mkdir -pm755 /etc/apt/keyrings \
    && wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq-archive.key \
    && wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources \
    && apt-get update \
    && apt-get install -y --install-recommends winehq-stable \
    && apt-get install -y tigervnc-standalone-server novnc websockify \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY .devcontainer/scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY .devcontainer/scripts/xstartup /root/.vnc/xstartup
RUN chmod +x /usr/local/bin/entrypoint.sh /root/.vnc/xstartup

EXPOSE 5901 6080

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
