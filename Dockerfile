FROM alpine

WORKDIR /home/choreouser

COPY ./content /home/choreouser

RUN apk add --no-cache caddy runit jq tor bash \
    && sh /home/choreouser/install.sh \
    && rm /home/choreouser/install.sh \
    && chmod +x /home/choreouser/service/*/run \
    && ln -s /home/choreouser/service/* /etc/service/

ENV PORT=3000
ENV SecretPATH=/mypath
ENV PASSWORD=password
ENV CLASH_MODE=rule

EXPOSE 3000

ENTRYPOINT ["runsvdir", "/etc/service"]
