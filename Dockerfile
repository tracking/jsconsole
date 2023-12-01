FROM node:8 AS build

WORKDIR /opt/node_app

COPY . .

RUN npm install
RUN npm run styles && npm run build

FROM nginx:1.21-alpine

COPY --from=build /opt/node_app/build /usr/share/nginx/html

HEALTHCHECK CMD wget -q -O /dev/null http://localhost || exit 1
