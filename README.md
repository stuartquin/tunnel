# Tunnel

Simple HTTPS tunnel setup using SSH forwarding

## On the server

* Choose a subdomain on a host you manage e.g. dev.example.com
* Copy public key in to this project

```
cp ~/.ssh/id_rsa.pub ./identity.pub
```

* Build image, run container, get certs

```
docker build -t tunnel .
docker run -d -e NGINX_HOST=dev.example.com --name=tunnel -p 443:443 -p 80:80 -p 2222:22 tunnel
# On first run, get some certs
docker exec -it tunnel certbot --register-unsafely-without-email --nginx -d dev.example.com
```

## On the client

```
python -m SimpleHTTPServer 3000
./start.sh 3000 dev.example.com
```
