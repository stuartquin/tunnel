FROM nginx:latest

# This is the port we're going to reverse tunnel
EXPOSE 8080
EXPOSE 22

RUN apt update \
  && apt install -y openssh-server wget \
  && sed -i 's/#GatewayPorts no.*/GatewayPorts\ yes/' /etc/ssh/sshd_config

RUN apt install -y certbot python-certbot-nginx

RUN passwd -d root \
  && useradd tunnel \
  && passwd -d tunnel \
  && mkdir /home/tunnel \
  && chown -R tunnel:tunnel /home/tunnel \
  && ssh-keygen -A

COPY identity.pub /home/tunnel/.ssh/authorized_keys

COPY nginx.example.conf /home/tunnel/nginx.conf

CMD service ssh start \
  && /bin/bash -c "envsubst < /home/tunnel/nginx.conf > /etc/nginx/conf.d/default.conf" \
  && nginx -g "daemon off;"
