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
      nbElements  : Integer; -- NbElements >= 0
   end record;
   
   -- Nom fonction : InsererInstruction

   -- Sémantique : Insère une instruction dans la mémoire du code intermédiaire

   -- Paramètres :
   --    - memoireCode : in out T_Memoire_Code --> la mémoire du code intermédiaire
   --    - case1 : Integer --> le premier élément de l'instruction à insérer
   --    - case2 : Integer --> le deuxième élément de l'instruction à insérer
   --    - case3 : Integer --> le troisième élément de l'instruction à insérer
   --    - case4 : Integer --> le quatrième élément de l'instruction à insérer
   --    - case5 : Integer --> le cinquième élément de l'instruction à insérer
   --    - case6 : Integer --> le sixième élément de l'instruction à insérer

   -- Pre  => memoire /= null & memoire.nbElements < TAILLE_MEMOIRE_CODE,
   -- Post => memoire.nbElements = memoire.nbElements'last + 1;
   procedure InsererInstruction(memoireCode : in out T_Memoire_Code; case1 : in Integer; 
                                case2 : in Integer; case3 : in Integer; case4 : in Integer; 
                                case5 : in Integer; case6 : in Integer);


      -- Nom fonction : GetInstruction

   -- Sémantique : Récupère une instruction dans la mémoire du code intermédiaire

   -- Paramètres :
   --    - memoireCode : in out T_Memoire_Code --> la mémoire du code intermédiaire
   --    - cp : in --> le compteur de programme pointant sur l'instruction à récupérer

   -- Pre  => memoire /= null & cp >= 0 & cp <= memoire.nbElements,
   -- Post => GetInstruction'Result /= null;
   function GetInstruction(memoireCode : in T_Memoire_Code; cp : in Integer) return T_Memoire_Code_Tab;

private

   -- Définition du type T_Ligne comme un tableau de Integer de taille TAILLE_LIGNE_INSTRUCTION
   type T_Ligne is array (1 .. TAILLE_LIGNE_INSTRUCTION) of Integer;

   -- Définition du type T_Memoire_Code_Tab comme un tableau de T_Ligne de taille TAILLE_MEMOIRE_CODE
   type T_Memoire_Code_Tab is array (1 .. TAILLE_MEMOIRE_CODE) of T_Ligne;

end Memoire_Code;
