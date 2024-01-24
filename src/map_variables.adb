pragma Ada_2012;
package body Map_Variables is

   -----------------
   -- AfficherMap --
   -----------------

   procedure AfficherMap (map : in Variable_Hashed_Maps.Map) is
      element : T_ElementMap;
   begin
      for C in map.Iterate loop
         element := map (C);
         Put_Line (Key (C) & " : " & Integer'Image (element.indiceTas));
      end loop;
   end AfficherMap;

   -----------------
   -- AfficherTas --
   -----------------

   procedure AfficherTas (map : in Variable_Hashed_Maps.Map; tas : in T_Tas) is
      element : T_ElementMap;
   begin
      for C in map.Iterate loop
         element := map (C);
      -- Si c'est un type caractère alors on transforme l'entier en caractère
         if element.TypeVar = Character_Type then
            Put_Line
              (Key (C) & " -> tas[" & element.indiceTas'Image & "]  = " &
               Character'Val( GetVariable(tas, element.indiceTas)));
         else
            Put_Line
              (Key (C) & " -> tas[" & element.indiceTas'Image & "]  =" &
               GetVariable (tas, element.indiceTas)'Image);
         end if;

      end loop;
   end AfficherTas;

   -- Fonction pour retrouver la clé à partir de la valeur
   function GetKeyFromValue (map : Variable_Hashed_Maps.Map; value : Integer) return Unbounded_String is
   begin
      for Pair in map.Iterate loop
         if map(Pair).indiceTas = value then
            return To_Unbounded_String (Key(Pair));
         end if;
      end loop;
      return To_Unbounded_String("");
   end GetKeyFromValue;

end Map_Variables;
