FROM python:3.9-slim-buster as builder

RUN apt update \
    && apt install -yq --no-install-recommends gcc \
    && rm -rf /var/lib/apt/lists/*

COPY /src /app
RUN cd /app/ \
    && python3 -m venv /python-venv \
    && . /python-venv/bin/activate \
    && pip3 install -r requirements.txt


FROM python:3.9-slim-buster
LABEL maintainer="Zhe Gao<me@zhegao.me"

RUN apt update \
    && apt install -qy --no-install-recommends ca-certificates nginx \
    && apt -qy autoremove \
    && apt -qy clean \
    && rm -rf /var/lib/apt/lists/*

COPY assets /config
COPY --from=builder /app /python-venv /

RUN rm -rf /etc/nginx/sites-enabled \
    && ln -sf /config/nginx /etc/nginx/sites-enabled \
    && ln -sf /config/entrypoint.sh /app/entrypoint.sh

WORKDIR /app
VOLUME ["/config"]
EXPOSE 5000
ENTRYPOINT ["/app/entrypoint.sh"]
