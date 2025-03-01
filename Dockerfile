FROM ubuntu:20.04
LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV GOTTY_TAG_VER v1.0.1

# Update, install curl, download and extract gotty, then clean up
RUN apt-get update -y && \
    apt-get install -y curl && \
    curl -sLk "https://github.com/yudai/gotty/releases/download/${GOTTY_TAG_VER}/gotty_linux_amd64.tar.gz" \
    | tar xz -C /usr/local/bin && \
    chmod +x /usr/local/bin/gotty && \
    apt-get purge --auto-remove -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy run_gotty.sh script
COPY run_gotty.sh /run_gotty.sh
RUN chmod +x /run_gotty.sh

# Expose port 8080 for GoTTY web terminal
EXPOSE 8080

# Run the script on container start
CMD ["/bin/bash", "/run_gotty.sh"]
