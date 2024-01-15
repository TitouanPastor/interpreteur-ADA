with tas;            use tas;
with Ada.Assertions; use Ada.Assertions;

procedure tests_tas is

   -- Test 1 :
   -- test de la procedure InitialiserTas (tas : out T_Tas);
   procedure test_InitialiserTas is
      tas : T_Tas;
   begin
      InitialiserTas (tas);
      Assert (GetNbElements (tas) = 0, "Erreur test_InitialiserTas");
   end test_InitialiserTas;

   -- Test 2 :
   -- test de la procedure AjouterVariable (indice : in Integer; valeur : in Integer);
   -- Ajout d'une variable dans le tas
   procedure test_AjouterVariable is
      Tas : T_Tas;
   begin
      InitialiserTas (Tas);
      AjouterVariable (Tas, 1);
      Assert (GetVariable (Tas, 1) = 1, "Erreur test_AjouterVariable");
   end test_AjouterVariable;

   -- Test 3 :
   -- test de la procedure GetVariable (tas : in T_Tas; indice : in Integer) return Integer;
   -- Ajout d'une variable dans le tas et récupération de la valeur
   procedure test_GetVariable is
      Tas : T_Tas;
   begin
      InitialiserTas (Tas);
      AjouterVariable (Tas, 1);
      Assert (GetVariable (Tas, 1) = 1, "Erreur test_GetVariable");
   end test_GetVariable;

   -- Test 4 :
   -- test de la procedure GetNbElements (tas : in T_Tas) return Integer;
   -- Ajout d'une variable dans le
   procedure test_GetNbElements is
      Tas : T_Tas;
   begin
      InitialiserTas (Tas);
      AjouterVariable (Tas, 1);
      AjouterVariable (Tas, 2);
      Assert (GetNbElements (Tas) = 2, "Erreur test_GetNbElements");
   end test_GetNbElements;

   --Test 5 :
   -- test de la procedure ModifierVariable (tas : in out T_Tas; indice : in Integer; valeur : in Integer);
   -- Ajout d'une variable dans le tas et modification de sa valeur
   procedure test_ModifierVariable is
      Tas : T_Tas;
   begin
      InitialiserTas (Tas);
      AjouterVariable (Tas, 1);
      ModifierVariable (Tas, 1, 2);
      Assert (GetVariable (Tas, 1) = 2, "Erreur test_ModifierVariable");
   end test_ModifierVariable;

begin
   test_InitialiserTas;
   test_AjouterVariable;
   test_GetVariable;
   test_GetNbElements;
   test_ModifierVariable;
end tests_tas;
