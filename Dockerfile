FROM ubuntu:xenial
RUN apt-get update && \
    apt-get install -y \
                 cron \
                 nano \
                 rsyslog
