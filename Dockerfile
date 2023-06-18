FROM node:18-alpine
WORKDIR /src
COPY . ./
RUN npm ci
CMD ["node", "index.js"]