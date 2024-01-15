pragma Ada_2012;
package body tas is

   --------------------
   -- InitialiserTas --
   --------------------

   procedure InitialiserTas (tas : out T_Tas) is
   begin
      pragma Compile_Time_Warning
        (Standard.True, "InitialiserTas unimplemented");
      raise Program_Error with "Unimplemented procedure InitialiserTas";
   end InitialiserTas;

   ---------------------
   -- AjouterVariable --
   ---------------------

   procedure AjouterVariable (tas : in out T_Tas; valeur : in Integer) is
   begin
      pragma Compile_Time_Warning
        (Standard.True, "AjouterVariable unimplemented");
      raise Program_Error with "Unimplemented procedure AjouterVariable";
   end AjouterVariable;

   -----------------
   -- GetVariable --
   -----------------

   function GetVariable (tas : in T_Tas; indice : in Integer) return Integer is
   begin
      pragma Compile_Time_Warning (Standard.True, "GetVariable unimplemented");
      return raise Program_Error with "Unimplemented function GetVariable";
   end GetVariable;

   -------------------
   -- GetNbElements --
   -------------------

   function GetNbElements (tas : in T_Tas) return Integer is
   begin
      pragma Compile_Time_Warning
        (Standard.True, "GetNbElements unimplemented");
      return raise Program_Error with "Unimplemented function GetNbElements";
   end GetNbElements;

end tas;
