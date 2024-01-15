with tas;          use tas;
with Memoire_Code; use Memoire_Code;
with parseur; use parseur;
with interpreteur;        use interpreteur;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Dico_entiers; use Dico_entiers;

procedure main is

   --  Programme Test est
   --      a,b,c : Entier
   --  Début
   --      1 a <- 2
   --      2 b <- 2 * 8
   --      3 c <- 0
   --      4 IF c GOTO 7
   --      5 c <- b / a
   --      6 GOTO 4
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
      InsererInstruction (memoireCode, 1, 0, 2, 5, 0, 0);
      InsererInstruction (memoireCode, 2, 0, 2, 3, 0, 8);
      InsererInstruction (memoireCode, 3, 0, 0, 5, 0, 0);
      InsererInstruction (memoireCode, -2, 1, 3, -1, 0, 7);
      InsererInstruction (memoireCode, 3, 1, 2, 4, 1, 1);
      InsererInstruction (memoireCode, -1, 0, 4, 0, 0, 0);
      InsererInstruction (memoireCode, -3, 0, 0, 0, 0, 0);

   end GenererMemoires;

   mem : T_Memoire_Code;
   tas : T_Tas;
   cp  : Integer;
   dico : Integer_Hashed_Maps.Map;

begin

   InitialiserMemoireCode (mem);
   InitialiserTas (tas);
   cp := 1;

   -- Genere les mémoires tas et code
   GenererMemoires (mem, tas);
   FichierToMemoire("test.txt", tas, mem, dico);

   -- Parser le fichier txt du code intermédiaire pour le mettre en mémoire
   while cp <= getNbInstructions (mem) loop

      --Affichage de cp et de la memoire tas
      Put_Line (" ");
      Put ("Cp = ");
      Put_Line (cp'Image);

      -- affichage du tas
      Put_Line ("Tas : ");
      for i in 1 .. GetNbElements (tas) loop
         Put_Line (i'Image & " : " & GetVariable (tas, i)'Image);
      end loop;

      -- A1 : Traiter la ligne du code intermédiaire
      case GetCaseInstruction (GetInstruction (mem, cp), 1) is

         when (-1) =>
            -- B1 : Traiter le branchement GOTO label
            TraiterGOTO (GetInstruction (mem, cp), cp);

         when (-2) =>
            -- B2 : Traiter le cas de la condition
            TraiterIF (GetInstruction (mem, cp), tas, cp);

         when (-3) =>
            -- B3 : Traiter le cas NULL
            TraiterNULL (cp);

         when others =>
            -- B4 : Traiter l'affectation
            TraiterAffectation (GetInstruction (mem, cp), tas, cp);

      end case;

   end loop;

   -- print(cp);
   -- print(tas);

end main;
