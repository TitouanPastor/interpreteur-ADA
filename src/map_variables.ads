with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Hash;
with tas;                   use tas;
with Ada.Text_IO;           use Ada.Text_IO;

package Map_Variables is

   type Enum_Type is (Integer_Type, Character_Type, Boolean_Type);

   type T_ElementMap is record
      indiceTas : Integer;
      TypeVar   : Enum_Type;
   end record;

   package Variable_Hashed_Maps is new Ada.Containers.Indefinite_Hashed_Maps
     (Key_Type => String, Element_Type => T_ElementMap,
      Hash     => Ada.Strings.Hash, Equivalent_Keys => "=");
   use Variable_Hashed_Maps;

   -- Nom fonction : AfficherMap

   -- Sémantique : Affiche toutes les variables contenues dans le dictionnaire

   -- Paramètres :
-- map : Variable_Hashed_Maps.Map in --> dictionnaire contenant les variables

   -- Pre : /
   -- Post : /
   procedure AfficherMap (map : in Variable_Hashed_Maps.Map);

   -- Nom fonction : AfficherTas

   -- Sémantique : Affiche toutes les variables contenues dans le tas avec leur nom et leur valeur
   procedure AfficherTas (map : in Variable_Hashed_Maps.Map; tas : in T_Tas);

   -- Nom fonction : GetKeyFromValue

   -- Sémantique : Renvoie le nom de la variable (clé) dont la valeur(indiceTas) est passée en paramètre

   -- Paramètres :
-- map : Variable_Hashed_Maps.Map in --> dictionnaire contenant les variables
-- Value : Integer in --> indiceTas de la variable dont on veut le nom

   -- Pre : Map.contains (Value)
   -- Post : /
   function GetKeyFromValue
     (Map : Variable_Hashed_Maps.Map; Value : Integer) return Unbounded_String;

private

end Map_Variables;
