with LinkedList;
with Memoire_Code; use Memoire_Code;

procedure main is

   package Memoire_Code_List is new LinkedList(T_Quadruple);
   use Memoire_Code_List;

   testMemoire : Memoire_Code_List;
begin
   null;
end main;
