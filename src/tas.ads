-- Ce package définit le type abstrait de données tas (ou heap en anglais) qui permet de stocker les variables du code intermédiaire
package tas is

   CAPACITE : Integer := 500;  -- Capacité maximale du tas

   type T_Tab_Tas is private;  -- Type privé pour le tableau du tas

   type T_Tas is record -- Type enregistrement pour le tas
      tas        : T_Tab_Tas;  -- Tableau du tas
      nbElements : Integer;  -- Nombre d'éléments actuellement dans le tas
   end record;

   -- set nbelements a 0
   procedure InitialiserTas(tas : out T_Tas);

   procedure AjouterVariable(indice : in Integer; valeur : in Integer);

   function GetVariable ( indice : in Integer) return Integer;

private

   type T_Tab_Tas is
     array (1 .. CAPACITE) of Integer;  -- Définition du type tableau du tas

end tas;
