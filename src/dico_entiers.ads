with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Hash;

package Dico_entiers is

   package Integer_Hashed_Maps is new Ada.Containers.Indefinite_Hashed_Maps
     (Key_Type => String, Element_Type => Integer, Hash => Ada.Strings.Hash,
      Equivalent_Keys => "=");
   use Integer_Hashed_Maps;

end Dico_entiers;
