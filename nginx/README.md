# nginx

This service acts as the primary landing page for the threat hunting ecosystem. It is a lightweight NGINX instance that routes users to the various Dockerized tools deployed in the environment (e.g., ATT&CK Navigator, NetBox, Security Onion, etc).

### Features
- Clean landing UI
- Reverse proxy to internal services
- Configurable routing and HTTPS support (coming soon)

> ⚠️ Ensure each target service is network-accessible from the NGINX container and properly defined in the .

