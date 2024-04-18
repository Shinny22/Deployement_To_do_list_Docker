FROM python

RUN apt-get update && apt-get install -y --no-install-recommends \
sudo \
python3 \
&& rm -rf /var/lib/apt/lists/*


# Copier les fichiers de l'application dans le conteneur
COPY . /app


# Définir le répertoire de travail
WORKDIR /app


# Commande par défaut pour exécuter votre application

CMD ["python","To_List.py"]
