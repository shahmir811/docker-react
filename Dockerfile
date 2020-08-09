# BUILD PHASE
# "as" is used for tagging.
# before next FROM, all code belongs to builder phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# RUN PHASE
FROM nginx
# --from mean "from some phase". In our case, its builder
COPY --from=builder /app/build /usr/share/nginx/html