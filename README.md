# Yaya_Tools
 Ensemble de fonctions utiles pour AnkaBot
 
 1. Créer un dossier nommer YAYA a la racine d'Ankabot
 2. Déplacer tout les fichier dans le dossier YAYA

 Les ID des Zone et sous zone sont dans le dossier AreaId
 
## Les fonction
 
### Zone
 1. Pour utiliser les fonction Zone mettez cette ligne en haut de votre script lua :
    1.Zone = dofile(global:getCurrentDirectory() .. "\\YAYA\\Module\\Zone.lua")

#### Area

* Zone:GetAreaMapId(areaId) 
  * Retourne toutes les mapId d'une zone dans une table {}
  * Prend en paramètre l'ID de l'area
 
* Zone:GetAreaName(areaId)
  * Retourne le nom de la zone
  * Prend en paramètre l'ID de l'area

* Zone:GetSubArea(areaId)
  * Retourne touts les ID des sous zone dans une table {}
  * Prend en paramètre l'ID de l'area

#### SubArea

* Zone:GetSubAreaMapId(subAreaId) 
  * Retourne toutes les mapId d'une sous zone dans une table {}
  * Prend en paramètre l'ID de la sous zone
 
* Zone:GetSubAreaName(subAreaId)
  * Retourne le nom de la sous zone
  * Prend en paramètre l'ID de la sous zone

* Zone:GetSubAreaMonsters(subAreaId)
  * Retourne touts les monstersId présent dans la sous zone dans une table {}
  * Prend en paramètre l'ID de la sous zone

* Zone:GetArea(subAreaId)
  * Retourne l'idArea de la sous zone
  * Prend en paramètre l'ID de la sous zone
