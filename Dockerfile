# Utiliser une image node pour builder l'application
FROM node:16.13.2-alpine AS build

# Créer un répertoire de travail
WORKDIR /app

# Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste des fichiers de l'application
COPY . .

# Construire l'application
RUN npm run build

# Utiliser une image nginx pour servir l'application
FROM nginx:alpine

# Copier les fichiers buildés dans le répertoire html de nginx
COPY --from=build /app/build /usr/share/nginx/html

# Copier le fichier de configuration nginx personnalisé si nécessaire
# COPY nginx.conf /etc/nginx/nginx.conf

# Exposer le port 80
EXPOSE 80


