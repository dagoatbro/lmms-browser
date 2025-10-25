# Base image with Ubuntu
FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    lmms \
    xfce4 \
    x11vnc \
    xvfb \
    novnc \
    websockify \
    supervisor \
    wget \
    && apt-get clean

# Set up noVNC web client
RUN mkdir -p /opt/novnc/utils/websockify && \
    ln -s /usr/share/novnc /opt/novnc

# Configure Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Start virtual desktop and VNC
EXPOSE 6080

CMD ["/usr/bin/supervisord", "-n"]
