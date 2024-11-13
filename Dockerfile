# Sử dụng image ARM64 cho Node.js
FROM arm64v8/node:23-alpine3.19

# Tạo user mới và nhóm mới
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Đổi quyền sở hữu thư mục làm việc cho user mới
WORKDIR /bezkoder-api
RUN chown -R appuser:appgroup /bezkoder-api

# Sử dụng user mới
USER appuser

# Sao chép và cài đặt dependencies
COPY package.json .
RUN npm install

COPY . .

# Chạy ứng dụng với user mới
CMD npm start
