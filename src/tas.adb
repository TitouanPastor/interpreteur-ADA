pragma Ada_2012;
package body tas is

   --------------------
   -- InitialiserTas --
   --------------------

   procedure InitialiserTas (tas : out T_Tas) is
   begin
      tas.nbElements := 0;

   end InitialiserTas;

   ---------------------
   -- AjouterVariable --
   ---------------------

   procedure AjouterVariable (tas : in out T_Tas; valeur : in Integer) is
   begin
      tas.tas_Tab(tas.nbElements+1) := valeur;
      tas.nbElements := tas.nbElements +1;

   end AjouterVariable;

   -----------------
   -- GetVariable --
   -----------------

   function GetVariable (tas : in T_Tas; indice : in Integer) return Integer is
   begin
      return tas.tas_Tab(indice);

   end GetVariable;

   -------------------
   -- GetNbElements --
   -------------------

   function GetNbElements (tas : in T_Tas) return Integer is
   begin
     return tas.nbElements;

   end GetNbElements;

end tas;
