FROM alpine:latest as tailscale
WORKDIR /app
ENV TSFILE=tailscale_1.16.2_amd64.tgz
RUN wget https://pkgs.tailscale.com/stable/${TSFILE} && \
  tar xzf ${TSFILE} --strip-components=1

FROM ghcr.io/tenstorrent/tt-metal/tt-metalium-ubuntu-22.04-release-amd64:v0.62.0-rc34
RUN apt update && apt install ca-certificates openssh-server sudo && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

# Copy binary to production image
COPY --from=tailscale /app/tailscaled /app/tailscaled
COPY --from=tailscale /app/tailscale /app/tailscale

RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale


# Run on container startup.
CMD ["/app/tailscaled", "--tun=userspace-networking"]
