-- Ce package définit le type abstrait de données tas (ou heap en anglais) qui permet de stocker les variables du code intermédiaire
package tas is

   CAPACITE : Integer := 500;  -- Capacité maximale du tas

   type T_Tab_Tas is private;  -- Type privé pour le tableau du tas

   type T_Tas is record -- Type enregistrement pour le tas
      tas_Tab    : T_Tab_Tas;  -- Tableau du tas
      nbElements : Integer;  -- Nombre d'éléments actuellement dans le tas
   end record;

   -- Nom fonction : InitialiserTas

   -- Sémantique : Initialise le tas en mettant le nombre d'éléments à 0

   -- Paramètres :
   --   tas : out T_Tas --> le tas à initialiser

   -- Pre  => rien,
   -- Post => tas.nbElements = 0;
   procedure InitialiserTas (tas : out T_Tas);

   -- Nom fonction : AjouterVariable

   -- Sémantique : Ajoute une variable au tas

   -- Paramètres :
   --   tas    : in out T_Tas --> le tas dans lequel on ajoute la variable
   --   valeur : in Integer   --> la valeur de la variable à ajouter

   -- Pre  => 1 <= tas.nbElements < CAPACITE
   -- Post => tas.nbElements = tas.nbElements'last + 1 & GetVariable (indice) = valeur;
   procedure AjouterVariable (tas : in out T_Tas; valeur : in Integer);

   -- Nom fonction : ModifierVariable

   -- Sémantique : Modifie la valeur d'une variable du tas

   -- Paramètres :
   --   tas    : in out T_Tas --> le tas dans lequel on ajoute la variable
   --   indice : in Integer   --> l'indice de la variable à modifier
   --   valeur : in Integer   --> la nouvelle valeur de la variable

   -- Pre  => 1 <= indice <= CAPACITE,
   -- Post => GetVariable (indice) = valeur;
   procedure ModifierVariable
     (tas : in out T_Tas; indice : in Integer; valeur : in Integer);

   -- Nom fonction : GetVariable

   -- Sémantique : Retourne la valeur de la variable à l'indice donné

   -- Paramètres :
   --   tas    : in T_Tas    --> le tas dans lequel on ajoute la variable
   --   indice : in Integer  --> l'indice de la variable à ajouter

   -- retour :
   --  Integer --> la valeur de la variable à l'indice donné

   -- Pre  => 1 <= indice <= CAPACITE,
   -- Post => GetVariable'Result /= null;
   function GetVariable (tas : in T_Tas; indice : in Integer) return Integer;

   -- Nom fonction : GetNbElements

   -- Sémantique : Retourne le nombre d'éléments actuellement dans le tas

   -- Paramètres :
   --   tas    : in T_Tas    --> le tas dans lequel on ajoute la variable

   -- retour :
   --  Integer --> le nombre d'éléments actuellement dans le tas

   -- Post => 1 <= GetNbElements'Result <= CAPACITE;
   function GetNbElements (tas : in T_Tas) return Integer;

private

   type T_Tab_Tas is
     array (1 .. CAPACITE) of Integer;  -- Définition du type tableau du tas

end tas;
