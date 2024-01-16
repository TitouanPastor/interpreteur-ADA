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
      
      -- Ouverture du fichier
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
      
      while not End_Of_File (Fichier) loop
         
         -- A1 : Récupérer la ligne sous forme d'un tableau de mots
         
         Get_Line (Fichier, ligne);
         
         LigneToTabMot(ligne, tabMots);
         
         --  A2 : On traite la ligne courante
         
         If tabMots(0) = "Programme" then
            
            y := 0;
            
            while tabMots(0) /= "Début" loop
               
               -- On récupère la ligne suivante
               
               
               Put_Line (Ligne);

               -- passe la ligne sous forme d'un tableau de mots 
               
               LigneToTabMot(ligne, tabMots);
               
               -- B1 : On ajoute les variables au tas
               
               i:= 0;
               
               -- Boucle qui parcoure tout le tableau de mots
               while i /= tabMot.nbElements loop
                  
                  -- On vérifie si on ets arrivé au bout des variables
                  
                  while tabMot.tabMotLigne[i] /= ':' loop
                     
                     AjouterVariable (tas, tabMot.tabMotLigne[i]);
                     i := i+1;
                  end loop;
                  
               end loop;
               
      end loop;
      
      
      -- Fermeture du fichier
      Close (File => Fichier); 

   end FichierToMemoire;
   
     --------------------
   -- InitialiserTabMot --
     --------------------

   procedure InitialiserTabMot (TabMot : out T_Tab_Mot) is
   begin
      TabMot.nbElements := 0;
   end InitialiserTabMot;
   
   
     --------------------
   -- InitialisercntVar --
     --------------------

   procedure InitialisercntVar (compteur : out Integer) is
   begin
      compteur := 0;
   end InitialisercntVar;
   
     --------------------
   -- InitialiserDico --
     --------------------

   procedure InitialiserDico (Map : out String_Hashed_Maps.Map) is
   begin
      String_Hashed_Maps.Clear(Map);
   end InitialiserDico;
   
   
   
    --------------------
   -- LigneToTabMot --
     --------------------

   procedure LigneToTabMot (ligneCourante : in String; tabMot : out T_Mot) is
      
   begin
      
      -- Parcourir la chaîne jusqu'à la fin (caractère nul)
      
      i := 0;
      
      while ligneCourante(Index) /= Character'Val(0) loop
         
         tabMot.tabMotLigne[i] := ligneCourante(i);
         Ada.Text_IO.Put(ligneCourante(i));
         i := i + 1;
         
      end loop;
            
      tabMot.nbElements := i;
      
   end LigneToTabMot;


end parseur;
