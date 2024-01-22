with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Hash;
with tas;                   use tas;
with Ada.Text_IO; use Ada.Text_IO;

package Map_Variables is

   type Enum_Type is (Integer_Type, Character_Type, Boolean_Type);

   type T_ElementMap is record
      indiceTas : Integer;
      TypeVar   : Enum_Type;
   end record;

   package Variable_Hashed_Maps is new Ada.Containers.Indefinite_Hashed_Maps
     (Key_Type => String, Element_Type => T_ElementMap, Hash => Ada.Strings.Hash,
      Equivalent_Keys => "=");
   use Variable_Hashed_Maps;

   procedure AfficherMap (map : in Variable_Hashed_Maps.Map);

   procedure AfficherTas (map : in Variable_Hashed_Maps.Map; tas : in T_Tas);

private

end Map_Variables;
