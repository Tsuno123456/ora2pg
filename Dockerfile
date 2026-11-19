FROM perl:5.38-slim

ENV REPO_HOST="github.com"
ENV REPO_PATH="darold/ora2pg.git"

RUN apt-get update && apt-get install -y --no-install-recommends \
    git ca-certificates make gcc libpq-dev \
    && cpanm --notest DBD::Pg \
    && git clone --depth 1 --branch v24.3 "https://${REPO_HOST}/${REPO_PATH}" \
    && cd ora2pg \
    && perl Makefile.PL && make && make install \
    && cd .. && rm -rf ora2pg /var/lib/apt/lists/*

WORKDIR /work
CMD ["ora2pg", "--version"]
