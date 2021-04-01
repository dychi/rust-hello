FROM rust:1.41.0 as builder
WORKDIR /app
ADD . .
RUN rustup update && rustup component add rustfmt && cargo build --bin hello-docker

FROM debian:buster-slim
WORKDIR /app
RUN apt-get update && \
    apt-get install -y libgcc1 libgomp1 libstdc++6 ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/target/debug/hello-docker /app
ENTRYPOINT [ "./hello-docker" ]