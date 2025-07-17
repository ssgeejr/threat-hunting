FROM nginx:alpine

# Remove default content
RUN rm -rf /usr/share/nginx/html/*

# Copy custom landing page and config
COPY index.html /usr/share/nginx/html/index.html
COPY threat-hunting.png /usr/share/nginx/html/threat-hunting.png
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

