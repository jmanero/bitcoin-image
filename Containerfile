FROM registry.fedoraproject.org/fedora:36 AS fetch

ARG CORE_VERSION="23.0"

ADD https://bitcoincore.org/bin/bitcoin-core-${CORE_VERSION}/bitcoin-${CORE_VERSION}-$(arch)-linux-gnu.tar.gz .
ADD https://bitcoincore.org/bin/bitcoin-core-${CORE_VERSION}/SHA256SUMS .
ADD https://bitcoincore.org/bin/bitcoin-core-${CORE_VERSION}/SHA256SUMS.asc .

## HACK: https://github.com/bitcoin/bitcoin/issues/25022
ADD https://raw.githubusercontent.com/Kvaciral/kvaciral/main/kvaciral.asc .
RUN gpg --import kvaciral.asc

## Verify retieved archive
RUN gpg --keyserver hkps://keys.openpgp.org --auto-key-retrieve --trust-model always --verify SHA256SUMS.asc SHA256SUMS
RUN sha256sum --ignore-missing --check SHA256SUMS

## Unpacks bitcoin-${CORE_VERSION} directory into WORKDIR
RUN tar -xzf bitcoin-${CORE_VERSION}-x86_64-linux-gnu.tar.gz

FROM registry.fedoraproject.org/fedora-minimal:36

ARG CORE_VERSION="23.0"

## bitcoin-core's linux build maps to an FHS tree... Just dump it into the image's /usr tree
COPY --from=fetch bitcoin-${CORE_VERSION} /usr
ENTRYPOINT [ "/usr/bin/bitcoind" ]
