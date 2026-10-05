FROM node:24-alpine AS compilacion

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine AS produccion

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=compilacion /app/dist/biblioteca-web/browser /usr/share/nginx/html

EXPOSE 80
