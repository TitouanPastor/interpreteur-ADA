with Tas; use Tas;
with Memoire_Code; use Memoire_Code;
with parseur; use parseur;
with interpreteur; use interpreteur;

procedure main is

   --  Programme Test est
   --      a,b,c : Entier
   --  Début
   --      1 a <- 2
   --      2 b <- 2 * 8
   --      3 c <- 0
   --      4 IF c GOTO 8
   --      5 c <- b / a
   --      6 GOTO 5
   --      7 NULL
   --  Fin
   procedure GenererMemoires
     (memoireCode : out T_Memoire_Code; tas : out T_Tas)
   is
   begin
      InitialiserTas (tas);
      InitialiserMemoireCode (memoireCode);
      -- Ajout des variables dans le tas (a,b,c)
      AjouterVariable (tas, 0);
      AjouterVariable (tas, 0);
      AjouterVariable (tas, 0);
      -- Ajout des instructions dans la mémoire code
      AjouterInstruction (memoireCode, 1, 0, 2, 0, 0, 0);
      AjouterInstruction (memoireCode, 2, 0, 2, 3, 0, 8);
      AjouterInstruction (memoireCode, 3, 0, 0, 0, 0, 0);
      AjouterInstruction (memoireCode, -2, 1, 3, -1, 0, 8);
      AjouterInstruction (memoireCode, 3, 1, 2, 4, 1, 1);
      AjouterInstruction (memoireCode, -1, 0, 5, 0, 0, 0);
      AjouterInstruction (memoireCode, -3, 0, 0, 0, 0, 0);

   end GenererMemoires;

   memoireCode : T_Memoire_Code;
   tas         : T_Tas;

begin

   GenererMemoires (T_Memoire_Code, tas);

end main;
