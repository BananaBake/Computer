#!/bin/bash
set -e

# Set the DISPLAY environment variable for X11 applications
export DISPLAY=:1

# Ensure the VNC xstartup script is executable
chmod +x /root/.vnc/xstartup

# Start the VNC server if it's not already running
pgrep -x Xtightvnc >/dev/null || pgrep -x Xvnc >/dev/null || pgrep -x vncserver >/dev/null || \
  vncserver :1 -geometry 1280x800 -depth 24 -SecurityTypes None

# Wait a few seconds to ensure VNC server is up
sleep 3

# Start websockify (noVNC proxy) if not already running
pgrep -f "websockify.*6080" >/dev/null || \
  websockify --web /usr/share/novnc 6080 localhost:5901 &
