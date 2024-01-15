with Memoire_Code; use Memoire_Code;
with tas;          use tas;

package interpreteur is

   -- Nom fonction : TraiterGOTO

   -- Sémantique : Traite l'instruction GOTO, qui permet de sauter à une ligne donnée X de la forme GOTO X

   -- Paramètres :
   --    - instruction : T_Memoire_Code_Tab in --> instruction courante de l'instruction à traiter (ici récuperer le numéro de la ligne)
   --    - CP : Integer out         --> compteur de ligne, pointant sur l'instruction courante
   procedure TraiterGOTO (instruction : in T_Memoire_Code_Tab; CP : out Integer);

   -- Nom fonction : TraiterIF

   -- Sémantique : Traite l'instruction IF, qui permet de sauter à une ligne donnée Y si la condition est vraie de la forme IF X GOTO Y

   -- Paramètres :
   --    - instruction : T_Memoire_Code_Tab in --> instruction courante de l'instruction à traiter (ici récuperer la condition ainsi que le numéro de la ligne)
   --    - CP : Integer in out       --> compteur de ligne, pointant sur l'instruction courante
   procedure TraiterIF (instruction : in T_Memoire_Code_Tab; CP : in out Integer);

   -- Nom Fonction : TraiterAffectation

   -- Sémantique : Traite l'affectation d'une variable avec ou sans opérande

   -- Paramètres :
   --    - instruction : T_Memoire_Code_Tab in --> instruction courante de l'instruction à traiter (ici récuperer les composantes de l'opération)
   --    - tas : T_tas in out         --> le tas (mémoire) des variables du programme
   --    - CP : Integer in out       --> compteur de ligne, pointant sur l'instruction courante
   -- Post => taille de tas en sortie >= taille de tas en entrée;
   procedure TraiterAffectation
     (instruction : in T_Memoire_Code_Tab; tas : in out T_Tas; CP : in out Integer);

   -- Nom Fonction : TraiterNull

   -- Sémantique : Traite l'instruction NULL, qui ne fait rien

   -- Paramètres :
   --    - CP : Integer in out       --> compteur de ligne, pointant sur l'instruction courante
   procedure TraiterNULL (CP : in out Integer);

end interpreteur;
