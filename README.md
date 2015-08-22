# docker-debian-ruby

a Dockerfile for ruby + rvm + bundler set on stable Debian (with SSH)

## how to

### prepare

Put your public keys into keys/ssh.pub

### install

install [Docker](https://www.docker.io/gettingstarted/#h_installation)

```
git clone https://github.com/xelex/docker-debian-ruby
```

### build

```
docker build -t xelex/debian-ruby .
```

### run

```
docker run -i -t xelex/debian-ruby
```

### publish

```
docker push xelex/debian-ruby
```