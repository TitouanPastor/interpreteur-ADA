package Memoire_Code is

   type T_Valeur_Element is private;

   type T_Quadruple is array(1..4) of T_Valeur_Element;

private
   type T_Valeur_Element is record
        typeVal : Unbounded_String;
        valeur : Unbounded_String;
    end record;

end Memoire_Code;
