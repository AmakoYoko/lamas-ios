# Lamas — source SideStore

Source unique pour toutes les applis iOS de Lamas : à ajouter une fois dans SideStore :

**https://raw.githubusercontent.com/AmakoYoko/lamas-ios/main/source.json**

`merge.sh` fusionne les sources de chaque appli listées dans `apps.txt` ; GitHub Actions le relance toutes les 30 min (et à chaque changement de `apps.txt`).

**Nouvelle appli** : son dépôt publie sa propre `source.json` (comme `music-ios` ou `courrier-ios`), puis on ajoute son URL dans `apps.txt`.
