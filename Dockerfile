FROM node:12.2.0 as builder

WORKDIR '/app'

COPY package.json .

ENV PATH /app/node_modules/.bin:$PATH

RUN npm install -g @angular/cli -y
RUN npm install -y

COPY . .

RUN ng build --prod

FROM nginx:1-bullseye

EXPOSE 80
COPY --from=builder /app/dist/bitcoin /usr/share/nginx/html