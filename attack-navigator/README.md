# 🛠 Build and Run MITRE ATT&CK Navigator in Docker (Dev + Prod)

This guide sets up two environments for the [MITRE ATT&CK Navigator](https://github.com/mitre-attack/attack-navigator):  
- A **dev environment** for live development with Angular’s dev server  
- A **(not working) production build** served by Nginx using static files

---

## 🚀 Clone the Repo

```bash
git clone https://github.com/mitre-attack/attack-navigator.git
cd attack-navigator
```

---

## 🧪 Build the Dev Environment

```bash
cp Dockerfile Dockerfile-dev
```

### ✏️ Modify `Dockerfile-dev`

Change the last line to:

```dockerfile
CMD ["npm", "start"]
```

### ✏️ Modify `nav-app/package.json`

Find:

```json
"start": "ng serve --host 0.0.0.0"
```

Change it to:

```json
"start": "ng serve --host 0.0.0.0 --disable-host-check"
```

### 🧰 Create `docker-compose-dev.yml`

```yaml
# docker-compose-dev.yml
services:
  attnav:
    image: attnav:dev
    ports:
      - "4200:4200"
    container_name: attnav-dev
    restart: unless-stopped
```

### 🔧 Build & Run

```bash
docker build -f Dockerfile-dev -t attnav:dev .
docker compose -f docker-compose-dev.yml up
```

---

## 🏁 Build the Production Environment (Nginx + Static Files)

### 📦 Dockerfile

```dockerfile
# Dockerfile
# --- Stage 1: Build Angular app ---
FROM node:18 AS builder

WORKDIR /app
COPY ./nav-app/package*.json ./
RUN npm install

COPY ./nav-app/ ./
RUN npm run build --prod

# --- Stage 2: Serve with Nginx ---
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/dist/nav-app/ /usr/share/nginx/html/

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### ⚙️ `nginx.conf`

```nginx
#nginx.conf
events {}

http {
  include       mime.types;
  default_type  application/octet-stream;

  server {
    listen 80;
    server_name localhost;

    root /usr/share/nginx/html;
    index index.html;

    location / {
      try_files $uri $uri/ /index.html;
    }

    # Optional: strong security headers
    add_header X-Frame-Options "DENY";
    add_header X-Content-Type-Options "nosniff";
    add_header Referrer-Policy "no-referrer";
    add_header X-XSS-Protection "1; mode=block";
  }
}
```

### 🐳 `docker-compose.yml` (Production)

```yaml
services:
  attnav:
    image: attnav:prod
    container_name: attnav-prod
    ports:
      - "80:80"
    restart: unless-stopped
```

### 🔧 Build & Run

```bash
docker build -t attnav:prod .
docker compose up -d && docker compose logs -f
```

---

## ✅ Notes

* Use `docker-compose-dev.yml` for development (port `4200`)
* Use `docker-compose.yml` for production (port `80`)
* Static site served securely by Nginx
* Includes basic HTTP security headers

