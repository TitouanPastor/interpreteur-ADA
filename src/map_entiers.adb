with Ada.Text_IO; use Ada.Text_IO;
package body Map_entiers is

   -----------------
   -- AfficherMap --
   -----------------

   procedure AfficherMap (map : in Integer_Hashed_Maps.Map) is
   begin
      for C in map.Iterate loop
         Put_Line (Key (C) & " : " & Integer'Image (map (C)));
      end loop;
   end AfficherMap;

end Map_entiers;
