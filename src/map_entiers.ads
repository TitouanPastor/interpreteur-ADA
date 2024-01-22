with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Unbounded;         use Ada.Strings.Unbounded;
with Ada.Strings.Hash;
with tas; use tas;

package Map_entiers is

   package Integer_Hashed_Maps is new Ada.Containers.Indefinite_Hashed_Maps
     (Key_Type => String, Element_Type => Integer, Hash => Ada.Strings.Hash,
      Equivalent_Keys => "=");
   use Integer_Hashed_Maps;
   
   procedure AfficherMap(map : in Integer_Hashed_Maps.Map);
   
   procedure AfficherTas(map : in Integer_Hashed_Maps.Map; tas : in T_Tas);

end Map_entiers;
