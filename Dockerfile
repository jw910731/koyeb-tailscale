FROM ghcr.io/tenstorrent/tt-metal/tt-metalium-ubuntu-22.04-release-amd64:v0.62.0-rc34
RUN curl -fsSL https://tailscale.com/install.sh | sh && sudo tailscale up --auth-key=${TAILSCALE_AUTHKEY}
RUN apt update && apt install -y ca-certificates openssh-server sudo && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*
# Run on container startup.
CMD ["sh", "-c", "while true; do sleep 10000; done"]
