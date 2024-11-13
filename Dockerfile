FROM arm64v8/node:23-alpine3.19

WORKDIR /bezkoder-api
COPY package.json .
RUN npm install
COPY . .
CMD npm start
