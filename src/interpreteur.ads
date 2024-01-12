package interpreteur is

  -- Nom fonction : TraiterGOTO

  -- Sémantique : Traite l'instruction GOTO, qui permet de sauter à une ligne donnée X de la forme GOTO X

  -- Paramètres :
  --    - numeroLigne : Integer in --> ligne courante de l'instruction à traiter
  --    - CP : Integer out         --> compteur de ligne, pointant sur l'instruction courante
  procedure TraiterGOTO (numeroLigne : in Integer; CP : out Integer);

  -- Nom fonction : TraiterIF

  -- Sémantique : Traite l'instruction IF, qui permet de sauter à une ligne donnée Y si la condition est vraie de la forme IF X GOTO Y

  -- Paramètres :
  --    - condition : Integer in    --> condition de l'instruction IF (False si 0, True sinon)
  --    - numeroLigne : Integer in  --> ligne courante de l'instruction à traiter
  --    - CP : Integer in out       --> compteur de ligne, pointant sur l'instruction courante
  procedure TraiterIF
   (condition : in Integer; numeroLigne : in Integer; CP : in out Integer);

  -- Nom Fonction : TraiterAffectation

  -- Sémantique : Traite l'affectation d'une variable avec ou sans opérande

  -- Paramètres :
  --    - quadruple : T_quadruple in --> ligne courante de l'instruction à traiter
  --    - tas : T_tas in out         --> le tas (mémoire) des variables du programme
  -- Post => taille de tas en sortie >= taille de tas en entrée;
  procedure TraiterAffectation
   (quadruple : in T_quadruple; tas : in out T_tas);

  -- Nom Fonction : traiterVariable

  -- Sémantique : Traite l'ajout ou la récupération d'une variable dans le tas

  -- Paramètres :
  --    - nomVar : Character in --> nom de la variable à traiter

  -- Type de retour : T_tas --> la cellule de la variable traitée

  -- Pre => nomVar /= ' ', Post => traiterVariable'Result /= null;
  function traiterVariable (nomVar : in Character) return T_tas;


  -- Nom Fonction : TraiterAssignationSimple

  -- Sémantique : Traite l'affectation simple (<-) d'une variable de la forme x y <-

  -- Paramètres :
  --   - pointeurVariable : T_tas in --> pointeur vers la cellule de la variable à affecter
  --   - valeur : Integer in --> valeur à affecter à la variable

  -- Pre  => pointeurVariable /= null,
  -- Post => pointeurVariable.all.valeur = valeur;
  procedure TraiterAssignationSimple
   (pointeurVariable : in T_tas; valeur : in Integer);


  -- Nom Fonction : TraiterAssignationBinaire

  -- Sémantique : Traite l'affectation binaire (<-, +, -, ...) d'une variable de la forme x y op z

  -- Paramètres :
  --   - pointeurVariable : T_tas in --> pointeur vers la cellule de la variable à affecter
  --   - valeur1 : Integer in --> première valeur de l'opération
  --   - valeur2 : Integer in --> deuxième valeur de l'opération
  --   - operateur : string in --> opérateur de l'opération

  -- Pre => pointeurVariable /= null & operateur connu & valeur1 /= null & valeur2 /= null,
  -- Post => pointeurVariable.all.valeur = valeur1 operateur valeur2;
  procedure TraiterAssignationBinaire
   (pointeurVariable : in T_tas; valeur1 : in Integer; valeur2 : in Integer;
    operateur        : in String);


  -- Nom Fonction : TraiterNull

  -- Sémantique : Traite l'instruction NULL, qui ne fait rien

  -- Paramètres :
  --    - CP : Integer in out       --> compteur de ligne, pointant sur l'instruction courante
  procedure TraiterNull (CP : in out Integer);

end interpreteur;
