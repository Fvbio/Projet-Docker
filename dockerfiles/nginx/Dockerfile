FROM nginx:alpine

# Suppression de la configuration par défaut
RUN rm /etc/nginx/conf.d/default.conf

# Argument pour le fichier de configuration
ARG CONFIG_FILE

# Copie de la configuration spécifique
COPY dockerfiles/nginx/${CONFIG_FILE} /etc/nginx/conf.d/default.conf

# Exposition du port
EXPOSE 80

# Commande par défaut
CMD ["nginx", "-g", "daemon off;"]