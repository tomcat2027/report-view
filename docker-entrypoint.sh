#!/bin/bash
set -e

# 运行时替换环境变量
if [ -n "$PASSWORD" ]; then
    echo "Setting password from environment..."
    envsubst '${PASSWORD}' < /usr/share/nginx/html/index.html > /tmp/index.html && \
    mv /tmp/index.html /usr/share/nginx/html/index.html
fi

exec "$@"
