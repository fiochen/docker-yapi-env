FROM node:8-alpine

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org \
    && cnpm install -g yapi-cli \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk update && apk add --no-cache make python git

WORKDIR /my-yapi

ENTRYPOINT ["node"]
CMD ["vendors/server/app.js"]