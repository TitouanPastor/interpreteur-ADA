with Memoire_Code; use Memoire_Code;
with Ada.Assertions; use Ada.Assertions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure tests_memoire_code is

   -- Test 1 :
   -- test de la procedure InitialiserMemoireCode (memoireCode : out T_Memoire_Code);
      procedure test_InitialiserMemoire is
         memoire : T_Memoire_Code;
      begin
         InitialiserMemoireCode(memoire);
         Assert(GetNbInstructions(memoire) = 0, "Erreur test_InitialiserMemoire");
      end test_InitialiserMemoire;

      -- Test 2 :
      -- test de la procedure InsererInstruction(memoireCode : in out T_Memoire_Code; case1 : in Integer;
      --                                         case2 : in Integer; case3 : in Integer; case4 : in Integer; 
      --                                         case5 : in Integer; case6 : in Integer);
      -- Ajout d'une ligne dans la mémoire
      procedure test_InsererInstruction is
         memoire : T_Memoire_Code;
      begin
         InitialiserMemoireCode(memoire);
         InsererInstruction(memoire, 1, 1, 1, 1, 1, 1);
         Assert(GetCaseInstruction(GetInstruction(memoire, 1), 1) = 1, "Erreur test_InsererInstruction");
      end test_InsererInstruction;

      -- Test 3 :
      -- test de la procedure GetInstruction(memoireCode : in T_Memoire_Code; cp : in Integer) return T_Memoire_Code_Tab;
      -- Ajout d'une ligne dans la mémoire et récupération de la valeur
      procedure test_GetInstruction is
         memoire : T_Memoire_Code;
      begin
         InitialiserMemoireCode(Memoire);
         InsererInstruction(memoire, 1, 1, 1, 1, 1, 1);
         Assert(GetCaseInstruction(GetInstruction(memoire, 1), 1) = 1, "Erreur test_GetInstruction");
      end test_GetInstruction;

      -- Test 4 :
      -- test de la procedure GetNbInstructions (memoire : in T_Memoire_Code) return Integer;
      -- Ajout de lignes dans la mémoire
      procedure test_GetNbInstructions is
         memoire : T_Memoire_Code;
      begin
         InitialiserMemoireCode(Memoire);
         InsererInstruction(memoire, 1, 1, 1, 1, 1, 1);
         InsererInstruction(memoire, 2, 2, 2, 2, 2, 2);
         Assert(GetNbInstructions(memoire) = 2, "Erreur test_GetNbInstructions");
      end test_GetNbInstructions;

      -- Test 5 :
      -- test de la procedure GetCaseInstruction(memoireCode : in T_Memoire_Code; indexCase : in Integer) return Integer;
      -- Ajout d'une ligne dans la mémoire et récupération de la valeur de la case 1
      procedure test_GetCaseInstruction is
         memoire : T_Memoire_Code;
      begin
         InitialiserMemoireCode(Memoire);
         InsererInstruction(memoire, 1, 1, 1, 1, 1, 1);
         Assert(GetCaseInstruction(GetInstruction(memoire, 1), 1) = 1, "Erreur test_GetCaseInstruction");
      end test_GetCaseInstruction;

   begin
      test_InitialiserMemoire;
      test_InsererInstruction;
      test_GetInstruction;
      test_GetNbInstructions;
      test_GetCaseInstruction;
   end tests_memoire_code;
