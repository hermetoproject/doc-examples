FROM node:18

WORKDIR /src

COPY . .

RUN npm install --verbose

EXPOSE 9000

CMD ["node", "index.js"]

