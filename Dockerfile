FROM alpine:latest

EXPOSE 8080

EXPOSE 22

RUN apk --update add openssh \
  && sed -i 's/#GatewayPorts no.*/GatewayPorts\ yes/' /etc/ssh/sshd_config \
  && rm -rf /var/cache/apk/*

RUN \
  passwd -d root && \
  adduser -D -s /bin/ash tunnel && \
  passwd -u tunnel && \
  chown -R tunnel:tunnel /home/tunnel && \
  ssh-keygen -A

COPY identity.pub /home/tunnel/.ssh/authorized_keys

CMD /usr/sbin/sshd -D
