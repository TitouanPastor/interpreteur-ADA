package tas is

   CAPACITE : Integer := 500;

   type T_Tab_Tas is private;

   type T_Tas is record
      tas : T_Tab_Tas;
      nbElements : Integer;
   end record;

private

   type T_Tab_Tas is array(1..CAPACITE) of Integer;

end tas;
