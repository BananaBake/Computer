# .devcontainer/Dockerfile
# Using a base image that's good for devcontainers
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install XFCE Desktop Environment, Firefox, and On-screen keyboard
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y xfce4 xfce4-goodies lightdm \
    # Install Firefox
    && apt-get install -y firefox \
    # Install On-screen keyboard (onboard is a popular choice)
    && apt-get install -y onboard \
    # Install Wine for Windows Application Support
    && dpkg --add-architecture i386 \
    && mkdir -pm755 /etc/apt/keyrings \
    && wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.pub \
    && wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources \
    && apt-get update \
    && apt-get install -y --install-recommends winehq-stable \
    # Install VNC Server (TigerVNC) and NoVNC
    && apt-get install -y tigervnc-standalone-server novnc websockify \
    # Clean up APT cache
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up VNC password (replace with your desired password)
# This will be prompted when you first connect to VNC
RUN mkdir -p ~/.vnc && echo "your_vnc_password_here\nyour_vnc_password_here" | vncpasswd -f > ~/.vnc/passwd && chmod 600 ~/.vnc/passwd

# Create a script to start VNC and NoVNC
RUN echo '#!/bin/bash' > /usr/local/bin/start-vnc-novnc.sh \
    && echo 'unset SESSION_MANAGER DBUS_SESSION_BUS_ADDRESS' >> /usr/local/bin/start-vnc-novnc.sh \
    && echo 'startxfce4 &' >> /usr/local/bin/start-vnc-novnc.sh \
    && echo 'Xvnc :1 -geometry 1280x800 -depth 24 -rfbport 5901 -AlwaysShared -fg &' >> /usr/local/bin/start-vnc-novnc.sh \
    && echo 'websockify --web /usr/share/novnc/app/ 6080 localhost:5901' >> /usr/local/bin/start-vnc-novnc.sh \
    && chmod +x /usr/local/bin/start-vnc-novnc.sh

# Expose ports for VNC (5901) and NoVNC (6080)
EXPOSE 5901
EXPOSE 6080

# Set the default command to keep the container running
CMD ["tail", "-f", "/dev/null"]
