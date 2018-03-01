FROM node:8-alpine

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
RUN cnpm install -g yapi-cli

RUN apk update && apk add --no-cache python make

WORKDIR /my-yapi

ENTRYPOINT ["node"]
CMD ["vendors/server/app.js"]