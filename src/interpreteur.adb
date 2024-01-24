with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

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

   procedure TraiterIF
     (instruction : in T_Instruction; tas : in T_Tas; CP : in out Integer)
   is
      x : Integer; -- Variable temporaire
   begin

      -- On récupère la première valeur x
      x := GetCaseInstruction (instruction, 3);
      -- Cas d'un indice de variable du tas
      if GetCaseInstruction (instruction, 2) = 5 then
         Put_Line ("Index " & x'Image);
         x := GetVariable (tas, x);
         Put_Line ("Value " & x'Image);
      end if;

      if EntierVersBool (x) then
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
         Put_Line ("Récupération variable y : ");
         Put ("Index dans tab : ");
         Put_Line (y'Image);
         y := GetVariable (tas, y);
         Put ("valeur y : ");
         Put_Line (y'Image);
      end if;

      -- Selon l'opération
      case GetCaseInstruction (instruction, 4) is
         -- arithmétique
         --Entiers
         when 1 =>
            ModifierVariable (tas, GetCaseInstruction (instruction, 1), x + y);
         when 2 =>
            ModifierVariable (tas, GetCaseInstruction (instruction, 1), x - y);
         when 3 =>
            ModifierVariable (tas, GetCaseInstruction (instruction, 1), x * y);
         when 4 =>
            ModifierVariable (tas, GetCaseInstruction (instruction, 1), x / y);
         when 6 =>
            ModifierVariable
              (tas, GetCaseInstruction (instruction, 1), x mod y);
            -- Caractères
         when 21 => --TODO
            --ModifierVariable(tas, GetCaseInstruction (instruction, 1), x + y);
            null;
            -- Logique
         when 7 =>
            if x = y then
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 1);
            else
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 0);
            end if;

         when 8 =>
            if x < y then
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 1);
            else
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 0);
            end if;
         when 9 =>
            if x > y then
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 1);
            else
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 0);
            end if;
         when 10 =>
            if x <= y then
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 1);
            else
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 0);
            end if;
         when 11 =>
            if x >= y then
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 1);
            else
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 0);
            end if;
         when 12 =>
            if x /= y then
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 1);
            else
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 0);
            end if;
         when 14 =>
            if EntierVersBool (x) or EntierVersBool (y) then
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 1);
            else
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 0);
            end if;
         when 15 =>
            if EntierVersBool (x) and EntierVersBool (y) then
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 1);
            else
               ModifierVariable (tas, GetCaseInstruction (instruction, 1), 0);
            end if;
            --TODO : more logic cases
            -- Caractères
         when 27 =>
            ModifierVariable
              (tas, GetCaseInstruction (instruction, 1), Boolean'Pos (x = y));
         when 32 =>
            ModifierVariable
              (tas, GetCaseInstruction (instruction, 1), Boolean'Pos (x /= y));
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
      if GetCaseInstruction (instruction, 2) = 1 or
        GetCaseInstruction (instruction, 2) = 3 or
        GetCaseInstruction (instruction, 2) = 5
      then
         Put_Line ("Récupération variable x : ");
         Put ("Index dans tab : ");
         Put_Line (x'Image);
         x := GetVariable (tas, x);
         Put ("valeur x :");
         Put_Line (x'Image);
      end if;

      case GetCaseInstruction (instruction, 4) is
         -- Cas d'une simple affectation n <- 5 par exemple
         when 5 | 25 =>
            TraiterAssignation (instruction, tas, x);

            -- Cas d'une affectation avec opération binaire
         when others =>
            TraiterOperation (instruction, tas, x);
      end case;
      CP := CP + 1;
   end TraiterAffectation;

   -----------------
   -- TraiterLire --
   -----------------

   procedure TraiterLire
     (instruction : in     T_Instruction;
      mapVariable : in     Variable_Hashed_Maps.Map; tas : in out T_Tas;
      CP          : in out Integer)
   is
      nomVar    : Unbounded_String;
      indiceVar : Integer;
      getInt    : Integer;
      getChar   : Character;
      getBool   : Integer;
   begin
      -- On récupère la valeur à écrire
      indiceVar := GetCaseInstruction (instruction, 3);
      -- On récupère le nom de la variable
      nomVar    := GetKeyFromValue (mapVariable, indiceVar);
      -- On l'affiche suivant le type de la variable
      case GetCaseInstruction (instruction, 2) is
         when 1 =>
            Put ("Entrez un entier pour " & nomVar & " : ");
            Get (getInt);
            ModifierVariable (tas, indiceVar, getInt);
         when 3 =>
            Put ("Entrez un caractère pour " & nomVar & " : ");
            Get (getChar);
            ModifierVariable (tas, indiceVar, Character'Pos (getChar));
            Skip_Line(1);
         when 5 =>
            Put ("Entrez un booléen pour " & nomVar & " : (0/1) ");
            Get (getBool);
            ModifierVariable (tas, indiceVar, getBool);
         when others =>
            Put_Line ("Type inconnu");
      end case;
      CP := CP + 1;
   end TraiterLire;

   -------------------
   -- TraiterEcrire --
   -------------------

   procedure TraiterEcrire
     (instruction : in     T_Instruction;
      mapVariable : in     Variable_Hashed_Maps.Map; tas : in out T_Tas;
      CP          : in out Integer)
   is
      valeurVar : Integer;
      indiceVar : Integer;
   begin
      -- On récupère la valeur à écrire
      indiceVar := GetCaseInstruction (instruction, 3);
      valeurVar := GetVariable (tas, GetCaseInstruction (instruction, 3));
      -- On l'affiche suivant le type de la variable
      case GetCaseInstruction (instruction, 2) is
         when 1 =>
            Put_Line
              (GetKeyFromValue (mapVariable, indiceVar) & " = " &
               valeurVar'Image);
         when 3 =>
            Put_Line
              (GetKeyFromValue (mapVariable, indiceVar) & " = " &
               Character'Val (valeurVar));
         when 5 =>
            Put_Line
              (GetKeyFromValue (mapVariable, indiceVar) & " = " &
               valeurVar'Image);
         when others =>
            Put_Line ("Type inconnu");
      end case;
      CP := CP + 1;
   end TraiterEcrire;

   -----------------
   -- TraiterNULL --
   -----------------

   procedure TraiterNULL (CP : in out Integer) is
   begin
      CP := CP + 1;
   end TraiterNULL;

end interpreteur;
