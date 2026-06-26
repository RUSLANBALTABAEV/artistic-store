# apps/cms/Dockerfile

# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

# Установить системные зависимости
RUN apk add --no-cache python3 make g++ cairo-dev jpeg-dev pango-dev giflib-dev

# Скопировать package.json и установить зависимости
COPY package*.json ./
RUN npm install

# Скопировать исходный код
COPY . .

# Build Strapi
RUN npm run build

# Production stage
FROM node:18-alpine

WORKDIR /app

# Установить systemные зависимости для production
RUN apk add --no-cache cairo jpeg pango giflib dumb-init

# Скопировать собранное приложение из builder stage
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/src ./src
COPY --from=builder /app/config ./config
COPY --from=builder /app/package*.json ./

# Создать директории для uploads и cache
RUN mkdir -p public/uploads .cache

# Установить переменные окружения для production
ENV NODE_ENV=production \
    NODE_OPTIONS="--max-old-space-size=2048"

# Expose port
EXPOSE 1337

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD node -e "require('http').get('http://localhost:1337/admin', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})"

# Использовать dumb-init для правильной обработки сигналов
ENTRYPOINT ["/sbin/dumb-init", "--"]

# Запустить приложение
CMD ["npm", "run", "start"]
