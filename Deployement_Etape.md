1-Création d'une application en python nommée "Todo_list"

2-Création du dockerfile

Ce fichier est un Dockerfile, un script qui permet de décrire les étapes nécessaires à la construction d'une image Docker.Voici une explication de chaque partie du code :

1. **Directive FROM**:

   ```Dockerfile
   FROM python
   ```
   Cette directive spécifie l'image de base à utiliser pour construire cette image Docker. Ici, `python` est l'image officielle de Python provenant du référentiel Docker Hub. Cela signifie que cette image contient déjà Python préinstallé.

2. **Directive RUN** :
   Cette directive `RUN` exécute des commandes dans le conteneur en cours de construction. Explorons chaque partie du code :

 ```Dockerfile
   RUN apt-get update && apt-get install -y --no-install-recommends \
       sudo \
       python3 \
    && rm -rf /var/lib/apt/lists/*
```


 -- **Mise à jour du référentiel des paquets** :
   ```Dockerfile
   apt-get update
   ```
   Cette commande met à jour le référentiel des paquets dans le conteneur. Elle récupère les informations les plus récentes sur les paquets disponibles à partir des dépôts configurés.

-- **Installation de `sudo` et `python3`** :
   ```Dockerfile
       apt-get install -y --no-install-recommends \
       sudo \
       python3 \
   ```
   Cette commande installe les paquets `sudo` et `python3` dans le conteneur en utilisant le gestionnaire de paquets `apt-get`. 

   - L'option `-y` indique à `apt-get` de répondre "oui" à toutes les questions, ce qui est utile lors de l'installation automatique des paquets.
   - L'option `--no-install-recommends` indique à `apt-get` de ne pas installer les recommandations de paquets, ce qui permet de réduire la taille de l'image Docker.
   - `sudo` est un outil permettant d'exécuter des commandes avec des privilèges élevés.
   - `python3` est le paquet Python version 3.

3. **Nettoyage des listes de paquets téléchargées** :
   ```Dockerfile
   rm -rf /var/lib/apt/lists/*
   ```
   Cette commande supprime les listes de paquets téléchargées stockées dans le répertoire `/var/lib/apt/lists/` après l'installation des paquets. Elle vise à réduire la taille finale de l'image en supprimant les fichiers temporaires et les caches utilisés lors de l'installation des paquets.

3. **Directive COPY** :
   ```Dockerfile
   COPY . /app
   ```
   Cette directive copie les fichiers de l'application actuelle (le répertoire local où se trouve le Dockerfile) dans le répertoire `/app` du conteneur. Cela permet d'inclure les fichiers de votre application dans l'image Docker.

4. **Directive WORKDIR** :
   ```Dockerfile
   WORKDIR /app
   ```
   Cette directive définit le répertoire de travail à `/app` dans le conteneur. Toutes les commandes suivantes seront exécutées à partir de ce répertoire, et c'est également le répertoire où le conteneur sera positionné par défaut lorsqu'il sera démarré.

5. **Directive CMD** :
   ```Dockerfile
   CMD ["python", "To_List.py"]
   ```
   Cette directive spécifie la commande par défaut à exécuter lorsque le conteneur est démarré. Dans ce cas, la commande `python To_List.py` est exécutée. Cela suppose qu'il existe un fichier Python appelé `To_List.py` dans le répertoire de travail du conteneur (`/app`), et il sera exécuté au démarrage du conteneur.


6.Construisez votre image Docker en utilisant ce Dockerfile

docker build -t mon_image .

7 - connection au compte Docker Hub pour l'envoie de l'image 

Pour pousser votre image Docker vers un registre Docker, tel que Docker Hub, vous devez suivre ces étapes :

-- . **Connexion au registre Docker** : Assurez-vous d'être connecté au registre Docker sur lequel vous souhaitez pousser votre image. Vous pouvez vous connecter en utilisant la commande `docker login` et en fournissant votre nom d'utilisateur et votre mot de passe.

   ```bash
   docker login
   ```
-- . **Taguer votre image** : Avant de la pousser vers le registre, vous devez taguer votre image avec le nom du registre Docker. Le format pour cela est `docker tag <nom de votre image> <nom de votre nom d'utilisateur>/<nom de votre image>:<version>`.

   Par exemple, pour taguer votre image avec votre nom d'utilisateur sur Docker Hub et le nom de l'image "my-image" avec la version "v1.0", vous pouvez utiliser :

   ```bash
   docker tag my-image username/my-image:v1.0
   ```

   Assurez-vous de remplacer `username` par votre nom d'utilisateur Docker Hub et `my-image:v1.0` par le nom et la version de votre image.

-- . **Pousser votre image** : Une fois que vous avez tagué votre image, vous pouvez la pousser vers le registre Docker en utilisant la commande `docker push`.

   ```bash
   docker push username/my-image:v1.0
   ```

   Assurez-vous de remplacer `username/my-image:v1.0` par le nom de l'image que vous avez taguée.

-- . **Attendez la fin du téléversement** : Le processus de téléversement peut prendre un certain temps en fonction de la taille de votre image et de la vitesse de votre connexion Internet. Attendez que le téléversement soit terminé avant de continuer.

Une fois ces étapes terminées, votre image Docker devrait être disponible sur le registre Docker spécifié, accessible à d'autres utilisateurs qui ont les autorisations nécessaires pour y accéder. Vous pouvez vérifier la disponibilité de votre image en visitant le registre Docker et en recherchant votre nom d'utilisateur.

8.(optionnelle)
```bash 
docker tag mon_image:latest nouveau-repo:latest

```

## Etape pour envoyer une image sur dockerHub

-- création d'un d'un referentiel sur dockerHub

```bash
docker build -t <nom-de-l-image>:<tag> <chemin-vers-le-Dockerfile-ou-le-contexte-de-build>
```

.
```bash 
   docker push nouveau-repo:nom-du-nouveau-tag
```

. execution du conteneur 

```bash
    docker run -it --name new-conteneur mon_image /bin/bash
```