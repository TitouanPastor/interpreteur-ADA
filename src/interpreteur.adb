package body interpreteur is

   --------------------
   -- EntierVersBool --
   --------------------

   -- Fonction qui convertit un entier en booléen
   function EntierVersBool (entier : in Integer) return Boolean is
   begin
      if entier /= 0 then
         return True;
      else
         return False;
      end if;
   end EntierVersBool;
   

   -----------------
   -- TraiterGOTO --
   -----------------

   procedure TraiterGOTO (instruction : in T_Instruction; CP : out Integer) is
   begin
      CP := GetCaseInstruction (instruction, 3);
   end TraiterGOTO;

   ---------------
   -- TraiterIF --
   ---------------

   procedure TraiterIF (instruction : in T_Instruction; tas : in T_Tas; CP : in out Integer)
   is
      x : Integer; -- Variable temporaire
   begin

      -- On récupère la première valeur x
      x := GetCaseInstruction (instruction, 3);
      -- Cas d'un indice de variable du tas
      if GetCaseInstruction (instruction, 2) = 1 then
         x := GetVariable (tas, GetCaseInstruction (instruction, x));
      end if;

      if EntierVersBool(x) then
         CP := GetCaseInstruction (instruction, 6);
      else
         CP := CP + 1;
      end if;
   end TraiterIF;


   ------------------------
   -- TraiterAssignation --
   ------------------------
   
   -- Fonction traitant une assignation simple de la forme a <- x
   procedure TraiterAssignation
     (instruction : in T_Instruction; tas : out T_Tas; x : in Integer)
   is
   begin
      ModifierVariable (tas, GetCaseInstruction (instruction, 1), x);
   end TraiterAssignation;

   procedure TraiterOperation
     (instruction : in T_Instruction; tas : in out T_Tas; x : in Integer)
   is
      y : Integer;
   begin
      -- On récupère la seconde valeur z dans la forme a x op y
      y := GetCaseInstruction (instruction, 6);
      -- Cas d'un indice de variable du tas
      if GetCaseInstruction (instruction, 5) = 1 then
         y := GetVariable (tas, GetCaseInstruction (instruction, y));
      end if;

      -- Selon l'opération
      case GetCaseInstruction (instruction, 1) is
         when 1 =>
            ModifierVariable (tas, GetCaseInstruction (instruction, 1), x + y);
         when 2 =>
            ModifierVariable (tas, GetCaseInstruction (instruction, 1), x - y);
         when 3 =>
            ModifierVariable (tas, GetCaseInstruction (instruction, 1), x * y);
         when 4 =>
            ModifierVariable (tas, GetCaseInstruction (instruction, 1), x / y);
            --TODO : more arithmetics cases
         when 14 =>
            if EntierVersBool (x) and EntierVersBool (y) then
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 1);
            else
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 0);
            end if;

         when 15 =>
            if EntierVersBool (x) or EntierVersBool (y) then
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 1);
            else
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 0);
            end if;
            --TODO : more logic cases
         when others =>
            null;
      end case;
   end TraiterOperation;


   ------------------------
   -- TraiterAffectation --
   ------------------------

   -- Fonction traitant une affectation de la forme a x op y
   procedure TraiterAffectation
     (instruction : in T_Instruction; tas : in out T_Tas; CP : in out Integer)
   is
      x : Integer; -- Variable temporaire
   begin

      -- On récupère la première valeur x
      x := GetCaseInstruction (instruction, 3);
      -- Cas d'un indice de variable du tas
      if GetCaseInstruction (instruction, 2) = 1 then
         x := GetVariable (tas, GetCaseInstruction (instruction, x));
      end if;

      case GetCaseInstruction (instruction, 4) is
         -- Cas d'une simple affectation n <- 5 par exemple
         when 5 =>
            TraiterAssignation (instruction, tas, x);

            -- Cas d'une affectation avec opération binaire
         when others =>
            TraiterOperation (instruction, tas, x);
      end case;
      CP := CP + 1;
   end TraiterAffectation;

   -----------------
   -- TraiterNULL --
   -----------------

   procedure TraiterNULL (CP : in out Integer) is
   begin
      CP := CP + 1;
   end TraiterNULL;

end interpreteur;
