# Projet Docker Final - 3IW

## Description
Architecture Docker avec 2 serveurs Nginx, 2 services PHP-FPM et une base MySQL partagée.

## Lancement
```bash
docker-compose up --build 
```

## 🌐 Accès aux Services

### Applications Laravel
- **Serveur 1**: http://localhost:8080
  - Affiche "Serveur 1" sur la page d'accueil
  - Fonctionnalités : inscription, connexion
  
- **Serveur 2**: http://localhost:8081
  - Affiche "Serveur 2" sur la page d'accueil
  - Fonctionnalités : inscription, connexion

### Base de Données
- **phpMyAdmin**: http://localhost:8082
  - Utilisateur: `laravel_user`
  - Mot de passe: `laravel_password`
  - Base: `laravel_db`
    
## 🏗️ Architecture

```
┌─────────────┐    ┌─────────────┐
│   Nginx 1   │    │   Nginx 2   │
│   :8080     │    │   :8081     │
└─────────────┘    └─────────────┘
       │                   │
       ▼                   ▼
┌─────────────┐    ┌─────────────┐
│  PHP-FPM 1  │    │  PHP-FPM 2  │
│             │    │             │
└─────────────┘    └─────────────┘
       │                   │
       └───────────────────┘
                   │
                   ▼
           ┌─────────────┐
           │    MySQL    │
           │   :3306     │
           └─────────────┘
                   │
                   ▼
           ┌─────────────┐
           │ phpMyAdmin  │
           │   :8082     │
           └─────────────┘
```
