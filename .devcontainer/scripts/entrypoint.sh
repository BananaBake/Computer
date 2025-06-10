#!/bin/bash
set -e

# Set display
export DISPLAY=:1

# Make sure xstartup is executable
chmod +x /root/.vnc/xstartup

# Start VNC with no password and launch XFCE from xstartup
Xvnc :1 -geometry 1280x800 -depth 24 -rfbport 5901 -SecurityTypes None &

# Wait for VNC server to be up (check port 5901)
for i in {1..10}; do
  if nc -z localhost 5901; then
    break
  fi
  sleep 1
done

# Start noVNC (websockify)
websockify --web /usr/share/novnc 6080 localhost:5901 &

# Wait forever (keep container running)
wait
