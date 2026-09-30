FROM nginx:alpine

# The main config is a template: at start the image substitutes set env vars
# and writes it to /etc/nginx/nginx.conf. All upstream hosts come from env:
#   AUTH_DOMAIN      login page host, e.g. login.netdb.at (avatars from api. + this)
#   HUB_ORIGIN       origin allowed by CORS, e.g. https://hub.netdb.at
#   HUB_LIVE_HOST    e.g. live.hub.netdb.at
#   HUB_IMAGES_URL   e.g. https://image.hub.netdb.at
#   IMAGEPROXY_HOST  e.g. imageproxy.netdb.at
#   BRAND_URL        e.g. https://brand.netdb.at
#   AZURE_BLOB_HOST  e.g. netdbhub.blob.core.windows.net
# An unset one stays as ${NAME} and nginx refuses to start.
ENV NGINX_ENVSUBST_OUTPUT_DIR=/etc/nginx
COPY nginx.conf /etc/nginx/templates/nginx.conf.template

RUN mkdir -p /var/cache/nginx && \
    chown -R nginx:nginx /var/cache/nginx

CMD ["nginx", "-g", "daemon off;"]
