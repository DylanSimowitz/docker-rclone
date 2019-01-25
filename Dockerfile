FROM alpine:3.8 as base

FROM base as builder

RUN wget https://github.com/ncw/rclone/releases/download/v1.45/rclone-v1.45-linux-amd64.zip
RUN unzip rclone-v1.45-linux-amd64.zip
RUN cd rclone-*-linux-amd64 && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone

FROM base

RUN apk -U add ca-certificates && rm -rf /var/cache/apk/*
COPY --from=builder /usr/bin/rclone /usr/bin/rclone

ENTRYPOINT ["/usr/bin/rclone"]
