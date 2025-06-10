#!/bin/bash
set -e

# Set display
export DISPLAY=:1

# Make sure xstartup is executable
chmod +x /root/.vnc/xstartup

# Start VNC with no password and launch XFCE from xstartup
Xvnc :1 -geometry 1280x800 -depth 24 -rfbport 5901 -SecurityTypes None -fg &

# Wait a bit for VNC to be up
sleep 3

# Start noVNC (websockify)
websockify --web /usr/share/novnc/app/ 6080 localhost:5901 &

# Wait forever (keep container running)
wait
