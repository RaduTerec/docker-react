FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build - contains the build for the website

FROM nginx
EXPOSE 80
# copy just the bare minimum of needed files to the default folder where nginx knows to display the html
COPY --from=builder /app/build /usr/share/nginx/html
# default command is to start nginx, so we don't need to specify it.