-- Ce package définit le type abstrait de données tas (ou heap en anglais) qui permet de stocker les variables du code intermédiaire
package tas is

   CAPACITE : Integer := 500;  -- Capacité maximale du tas

   type T_Tab_Tas is private;  -- Type privé pour le tableau du tas

   type T_Tas is record -- Type enregistrement pour le tas
      tas        : T_Tab_Tas;  -- Tableau du tas
      nbElements : Integer;  -- Nombre d'éléments actuellement dans le tas
   end record;


   -- Nom fonction : InitialiserTas

   -- Sémantique : Initialise le tas en mettant le nombre d'éléments à 0

   -- Paramètres :
   --   tas : le tas à initialiser

   -- Pre  => rien,
   -- Post => tas.nbElements = 0;
   procedure InitialiserTas (tas : out T_Tas);


   -- Nom fonction : AjouterVariable

   -- Sémantique : Ajoute une variable au tas

   -- Paramètres :
   --   tas    : le tas dans lequel on ajoute la variable
   --   indice : l'indice de la variable à ajouter

   -- Pre  => 1 <= indice <= CAPACITE,
   -- Post => tas.nbElements = tas.nbElements'last + 1 & GetVariable (indice) = valeur;
   procedure AjouterVariable (indice : in Integer; valeur : in Integer);


   -- Nom fonction : GetVariable

   -- Sémantique : Retourne la valeur de la variable à l'indice donné

   -- Paramètres :
   --   tas    : le tas dans lequel on ajoute la variable
   --   indice : l'indice de la variable à ajouter

   -- Pre  => 1 <= indice <= CAPACITE,
   -- Post => GetVariable'Result /= null;
   function GetVariable (indice : in Integer) return Integer;

private

   type T_Tab_Tas is
     array (1 .. CAPACITE) of Integer;  -- Définition du type tableau du tas

end tas;
