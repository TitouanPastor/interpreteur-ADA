package body parseur is

--------------------
   -- InitialiserTabMot --
   --------------------

   procedure InitialiserTabMot (TabMot : out T_Mot) is
   begin
      TabMot.nbElements := 0;
   end InitialiserTabMot;

   --------------------
   -- InitialisercntVar --
   --------------------

   procedure InitialisercntVar (cntVar : out Integer) is
   begin
      cntVar := 1;
   end InitialisercntVar;

   --------------------
   -- InitialiserDico --
   --------------------

   procedure InitialiserDico (Map : out Integer_Hashed_Maps.Map) is
   begin
      Integer_Hashed_Maps.Clear (Map);
   end InitialiserDico;

   --------------------
   -- LigneToTabMot --
   --------------------

   procedure LigneToTabMots (Fichier : in out File_Type; tabMot : out T_Mot) is
      Mot           : Unbounded_String;
      ligneCourante : Unbounded_String;
   begin
      -- On reinitialise le tableau de mots
      InitialiserTabMot (tabMot);
      -- On récupere la ligne courante
      Get_Line (Fichier, ligneCourante);
      Put_Line (ligneCourante);
      -- Parcourir la ligne et extraire les mots
      for Index in 1 .. Length (ligneCourante) loop
         -- Si le caractère n'est pas un espace, ajouter au mot temporaire
         if Element (ligneCourante, Index) /= ' ' then
            Mot := Mot & Element (ligneCourante, Index);
         else
   -- Ajouter le mot temporaire au tableau et réinitialiser le mot temporaire
            if Mot /= To_Unbounded_String (" ") and
              Mot /= To_Unbounded_String ("")
            then
               tabMot.tabMotLigne (tabMot.nbElements + 1) := Mot;
               tabMot.nbElements := tabMot.nbElements + 1;
               Mot := To_Unbounded_String ("");
            end if;
         end if;
      end loop;

      -- Ajouter le dernier mot s'il y en a un
      if Mot /= To_Unbounded_String (" ") and Mot /= To_Unbounded_String ("")
      then
         tabMot.tabMotLigne (tabMot.nbElements + 1) := Mot;
         tabMot.nbElements                          := tabMot.nbElements + 1;
      end if;

      --Affichage du tableau de mots
      for Index in 1 .. tabMot.nbElements loop
         Put (Index'Image & " : ");
         Put_Line (tabMot.tabMotLigne (Index));
      end loop;

   end LigneToTabMots;

   procedure InitMapOperations (map : out Integer_Hashed_Maps.Map) is
   begin
      map.Include ("+", 1);
      map.Include ("-", 2);
      map.Include ("*", 3);
      map.Include ("/", 4);
      map.Include ("->", 5);
      map.Include ("%", 6);
      map.Include ("=", 7);
      map.Include ("<", 8);
      map.Include (">", 9);
      map.Include ("<=", 10);
      map.Include (">=", 11);
      map.Include ("/=", 12);
      map.Include ("BETWEEN", 13);
      map.Include ("OR", 14);
      map.Include ("AND", 15);
   end InitMapOperations;

   procedure ParserOperation
     (mapVariable   : in     Integer_Hashed_Maps.Map;
      mapOperations : in     Integer_Hashed_Maps.Map; tabMots : in T_Mot;
      memCode       :    out T_Memoire_Code)
   is
      x, y : Integer; -- valeur dans les opérations x <- y op z avec y et z pouvant etre des variables ou des constantes
      xIsVariable, yIsVariable : Integer;
   begin
      -- On regarde si la première opérande est une constante ou une variable
      if mapVariable.Contains (To_String (tabMots.tabMotLigne (4))) then
         x           := mapVariable (To_String (tabMots.tabMotLigne (4)));
         xIsVariable := 1;
      else
         x           := Integer'Value (To_String (tabMots.tabMotLigne (4)));
         xIsVariable := 0;
      end if;

      --Si l'instruction est une simple assignation ( x <- 4)
      if tabMots.nbElements = 4 then
         InsererInstruction
           (memCode, mapVariable (To_String (tabMots.tabMotLigne (2))),
            xIsVariable, x, mapOperations ("->"), 0, 0);
      else -- Sinon on regarde la seconde opérande

         if mapVariable.Contains (To_String (tabMots.tabMotLigne (6))) then
            y           := mapVariable (To_String (tabMots.tabMotLigne (6)));
            yIsVariable := 1;
         else
            y           := Integer'Value (To_String (tabMots.tabMotLigne (6)));
            yIsVariable := 0;
         end if;
         InsererInstruction
           (memCode, mapVariable (To_String (tabMots.tabMotLigne (2))),
            xIsVariable, x,
            mapOperations (To_String (tabMots.tabMotLigne (5))), yIsVariable,
            y);
      end if;
   end ParserOperation;

   procedure ParserGoto (memCode : out T_Memoire_Code; tabMots : in T_Mot) is
   begin
      InsererInstruction
        (memCode, -1, 0, Integer'Value (To_String (tabMots.tabMotLigne (3))),
         0, 0, 0);
   end ParserGoto;

   procedure ParserIf
     (mapVariable : in Integer_Hashed_Maps.Map; memCode : out T_Memoire_Code;
      tabMots     : in T_Mot)
   is
   begin
      if mapVariable.Contains (To_String (tabMots.tabMotLigne (3))) then
         InsererInstruction
           (memCode, -2, 1, mapVariable (To_String (tabMots.tabMotLigne (3))),
            0, 0, Integer'Value (To_String (tabMots.tabMotLigne (5))));
      else
         InsererInstruction
           (memCode, -2, 0,
            Integer'Value (To_String (tabMots.tabMotLigne (3))), 0, 0,
            Integer'Value (To_String (tabMots.tabMotLigne (5))));
      end if;
   end ParserIf;

   procedure ParserNull (memCode : out T_Memoire_Code) is
   begin
      InsererInstruction (memCode, -3, 0, 0, 0, 0, 0);
   end ParserNull;

   procedure TraiterDeclarationsVariables
     (Fichier     : in out File_Type; tabMots : in out T_Mot; tas : out T_Tas;
      mapVariable : in out Integer_Hashed_Maps.Map)
   is
      i          : Integer;
      cntVar     : Integer;
      tempNomVar : Unbounded_String;
   begin
      Put_Line ("######### Dans la déclaration des variables");
      InitialisercntVar (cntVar);
      while tabMots.tabMotLigne (1) /= "Début" loop
         i := 1;
         -- Boucle qui parcoure tout le tableau de mots
         -- On vérifie si on ets arrivé au bout des variables
         while tabMots.tabMotLigne (i) /= ":" loop
            AjouterVariable (tas, 0);
            tempNomVar := tabMots.tabMotLigne (i);

            -- Vérifier si le mot suivant est ":"
            if i < tabMots.nbElements
              and then tabMots.tabMotLigne (i + 1) = ":"
            then
               -- La variable n'est pas suivie par une virgule
               mapVariable.Include (To_String (tempNomVar), cntVar);
            else
               -- La variable est suivie par une virgule
               mapVariable.Include
                 (To_String (tempNomVar) (1 .. Length (tempNomVar) - 1),
                  cntVar);
            end if;
            Put ("Ajout de " & tempNomVar);
            Put (" à l'indice " & cntVar'Image);
            Put_Line (" ");
            cntVar := cntVar + 1;
            i      := i + 1;
         end loop;
         LigneToTabMots (Fichier, tabMots);
      end loop;

      Put_Line ("######### Sortie déclaration variables");
   end TraiterDeclarationsVariables;

   ----------------------
   -- FichierToMemoire --
   ----------------------

   procedure FichierToMemoire
     (chemin      : in String; tas : out T_Tas; memCode : out T_Memoire_Code;
      mapVariable :    out Integer_Hashed_Maps.Map)
   is
      Fichier       : File_Type;
      Ligne         : Unbounded_String;
      tabMots       : T_Mot;
      mapOperations : Integer_Hashed_Maps.Map;

   begin

      -- Ouverture du fichier
      Open (Fichier, In_File, chemin);

      --  Initialisation
      InitialiserTabMot (tabMots);
      InitMapOperations (mapOperations);

      --Main loop
      while not End_Of_File (Fichier) and then tabMots.tabMotLigne (1) /= "Fin" loop

         LigneToTabMots (Fichier, tabMots);

      -- On traite la ligne courante
      -- Cas du programme avec la déclaration des variable à la ligne suivante
         if tabMots.tabMotLigne (1) = "Programme" then

            LigneToTabMots (Fichier, tabMots);

            TraiterDeclarationsVariables (Fichier, tabMots, tas, mapVariable);

         end if;

         -- Cas du programme avec les instructions
         if tabMots.tabMotLigne (1) = "Début" then

            Put_Line ("######### Dans les instructions");
            LigneToTabMots (Fichier, tabMots);

            while tabMots.tabMotLigne (1) /= "Fin" loop

               -- On traite la ligne d'instruction
               -- Si le premier terme de la ligne (en skippant le num de ligne) est une variable
               -- OPERATION
               if mapVariable.Contains (To_String (tabMots.tabMotLigne (2)))
               then
                  Put_Line ("-> OPE");
                  ParserOperation
                    (mapVariable, mapOperations, tabMots, memCode);

                  -- GOTO
               elsif tabMots.tabMotLigne (2) = To_Unbounded_String ("GOTO")
               then
                  Put_Line ("-> GOTO");
                  ParserGoto (memCode, tabMots);

                  -- IF
               elsif tabMots.tabMotLigne (2) = To_Unbounded_String ("IF") then
                  Put_Line ("-> IF");
                  ParserIf (mapVariable, memCode, tabMots);

                  -- NULL
               elsif tabMots.tabMotLigne (2) = To_Unbounded_String ("NULL")
               then
                  Put_Line ("-> NULL");
                  ParserNull (memCode);

               else
                  Put_Line ("-> Non reconnu");
               end if;

               LigneToTabMots (Fichier, tabMots);
            end loop;
            Put_Line ("######### Sortie instructions");
         end if;
      end loop;



      -- Affichage de la map dico_entiers
      Put_Line ("####################################");
      Put_Line (" ");
      Put_Line ("Affichage de la map mapVariable : ");
      Put_Line (" ");

      AfficherMap (mapVariable);

      Put_Line ("####################################");
      Put_Line (" ");
      Put_Line ("Affichage du tas : ");
      Put_Line (" ");

      -- Affichage du tas
      for i in 1 .. GetNbElements (tas) loop
         Put_Line (i'Image & " : " & GetVariable (tas, i)'Image);
      end loop;

      Put_Line ("####################################");
      Put_Line (" ");
      Put_Line ("Affichage de la mémoire de code : ");

      -- Affichage de la mémoire de code
      for i in 1 .. getNbInstructions (memCode) loop
         Put (i'Image & " : ");
         AfficherInstruction(GetInstruction (memCode, i));
      end loop;

      Put_Line ("####################################");
      Put_Line (" ");

      -- Fermeture du fichier
      Close (File => Fichier);

   end FichierToMemoire;

end parseur;
