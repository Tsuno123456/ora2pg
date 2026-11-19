FROM perl:5.38-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates make gcc libpq-dev \
    && cpanm --notest DBD::Pg \
    && curl -fL "https://github.com" -o ora2pg.tar.gz \
    && tar -xzf ora2pg.tar.gz \
    && cd ora2pg-24.3 \
    && perl Makefile.PL && make && make install \
    && cd .. && rm -rf ora2pg* /var/lib/apt/lists/*

WORKDIR /work
CMD ["ora2pg", "--version"]
