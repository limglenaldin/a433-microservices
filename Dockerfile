# Menggunakan image Node 14
FROM node:14-alpine

# Mengubah Working Directory ke /app
WORKDIR /app

# Menyalin berkas dari exsiting directory ke working directory container
COPY . .

# Men-set lingkungan node pada production dan men-set nama host dari database
ENV NODE_ENV=production DB_HOST=item-db

# Menjalankan perintah install dependency pada lingkungan Production dan melakukan build
RUN npm install --production --unsafe-perm && npm run build

# Menjalankan perintah start sebagai entrypoint ketika container dijalankan
CMD ["npm", "start"]

# Mengekspos port 8080
EXPOSE 8080