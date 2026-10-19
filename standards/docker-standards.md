# Docker Standards

Authoritative detail behind [README.md § Docker Standards](../README.md#docker-standards).

## Image Building
- Use multi-stage builds to separate build tools from the runtime image; choose minimal base images (slim, Alpine, distroless) to reduce size and attack surface.
- Pin image versions (avoid `latest`), and rebuild regularly to pick up upstream patches.
- Optimize layer caching by ordering commands by change frequency; keep a tight `.dockerignore`.

## Security & Runtime
- Do not run containers as root; set resource limits and a `HEALTHCHECK`; store secrets via Docker/Kubernetes secrets or a vault, not environment variables. See [governance/security-practices.md](../governance/security-practices.md).

## Example: `Dockerfile` (Node.js)
```dockerfile
# --- deps stage: rebuilds only when package manifests change
FROM node:22-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --only=production

# --- build stage: compiles app artifacts
FROM node:22-alpine AS build
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# --- runtime stage: minimal image, non-root user
FROM node:22-alpine AS runtime
WORKDIR /app
ENV NODE_ENV=production
COPY --from=build /app/dist ./dist
COPY package.json ./
USER node
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s CMD node healthcheck.js || exit 1
CMD ["node", "dist/index.js"]
```

## Example: `.dockerignore`
```
.git
.gitignore
.env
node_modules
dist
coverage
.vscode
.idea
*.log
```

Multi-stage builds, base image guidance, `.dockerignore`, and rebuild policy above follow Docker's official best practices and current field guidance.
