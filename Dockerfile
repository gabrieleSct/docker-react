# Fase di Build
# dopo questa fase tutti i file necessari in prod si troveranno nella
# cartella /app/build
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#Fase di Run
#scrivendo un secondo FROM docker capisce automaticamente che
#il primo blocco è terminato, ogni blocco può avere un solo FROM
FROM nginx
#copiamo dalla fase precedente (builder) alla cartella di default 
#da cui ngnix serve i files
COPY --from=builder /app/build /usr/share/nginx/html
#il comando per lanciare nginx è già presente di default sull'immagine
#non è necessario specificarlo

