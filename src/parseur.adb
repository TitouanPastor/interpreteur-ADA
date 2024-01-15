package body parseur is

   ----------------------
   -- FichierToMemoire --
   ----------------------

   procedure FichierToMemoire
     (chemin : in String; memVar : out T_Tas; memCode : out T_Memoire_Code; dico_entiers : out Integer_Hashed_Maps.Map)
   is
      Fichier : File_Type;
      Ligne   : Unbounded_String;

   begin

      Open (Fichier, In_File, chemin);

      -- Lire et afficher chaque ligne du fichier
      Put_Line(" ");
      Put_Line("Fichier à parser : ");
      while not End_Of_File (Fichier) loop
         Get_Line (Fichier, Ligne);
         
         Put_Line (Ligne);
      end loop;

      Put_Line("####################################");
      Put_Line(" ");

      Close (File => Fichier);



   end FichierToMemoire;

end parseur;
