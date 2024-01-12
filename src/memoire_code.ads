
-- Ce package définit le module Memoire_Code qui contient les types et les constantes utilisés pour la gestion de la mémoire du code intermédiaire.
package Memoire_Code is
   
   -- Taille d'une ligne d'instruction du code intermédiaire
   TAILLE_LIGNE_INSTRUCTION : Integer := 6;
   
   -- Taille (donc nombre de lignes d'instructions) de la mémoire utilisée pour stocker le code intermédiaire
   TAILLE_MEMOIRE_CODE : Integer := 500;

   -- Définition du type T_Ligne qui représente une ligne d'instruction du code intermédiaire
   type T_Ligne is private;
   
   -- Définition du type T_Memoire_Code_Tab qui représente la mémoire du code intermédiaire sous forme de tableau de lignes d'instructions
   type T_Memoire_Code_Tab is private;
   
   -- Définition du type T_Memoire qui représente la mémoire globale utilisée pour stocker le code intermédiaire
   type T_Memoire_Code is record
        memoireCode : T_Memoire_Code_Tab;
        nbElements : Integer; -- NbElements >= 0
   end record;

private
   
   -- Définition du type T_Ligne comme un tableau de Integer de taille TAILLE_LIGNE_INSTRUCTION
   type T_Ligne is array(1..TAILLE_LIGNE_INSTRUCTION) of Integer;
   
   -- Définition du type T_Memoire_Code_Tab comme un tableau de T_Ligne de taille TAILLE_MEMOIRE_CODE
   type T_Memoire_Code_Tab is array(1..TAILLE_MEMOIRE_CODE) of T_Ligne;

end Memoire_Code;
