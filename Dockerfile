FROM node:13-alpine
RUN apk add --no-cache python2

WORKDIR /app/angular-client
COPY ["angular-client/package.json", "angular-client/package-lock.json", "./"]
RUN npm install

WORKDIR /app/angular-daemon
COPY ["angular-daemon/package.json", "angular-daemon/package-lock.json", "./"]
RUN npm install

WORKDIR /app
COPY . .

WORKDIR /app/angular-daemon
RUN npm run compile
RUN npm run copyStatics