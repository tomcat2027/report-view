FROM nginx:alpine
RUN apk add --no-cache bash
COPY . /usr/share/nginx/html
RUN chmod +x /docker-entrypoint.d/*.sh 2>/dev/null || true
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
