# Guide de Déploiement Simple pour InfinityFree

Puisque vous êtes dans le **File Manager**, voici exactement ce qu'il faut faire étape par étape :

## Étape 1 : Préparer les dossiers sur InfinityFree

1.  À la racine (là où vous voyez le dossier `htdocs`), **Créez un nouveau dossier** nommé `core`.
2.  Vous avez maintenant deux dossiers importants : `htdocs` et `core`.

## Étape 2 : Envoyer les fichiers de votre ordinateur

1.  **Dans le dossier `core` (sur InfinityFree) :**
    - Envoyez **TOUS** les fichiers et dossiers de votre projet local (`eau_lb`), **SAUF** le dossier `public`.
    - (C'est-à-dire : `app`, `bootstrap`, `config`, `database`, `resources`, `routes`, `vendor`, `.env`, etc.)
2.  **Dans le dossier `htdocs` (sur InfinityFree) :**
    - Ouvrez votre dossier local `public`.
    - Envoyez **TOUT** ce qui se trouve à l'intérieur de ce dossier `public` vers `htdocs`.
    - (Vous devriez y voir `index.php`, `vite.svg`, le dossier `build`, etc.)

## Étape 3 : Modifier le fichier index.php

C'est l'étape la plus importante pour que le site fonctionne.

1.  Dans le File Manager, ouvrez `htdocs/index.php` pour le modifier.
2.  Cherchez ces deux lignes et modifiez-les comme ceci :

**Ligne 16 (environ) :**

```php
// Remplacez :
require __DIR__.'/../vendor/autoload.php';
// Par :
require __DIR__.'/../core/vendor/autoload.php';
```

**Ligne 36 (environ) :**

```php
// Remplacez :
$app = require_once __DIR__.'/../bootstrap/app.php';
// Par :
$app = require_once __DIR__.'/../core/bootstrap/app.php';
```

## Étape 4 : Configurer la base de données

1.  Allez dans votre **Control Panel** InfinityFree -> **MySQL Databases**.
2.  Créez une base de données et notez le **Host**, **Username** et **Password**.
3.  Modifiez le fichier `core/.env` sur le serveur avec ces informations.
4.  Ouvrez **phpMyAdmin** sur InfinityFree et importez le fichier `database_export.sql` que j'ai créé pour vous.

---

**Besoin d'aide pour une étape précise ? Dites-le moi !**
