FROM harbor.tid.es/proxy_cache/node:20-alpine AS builder

RUN apk add --no-cache \
    git \
    openssh


WORKDIR /app
RUN npm install -g npm@9.8.1
COPY package.json package-lock.json ./

RUN npm ci --ignore-scripts
COPY . .
RUN npm run build

FROM harbor.tid.es/proxy_cache/node:20-alpine
WORKDIR /app
RUN npm install -g serve@14.2.0
COPY --from=builder /app/build /app/build

CMD ["serve", "-p", "3000", "-s", "build"]
