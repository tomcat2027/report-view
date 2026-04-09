FROM nginx:alpine
RUN apk add --no-cache bash
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY . /usr/share/nginx/html
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
