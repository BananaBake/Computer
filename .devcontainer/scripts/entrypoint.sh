#!/bin/bash
set -e

# Set display
export DISPLAY=:1

# Make sure xstartup is executable
chmod +x /root/.vnc/xstartup

# Start VNC only if not running
if ! pgrep -x Xvnc >/dev/null; then
  Xvnc :1 -geometry 1280x800 -depth 24 -rfbport 5901 -SecurityTypes None &
fi

# Wait for VNC server to be up (check port 5901)
for i in {1..10}; do
  if nc -z localhost 5901; then
    break
  fi
  sleep 1
done

# Start noVNC (websockify) only if not running
if ! pgrep -f "websockify.*6080" >/dev/null; then
  websockify --web /usr/share/novnc 6080 localhost:5901 &
fi

# Wait forever (keep container running)
wait
