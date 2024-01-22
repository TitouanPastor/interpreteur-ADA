package body Menu is

   ---------------------
   -- ChoixFichier --
   ---------------------

   procedure ChoixFichier (chemin : out String) is

   begin

      Put_Line ("Merci d'entrer le chemin du fichier sans guillemets");
      Get (chemin);

   end ChoixFichier;

   ---------------------
   -- ChoixMode --
   ---------------------

   function ChoixMode return Integer is

      choix : Integer;

   begin

      Put_Line ("Saisir 1 pour le mode normal ou 2 pour le mode debeugueur");
      Get (choix);
      return choix;

   end ChoixMode;

   ---------------------
   -- ChoixSortir --
   ---------------------

   function ChoixSortir return Integer is

      choix : Integer;

   begin

      Put_Line
        ("Saisir 1 pour sortir ou 2 pour executer un nouveau programme");
      Get (choix);
      return choix;

   end ChoixSortir;

end Menu;
