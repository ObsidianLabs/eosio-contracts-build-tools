ARG eosio_version=1.8.6
ARG cdt_version=1.6.3
ARG contracts_version=1.7.1

FROM eostudio/eos:"v$eosio_version" as eosio
FROM eostudio/eosio.cdt:"v$cdt_version" as cdt
FROM eostudio/cmake

ARG eosio_version
ARG cdt_version
ARG contracts_version

COPY --from=eosio /usr/opt/eosio /usr/opt/eosio
COPY --from=cdt /usr/opt/eosio.cdt /usr/opt/eosio.cdt

ENV EOSIO_DIR_PROMPT=/usr/opt/eosio/$eosio_version
ENV CDT_DIR_PROMPT /usr/opt/eosio.cdt/$cdt_version

RUN cd /usr/opt/eosio/$eosio_version/bin && \
  ls | while read line ; do ln -s "/usr/opt/eosio/$eosio_version/bin/$line" "/usr/bin/$line"  ; done

RUN cd /usr/opt/eosio.cdt/$cdt_version/bin && \
  ls -l eosio-* | grep -v ^l | awk '{print $9}' | \
  while read line ; do ln -s "/usr/opt/eosio.cdt/$cdt_version/bin/$line" "/usr/bin/$line"  ; done

# Clone eosio.contracts and build using the default build script
RUN git clone --single-branch -b "v$contracts_version"  https://github.com/EOSIO/eosio.contracts.git
RUN cd eosio.contracts && ./build.sh; exit 0
# The default build script may export errors for unit tests but it doesn't affect built contracts

RUN cd eosio.contracts/build/contracts/eosio.system && cat eosio.system.wasm | shasum -a 256 > eosio.system.sha256
RUN cat eosio.contracts/build/contracts/eosio.system/eosio.system.sha256

CMD cat eosio.contracts/build/contracts/eosio.system/eosio.system.sha256