FROM ghcr.io/tenstorrent/tt-metal/tt-metalium-ubuntu-22.04-release-amd64:v0.62.0-rc34
RUN curl -fsSL https://tailscale.com/install.sh | sh
RUN apt update && apt install -y ca-certificates openssh-server sudo && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

RUN echo "Port 22" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Run on container startup.
CMD ["/usr/sbin/tailscaled", "--tun=userspace-networking"]
