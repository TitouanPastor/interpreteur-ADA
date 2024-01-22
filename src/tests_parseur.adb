with Ada.Assertions; use Ada.Assertions;
with Map_Variables; use Map_Variables;
with tas;            use tas;
with parseur;        use parseur;
with Memoire_Code;   use Memoire_Code;
with Ada.Text_IO;    use Ada.Text_IO;

procedure tests_parseur is

   -- Test 1 :
   -- test de la procedure FichierToMemoire
   --                     (chemin : String; memVar : out T_Tas; memCode : out T_Memoire_Code);
   -- avec chemin = "test.txt"
   -- /!\ Le test n'est pas encore complet /!\
   -- @todo
   procedure test_FichierToMemoire is
      mem         : T_Memoire_Code;
      tas         : T_Tas;
      mapVariable : Variable_Hashed_Maps.Map;
   begin
      InitialiserMemoireCode (mem);
      InitialiserTas (tas);

      FichierToMemoire ("testChar.txt", tas, mem, mapVariable);
      Assert(GetCaseInstruction(GetInstruction(mem, 1),1) = 1, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 1),2) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 1),3) = 2, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 1),4) = 5, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 1),5) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 1),6) = 0, "Erreur test_FichierToMemoire");

      Assert(GetCaseInstruction(GetInstruction(mem, 2),1) = 2, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 2),2) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 2),3) = 2, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 2),4) = 3, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 2),5) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 2),6) = 8, "Erreur test_FichierToMemoire");

      Assert(GetCaseInstruction(GetInstruction(mem, 3),1) = 3, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 3),2) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 3),3) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 3),4) = 5, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 3),5) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 3),6) = 0, "Erreur test_FichierToMemoire");

      Assert(GetCaseInstruction(GetInstruction(mem, 4),1) = -2, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 4),2) = 1, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 4),3) = 3, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 4),5) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 4),6) = 7, "Erreur test_FichierToMemoire");

      Assert(GetCaseInstruction(GetInstruction(mem, 5),1) = 3, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 5),2) = 1, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 5),3) = 2, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 5),4) = 4, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 5),5) = 1, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 5),6) = 1, "Erreur test_FichierToMemoire");

      Assert(GetCaseInstruction(GetInstruction(mem, 6),1) = -1, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 6),2) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 6),3) = 4, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 6),4) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 6),5) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 6),6) = 0, "Erreur test_FichierToMemoire");

      Assert(GetCaseInstruction(GetInstruction(mem, 7),1) = -3, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 7),2) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 7),3) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 7),4) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 7),5) = 0, "Erreur test_FichierToMemoire");
      Assert(GetCaseInstruction(GetInstruction(mem, 7),6) = 0, "Erreur test_FichierToMemoire");
   end test_FichierToMemoire;

begin
   test_FichierToMemoire;
end tests_parseur;
