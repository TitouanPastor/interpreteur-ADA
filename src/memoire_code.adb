pragma Ada_2012;
package body Memoire_Code is

  ----------------------------
  -- InitialiserMemoireCode --
  ----------------------------

  procedure InitialiserMemoireCode (memoireCode : out T_Memoire_Code) is
  begin
    memoireCode.nbInstructions := 0;
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
    memoireCode.instructions_tab (memoireCode.nbInstructions) := instruction;
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

end Memoire_Code;
