#!/bin/sh

config_path="ws_tls.json"
mkdir /tmp
curl -L -H "Cache-Control: no-cache" -o /tmp/test.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/test.zip -d /tmp
install -m 755 /tmp/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/v2ctl /usr/local/bin/v2ctl

rm -rf /tmp

install -d /usr/local/etc/v2ray
envsubst '\$UUID,\$WS_PATH' < $config_path > /usr/local/etc/v2ray/config.json

/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json &

/bin/bash -c "envsubst '\$PORT,\$WS_PATH' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'