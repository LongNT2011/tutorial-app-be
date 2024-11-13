FROM node

WORKDIR /bezkoder-api
COPY package.json .
RUN npm install
COPY . .
CMD npm start
