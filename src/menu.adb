package body Menu is

   -----------------------
   -- AfficherBienvenue --
   -----------------------

   procedure AfficherBienvenue is
   begin

      Put_Line (" ");
      Put_Line ("┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
      Put_Line ("┃                                                    ┃");
      Put_Line ("┃                   --------------                   ┃");
      Put_Line ("┃                  / INTERPRETEUR \                  ┃");
      Put_Line ("┃                  ----------------         Titouan  ┃");
      Put_Line ("┃                                           Margot   ┃");
      Put_Line ("┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛");
      Put_Line (" ");

   end AfficherBienvenue;

   -----------------------
   -- AfficherDebogueur --
   -----------------------

   procedure AfficherDebogueur is
   begin

      Put_Line (" ");
      Put_Line ("┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
      Put_Line ("┃                                                    ┃");
      Put_Line ("┃              /!\ Débogueur activé /!\              ┃");
      Put_Line (" ");
      Put_Line
        ("--> Voici les instructions sous forme de tableaux d'entiers : ");
      Put_Line (" ");

   end AfficherDebogueur;

   -----------------------
   -- AfficherExecuterDebogueur --
   -----------------------

   procedure AfficherExecuterDebogueur is
      temp : Unbounded_String;
   begin

      Put_Line ("--> Appuyez sur entrée pour exécuter le code");
      Skip_Line (1);
      temp := Get_Line;

   end AfficherExecuterDebogueur;

   procedure AfficherResultats is
   begin
      Put_Line (" ");
      Put_Line ("┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
      Put_Line ("┃                                                    ┃");
      Put_Line ("┃                     -----------                    ┃");
      Put_Line ("┃                    / Résultats \                   ┃");
      Put_Line ("┃                   ---------------                  ┃");
      Put_Line ("┃                                                    ┃");
      Put_Line ("┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛");
      Put_Line (" ");
   end AfficherResultats;

   ---------------------
   -- ChoixFichier -----
   ---------------------

   procedure ChoixFichier (chemin : out Unbounded_String) is
   begin

      Put_Line ("--> Merci d'entrer le chemin du fichier sans guillemets");
      Put_Line ("   *(Fichiers tests : testEntier.txt, testChar.txt, ");
      Put_Line ("                      testBool.txt, testLireEcrire.txt,");
      Put_Line ("                      testFact.txt, testAll.txt        )*");
      chemin := Get_Line;

   end ChoixFichier;

   ---------------------
   -- ChoixMode --------
   ---------------------

   function ChoixMode return Integer is

      choix : Integer;

   begin
      Put_Line
        ("--> Saisir 1 pour le mode normal ou 2 pour le mode debogueur");
      Get (choix);
      return choix;

   end ChoixMode;

   ---------------------
   -- ChoixSortir ------
   ---------------------

   function ChoixSortir return Integer is

      choix : Integer;

   begin
      Put_Line ("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
      Put_Line ("--> Saisir 1 pour sortir ou 2 pour executer un nouveau programme");
      Get (choix);
      return choix;

   end ChoixSortir;

end Menu;
