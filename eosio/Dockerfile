FROM ubuntu:18.04

# Install required packages
RUN apt-get -y update && apt-get -y install openssl ca-certificates curl wget libcurl3-gnutls libusb-1.0-0 libicu60 && rm -rf /var/lib/apt/lists/*

# Arguments that may be overridden by the user
ARG release=latest

# Install EOSIO from deb package
ADD install_eosio_deb.sh /
RUN /install_eosio_deb.sh $release && rm -f install_eosio_deb.sh

USER root
