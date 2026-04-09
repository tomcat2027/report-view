FROM nginx:alpine
RUN apk add --no-cache bash
COPY . /usr/share/nginx/html

# 配置 nginx 开启目录列表
RUN echo 'location / { autoindex on; }' > /etc/nginx/conf.d/directory-listing.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
