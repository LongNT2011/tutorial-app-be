FROM arm64v8/node:23-alpine3.19

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /bezkoder-api
RUN chown -R appuser:appgroup /bezkoder-api

USER appuser

COPY package.json .
RUN npm install

COPY . .

CMD ["npm", "start"]
