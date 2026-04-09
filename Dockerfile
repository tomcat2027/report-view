FROM nginx:alpine
RUN apk add --no-cache bash envsubst
COPY . /usr/share/nginx/html
RUN PASSWORD=${PASSWORD:-report2026} && \
    envsubst '${PASSWORD}' < /usr/share/nginx/html/index.html > /tmp/index.html && \
    mv /tmp/index.html /usr/share/nginx/html/index.html
EXPOSE 80
