# Dimanche Après-Midi

*Un auto-runner narratif en 2D, créé lors de la game jam de l’ÉESI en 2025.*

![Capture d’écran de Dimanche AprèsMidi](https://raw.githubusercontent.com/Turnute/tutuBlog/main/assets/images/games/dimanche-aprem.png)

## Le jeu

À l’arrière d’une voiture, pendant un long trajet, un enfant cherche à s’évader des disputes de ses parents. À travers la vitre, le paysage qui défile devient le terrain de jeu d’un petit personnage imaginaire.

**Dimanche Après-Midi** prend la forme d’un *auto-runner* : le personnage avance automatiquement et le joueur doit éviter les obstacles en sautant. Au fil du trajet, des événements viennent perturber la course et rappeler la réalité qui entoure l’enfant.

Ce prototype a été réalisé dans le cadre d’une **game jam à l’ÉESI en 2025**.

## Fonctionnalités

* Défilement continu du décor et génération aléatoire d’obstacles.
* Saut et double saut pour éviter les obstacles.
* Score qui progresse avec la distance parcourue et accélération progressive.
* Événements aléatoires pendant le trajet (dos-d’âne, dispute, passage sous un pont).
* Illustrations, animations et ambiance sonore intégrées au jeu.

## Jouer

Une version du jeu est proposée au téléchargement depuis [la page de présentation sur mon site](https://turnute.github.io/tutuBlog/games/), via le bouton « Découvrir le jeu » associé à **Dimanche Après-Midi**.

[Téléchargement direct (Google Drive)](https://drive.google.com/file/d/17h_qL81TVz18pCI7oGfNsr8dMQzk8s6T/view?usp=sharing)

### Commandes

| Action | Commande |
| --- | --- |
| Démarrer | **Entrée**, **Espace** ou bouton du menu |
| Sauter | **Espace** (ou **Entrée**) |
| Double saut | Appuyer une seconde fois pendant le saut |
| Quitter | **Échap** |

La partie prend fin si le personnage entre en collision avec un obstacle.

## Ouvrir le projet dans Godot

Le dépôt contient les **sources du jeu**, développées avec **Godot 4.5** et **GDScript**.

1. Cloner le dépôt ou télécharger son archive :
  
      git clone https://github.com/Turnute/DimancheApresMidi.git
  
2. Ouvrir **Godot 4.5** et choisir **Importer** dans le gestionnaire de projets.
  
3. Sélectionner le fichier `le-long-trajet-en-voiture/project.godot`.
  
4. Ouvrir le projet, puis lancer la scène principale avec **F5**.
  

> Le projet Godot se trouve dans le sous-dossier `le-long-trajet-en-voiture/`, et non à la racine du dépôt.

## Organisation des fichiers

    DimancheApresMidi/
    └── le-long-trajet-en-voiture/
        ├── assets/            # Images, musiques et effets sonores
        ├── scenes/            # Scènes Godot et obstacles
        ├── scripts/           # Gameplay et logique du jeu (GDScript)
        ├── project.godot      # Configuration du projet Godot
        └── export_presets.cfg # Paramètres d’export
