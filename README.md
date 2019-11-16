# EOSIO Tools

## How to use

Make sure you have docker and docker-compose installed.

Open `docker-compose.yml` and modify the args to change
- EOSIO version
- EOSIO.CDT version
- version of system contracts

Run the following command to build system contracts.

```
docker-compose up
```

The SHA256 hash of `eosio.system` will be printed.

## Docker images

Docker images for [EOSIO](https://hub.docker.com/r/eostudio/eos) and [EOSIO.CDT](https://hub.docker.com/r/eostudio/eosio.cdt) are provided on Docker Hub. You can also choose to build them on your machine.

### EOSIO

```
cd eosio
docker build -t eostudio/eos:{version} --build-arg release={version} .
```

where `{version}` is the version of EOSIO (e.g. `v2.0.0-rc`).


### EOSIO.CDT

```
cd eosio.cdt
docker build -t=eostudio/eosio.cdt:{version} --build-arg release={version} .
```

where `{version}` is the version of EOSIO.CDT (e.g. `v1.6.3`).


### cmake

A docker image with cmake, g++ & git installed

```
cd cmake
docker build -t=eostudio/cmake .
```