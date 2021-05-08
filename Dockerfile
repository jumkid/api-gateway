FROM node:stretch-slim

WORKDIR /opt/api-gateway

COPY dist/ /opt/api-gateway/

RUN yarn --production

CMD ["yarn", "start"]

EXPOSE 80
