FROM node:18-slim

WORKDIR /usr/src/app

COPY ./tech-consulting-app/package*.json ./

RUN npm install

COPY . .

EXPOSE 9000

CMD [ "npm", "start" ]