with Tas; use Tas;
with Memoire_Code; use Memoire_Code;
with Interpreteur; use Interpreteur;
with Ada.Assertions; use Ada.Assertions;

procedure tests_interpreteur is
   
   -- Test 1 :
   -- test de la procedure TraiterGOTO(ligne : in T_Memoire_Code_Tab; CP : out Integer);
   -- Crée une instruction GOTO 3 (|-1|0|3|x|x|x|) et l'éxecute
   procedure test_TraiterGOTO is
      cp : Integer := 1;
      mem : T_Memoire_Code;
   begin
      InsererInstruction(mem,-1,0,3,0,0,0);
      TraiterGOTO(GetInstruction(mem,cp), cp);
      Assert(cp = 3, "Erreur test_TraiterGOTO");
   end test_TraiterGOTO;
   
   
   -- Test 2 :
   -- test de la procedure TraiterIF(ligne : in T_Memoire_Code_Tab; CP : in out Integer);
   -- Crée une instruction IF 3 GOTO 5 (|-2|0|8|-1|0|5|) et l'éxecute
   procedure test_TraiterIF is
      cp : Integer := 1;
      mem : T_Memoire_Code;
   begin
      -- la condition est valide (> 0 dans la troisième case)
      InsererInstruction(mem,-2,0,8,-1,0,5);
      TraiterIF(GetInstruction(mem,cp), cp);
      Assert(cp = 5, "Erreur test_TraiterIF > 0");
      
      -- la condition n'est pas valide (0 dans la troisième case)
      cp := 2;
      InsererInstruction(mem,-2,0,0,-1,0,5);
      TraiterIF(GetInstruction(mem,cp),cp);
      Assert(cp = 3, "Erreur test_TraiterIF = 0");
   end test_TraiterIF;
   
   
   -- Test 3 :
   -- test de la procedure TraiterAffectation(ligne : in T_Memoire_Code_Tab; tas : in out T_Tas);
   -- Crée une instruction x 5 + 3 (|indice x dans le tas|0|5|1|0|3|) et l'éxecute
   procedure test_TraiterAffectation is
      cp : Integer := 1;
      mem : T_Memoire_Code;
      tas : T_Tas;
   begin
      -- Initialisation des mémoires (ajout de x dans le tas et de l'instruction dans mem)
      InitialiserTas(tas);
      AjouterVariable(tas.nbElements+1, 0);
      InsererInstruction(mem,1,0,5,1,0,3);
      TraiterAffectation(GetInstruction(mem,cp), tas, cp);
      Assert(cp = 2, "Erreur test_TraiterAffectation CP");
      Assert(GetVariable(tas, 1) = 8, "Erreur test_TraiterAffectation GetVariable(1) /= 8");
   end test_TraiterAffectation;
   
   
   -- Test 4 :
   -- test de la procedure TraiterNULL(CP : in out Integer);
   -- Crée une instruction NULL (|-3|x|x|x|x|x|) et l'éxecute
   procedure test_TraiterNULL is
      cp : Integer := 1;
      mem : T_Memoire_Code;
   begin
      InsererInstruction(mem,-3,0,0,0,0,0);
      TraiterGOTO(GetInstruction(mem,cp), cp);
      Assert(cp = 2, "Erreur test_TraiterNULL");
   end test_TraiterNULL;
   
      
begin
   test_TraiterGOTO;
   test_TraiterIF;
   test_TraiterAffectation;
   test_TraiterNULL;
   
end tests_interpreteur;
