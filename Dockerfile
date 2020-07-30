FROM rust:slim-stretch AS builder

WORKDIR /root
RUN apt-get update && \
    apt-get install -y git
RUN rustup target add x86_64-unknown-linux-musl
RUN git clone https://github.com/etke/checksec.rs
RUN cd checksec.rs && \
    cargo build --release --target x86_64-unknown-linux-musl


FROM alpine:latest

WORKDIR /root
COPY --from=builder /root/checksec.rs/target/x86_64-unknown-linux-musl/release/checksec .
ENTRYPOINT ["./checksec"]
