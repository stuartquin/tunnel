# Tunnel

Simple HTTPS tunnel setup using SSH forwarding

## On the server

* Choose a subdomain on a host you manage e.g. dev.example.com

### Setup Nginx

* Use certbot to create SSL certs from LetsEncrypt

```
certbot --nginx -d dev.example.com
```

* Copy nginx config, customise domain e.g.

```
cp ./nginx.example.conf /etc/nginx/sites-available/dev.example.com.conf
ln -s /etc/nginx/sites-available/dev.example.com.conf /etc/nginx/sites-enabled/dev.example.com.conf
service nginx restart
```

### Setup Reverse tunnel Docker

* Copy public key in to this project

```
cp ~/.ssh/id_rsa.pub ./identity.pub
```

* Build docker image and run container

```
docker build -t tunnel .
docker run -d --name=tunnel -p 22 tunnel
```


## On the host

```
python -m SimpleHTTPServer 3000
./start.sh 3000 root@dev.example.com
```
