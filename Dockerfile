FROM node:16.19-alpine3.16 as builder
WORKDIR /usr/app
COPY ./package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx
# we are copying the build directory to nginx's directory from which the application is served. It is found in docker's nginx's documentation
COPY --from=builder /usr/app/build /usr/share/nginx/html
# We don't need any start command because the default nginx image's start command will server the content

