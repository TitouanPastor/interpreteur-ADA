with tas;                 use tas;
with Memoire_Code;        use Memoire_Code;
with parseur;             use parseur;
with interpreteur;        use interpreteur;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Map_Variables;       use Map_Variables;
with Menu;                use Menu;

with Ada.Strings.Unbounded;         use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

procedure main is

   mem               : T_Memoire_Code;
   tas               : T_Tas;
   cp                : Integer;
   mapVariable       : Variable_Hashed_Maps.Map;
   cheminFichier     : Unbounded_String;
   choixModeResult   : Integer;
   choixSortirResult : Integer;

begin

   AfficherBienvenue;
   choixSortirResult := 2;

   while choixSortirResult = 2 loop

      InitialiserMemoireCode (mem);
      InitialiserTas (tas);
      mapVariable.Clear;
      cp := 1;

      -- Choix du fichier
      ChoixFichier (cheminFichier);

      -- Choix du mode (2 : deboggeur ou 1 : normal)
      choixModeResult := ChoixMode;

      -- Parser le fichier intermédiaire afin de remplir chaque mémoire
      FichierToMemoire (To_String (cheminFichier), tas, mem, mapVariable);

      -- Traitement différent si mode deboggeur activé
      if choixModeResult = 2 then
         AfficherDebogueur;
         AfficherMemoireCode (mem);
         AfficherExecuterDebogueur;
      end if;

      -- itérer sur chaque instruction et l'exécuter
      while cp <= getNbInstructions (mem) loop

         -- Affichage débogueur de l'instruction courante
         if choixModeResult = 2 then
            Put ("-> Après exécution instruction de label Cp = ");
            Put_Line (cp'Image);
         end if;

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
            when (-4) =>
               -- B3 : Traiter le cas Lire(x)
               TraiterLire (GetInstruction (mem, cp), mapVariable, tas, cp);
            when (-5) =>
               -- B4 : Traiter le cas Ecrire(x)
               TraiterEcrire (GetInstruction (mem, cp), mapVariable, tas, cp);
            when others =>
               -- B5 : Traiter l'affectation
               TraiterAffectation (GetInstruction (mem, cp), tas, cp);

         end case;

         -- Affichage de l'état de la mémoire si le mode debogeur est activé
         if choixModeResult = 2 then
            Put ("-> Cp = ");
            Put_Line (cp'Image);

            -- affichage du tas
            Put_Line ("-> Tas : ");
            AfficherTas (mapVariable, tas);
            Put_Line (" ");
            Put_Line (" ");
         end if;
      end loop;

      AfficherResultats;
      AfficherTas (mapVariable, tas);
      Put_Line (" ");
      Put_Line (" ");

      -- On demande à l'utilisateur si il veut quitter ou lancer un nouveau programme
      choixSortirResult := ChoixSortir;
      Skip_Line (1);
      Put_Line (" ");
      Put_Line (" ");

   end loop;

end main;
