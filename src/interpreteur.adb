package body interpreteur is

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

   procedure TraiterIF (instruction : in T_Instruction; CP : in out Integer) is
   begin
      if GetCaseInstruction (instruction, 3) /= 0 then
         CP := GetCaseInstruction (instruction, 6);
      else
         CP := CP + 1;
      end if;
   end TraiterIF;

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


   ------------------------
   -- TraiterAssignation --
   ------------------------
   
   -- Fonction traitant une assignation simple de la forme x <- y
   procedure TraiterAssignation
     (instruction : in T_Instruction; tas : out T_Tas; y : in Integer)
   is
   begin
      ModifierVariable (tas, GetCaseInstruction (instruction, 1), y);
   end TraiterAssignation;

   procedure TraiterOperation
     (instruction : in T_Instruction; tas : in out T_Tas; y : in Integer)
   is
      z : Integer;
   begin
      -- On récupère la seconde valeur z dans la forme x y op z
      z := GetCaseInstruction (instruction, 6);
      -- Cas d'un indice de variable du tas
      if GetCaseInstruction (instruction, 5) = 1 then
         z := GetVariable (tas, GetCaseInstruction (instruction, z));
      end if;

      -- Selon l'opération
      case GetCaseInstruction (instruction, 1) is
         when 1 =>
            ModifierVariable (tas, GetCaseInstruction (instruction, 1), y + z);
         when 2 =>
            ModifierVariable (tas, GetCaseInstruction (instruction, 1), y - z);
         when 3 =>
            ModifierVariable (tas, GetCaseInstruction (instruction, 1), y * z);
         when 4 =>
            ModifierVariable (tas, GetCaseInstruction (instruction, 1), y / z);
            --TODO : more arithmetics cases
         when 14 =>
            if EntierVersBool (y) and EntierVersBool (z) then
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 1);
            else
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 0);
            end if;

         when 15 =>
            if EntierVersBool (y) or EntierVersBool (z) then
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

   -- Fonction traitant une affectation de la forme x <- y op z
   procedure TraiterAffectation
     (instruction : in T_Instruction; tas : in out T_Tas; CP : in out Integer)
   is
      y : Integer; -- Variable temporaire
   begin

      -- On récupère la première valeur y dans la forme x y op z
      y := GetCaseInstruction (instruction, 3);
      -- Cas d'un indice de variable du tas
      if GetCaseInstruction (instruction, 2) = 1 then
         y := GetVariable (tas, GetCaseInstruction (instruction, y));
      end if;

      case GetCaseInstruction (instruction, 4) is
         -- Cas d'une simple affectation n <- 5 par exemple
         when 5 =>
            TraiterAssignation (instruction, tas, y);

            -- Cas d'une affectation avec opération binaire
         when others =>
            TraiterOperation (instruction, tas, y);
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
