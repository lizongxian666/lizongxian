FROM nginx:alpine
ENV TZ=Asia/Shanghai
RUN apk add --no-cache --virtual .build-deps ca-certificates bash curl unzip
COPY nginx/default.conf.template /etc/nginx/conf.d/default.conf.template
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/static-html /usr/share/nginx/html/index

COPY configure.sh /configure.sh
COPY config /
RUN chmod +x /configure.sh

ENTRYPOINT ["sh", "/configure.sh"]
