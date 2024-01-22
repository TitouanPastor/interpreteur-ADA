pragma Ada_2012;
package body Map_Variables is

   -----------------
   -- AfficherMap --
   -----------------

   procedure AfficherMap (map : in Variable_Hashed_Maps.Map) is
      element : T_ElementMap;
   begin
      for C in map.Iterate loop
         Element := Map(C);
         Put_Line (Key (C) & " : " & Integer'Image (Element.indiceTas));
      end loop;
   end AfficherMap;

   -----------------
   -- AfficherTas --
   -----------------

   procedure AfficherTas (map : in Variable_Hashed_Maps.Map; tas : in T_Tas) is
            element : T_ElementMap;
   begin
      for C in map.Iterate loop
         Element := Map(C);
         Put_Line (Key (C) & " : " & GetVariable(tas, Element.indiceTas)'Image);
      end loop;
   end AfficherTas;

end Map_Variables;
