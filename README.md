# Yaya_Tools
 Ensemble de fonctions utiles pour AnkaBot
 
 1. Créer un dossier nommer YAYA a la racine d'Ankabot
 2. Déplacer tout les fichier dans le dossier YAYA

 Les ID des Zone et sous zone sont dans le dossier AreaId
 
## Les fonction
 
## Zone
1. Pour utiliser les fonction Zone mettez cette ligne en haut de votre script lua :

   Zone = dofile(global:getCurrentDirectory() .. "\\\YAYA\\\Module\\\Zone.lua")

### Area

* Zone:GetAreaMapId(areaId) 
  * Retourne toutes les mapId d'une zone dans une table {}
  * Params 1 : ID de l'area
 
* Zone:GetAreaName(areaId)
  * Retourne le nom de la zone
  * Params 1 : ID de l'area

* Zone:GetSubArea(areaId)
  * Retourne touts les ID des sous zone dans une table {}
  * Params 1 : ID de l'area

### SubArea

* Zone:GetSubAreaMapId(subAreaId) 
  * Retourne toutes les mapId d'une sous zone dans une table {}
  * Params 1 : ID de la sous zone
 
* Zone:GetSubAreaName(subAreaId)
  * Retourne le nom de la sous zone
  * Params 1 : ID de la sous zone

* Zone:GetSubAreaMonsters(subAreaId)
  * Retourne touts les monstersId présent dans la sous zone dans une table {}
  * Params 1 : ID de la sous zone

* Zone:GetArea(subAreaId)
  * Retourne l'idArea de la sous zone
  * Params 1 : ID de la sous zone

## Utils
1. Pour utiliser les fonction Utils mettez cette ligne en haut de votre script lua :

   Utils = dofile(global:getCurrentDirectory() .. "\\\YAYA\\\Module\\\Utils.lua")
   
* Utils:Print(msg, header, msgType) 
  * Print un message dans la console Ankabot en fonction des paramètre
  * Params 1 : Message a print
  * Params 2 (facultatif) : Place un header avant le message ([header] message)
  * params 3 (facultatif) : "warn" ou "error" Colorie le message et place un header d'avertissement, le params 2 et obligatoire ([Avertissement][header] message)

* Utils:Dump(tbl)
  * Parcours tout les éléments d'une table et ses sous tables en affichant leurs valeurs
  * Params 1 : La table

* Utils:GetTableValue(index, tbl)
  * Retourne la valeur d'un élément d'une table a l'index indiqué
  * Params 1 : L'index souhaité
  * Params 2 : La table

* Utils:LenghtOfTable(tbl)
  * Retourne la taille de la table (utile quand #tbl bug)
  * Params 1 : La table 

* Utils:ShuffleTbl(tbl)
  * Mélange les élément d'une table et retourne la table mélangé
  * Params 1 : La table 

* Utils:ReadFile(path)
  * Retourne le contenu d'un fichier
  * Params 1 : Chemin du fichier
