with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body Memoire_Code is

   ----------------------------
   -- InitialiserMemoireCode --
   ----------------------------

   procedure InitialiserMemoireCode (memoireCode : out T_Memoire_Code) is
   begin
      memoireCode.instructions_tab := (others => (0, 0, 0, 0, 0, 0));
      memoireCode.nbInstructions   := 0;
   end InitialiserMemoireCode;

   ------------------------
   -- InsererInstruction --
   ------------------------

   procedure InsererInstruction
     (memoireCode : in out T_Memoire_Code; case1 : in Integer;
      case2       : in     Integer; case3 : in Integer; case4 : in Integer;
      case5       : in     Integer; case6 : in Integer)
   is
      instruction : T_Instruction;
   begin
      instruction := (case1, case2, case3, case4, case5, case6);
      memoireCode.instructions_tab (memoireCode.nbInstructions + 1) :=
        instruction;
      memoireCode.nbInstructions := memoireCode.nbInstructions + 1;
   end InsererInstruction;

   --------------------
   -- GetInstruction --
   --------------------

   function GetInstruction
     (memoireCode : in T_Memoire_Code; cp : in Integer) return T_Instruction
   is
   begin
      return memoireCode.instructions_tab (cp);
   end GetInstruction;

   ------------------------
   -- GetCaseInstruction --
   ------------------------

   function GetCaseInstruction
     (instruction : in T_Instruction; indexCase : in Integer) return Integer
   is
   begin
      return instruction (indexCase);
   end GetCaseInstruction;

   -----------------------
   -- getNbInstructions --
   -----------------------

   function getNbInstructions (memoireCode : in T_Memoire_Code) return Integer
   is
   begin
      return memoireCode.nbInstructions;
   end getNbInstructions;

   -----------------------
   -- AfficherMemoireCode --
   -----------------------

   procedure AfficherInstruction (instruction : in T_Instruction) is
   begin
      Put (GetCaseInstruction (instruction, 1), 3);
      Put (GetCaseInstruction (instruction, 2), 3);
      Put (GetCaseInstruction (instruction, 3), 3);
      Put (GetCaseInstruction (instruction, 4), 3);
      Put (GetCaseInstruction (instruction, 5), 3);
      Put (GetCaseInstruction (instruction, 6), 3);
      New_Line (1);
   end AfficherInstruction;

end Memoire_Code;
