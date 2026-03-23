FROM docker.io/node:20

COPY . /src
WORKDIR /src

RUN . /tmp/hermeto.env && yarn install

EXPOSE 9000

CMD ["yarn", "run", "start"]

