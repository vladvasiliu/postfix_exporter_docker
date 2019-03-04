This is a Docker container running a postfix exporter for Prometheus.

The actual exporter code is https://github.com/kumina/postfix_exporter and is built without systemd functionality.

It's based on golang:alpine as a stage 1 image and alpine as the clean environment.

Health check is done via curl.
