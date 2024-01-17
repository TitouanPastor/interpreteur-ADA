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

   procedure LigneToTabMot
     (ligneCourante : in Unbounded_String; tabMot : out T_Mot)
   is
      Mot : Unbounded_String;
   begin
      -- On reinitialise le tableau de mots
      InitialiserTabMot (tabMot);
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

   end LigneToTabMot;

   procedure InitMapOperations (map : out Integer_Hashed_Maps.Map) is
   begin
      map.Include ("+", 1);
      map.Include ("-", 2);
      map.Include ("*", 3);
      map.Include ("/", 4);
      map.Include
        ("->",
         5); -- l'assignation dans le code intermédiaire est en fait l'absence de signe d'opération
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
      i             : Integer;
      x, y : Integer; -- valeur dans les opérations x <- y op z avec y et z pouvant etre des variables ou des constantes
      xIsVariable, yIsVariable : Integer;
      cntVar        : Integer;
      tempNomVar    : Unbounded_String;
      mapOperations : Integer_Hashed_Maps.Map;

   begin

      -- Ouverture du fichier
      Open (Fichier, In_File, chemin);

      --  Initialisation
      InitialiserTabMot (tabMots);
      InitialisercntVar (cntVar);
      InitMapOperations (mapOperations);

      --MAIN
      while not End_Of_File (Fichier) and tabMots.tabMotLigne (1) /= "Fin" loop

         -- A1 : Récupérer la ligne sous forme d'un tableau de mots

         Get_Line (Fichier, Ligne);
         Put_Line (Ligne);

         LigneToTabMot (Ligne, tabMots);

         --  A2 : On traite la ligne courante

         if tabMots.tabMotLigne (1) = "Programme" then

            Put_Line ("######### Dans la déclaration des variables");
            -- On récupère la ligne suivante
            Get_Line (Fichier, Ligne);
            Put_Line (Ligne);
            -- passe la ligne sous forme d'un tableau de mots
            LigneToTabMot (Ligne, tabMots);

            while tabMots.tabMotLigne (1) /= "Début" loop

               -- B1 : On ajoute les variables au tas

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
      -- La variable n'est pas suivie par une virgule, ajustez en conséquence
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
               -- On récupère la ligne suivante
               Get_Line (Fichier, Ligne);
               Put_Line (Ligne);
               -- passe la ligne sous forme d'un tableau de mots
               LigneToTabMot (Ligne, tabMots);
            end loop;

            Put_Line ("######### Sortie déclaration variables");

         end if;

         -- Cas du programme avec les instructions
         if tabMots.tabMotLigne (1) = "Début" then

            Put_Line ("######### Dans les instructions");
            -- On récupère la ligne suivante
            Get_Line (Fichier, Ligne);
            Put_Line (Ligne);
            -- passe la ligne sous forme d'un tableau de mots
            LigneToTabMot (Ligne, tabMots);

            while tabMots.tabMotLigne (1) /= "Fin" loop

               -- On traite la ligne d'instruction
               -- Si le premier terme de la ligne (en skippant le num de ligne) est une variable
               if mapVariable.Contains (To_String (tabMots.tabMotLigne (2)))
               then
                  Put_Line ("-> OPE");
      -- On regarde si la première opérande est une constante ou une variable
                  if mapVariable.Contains (To_String (tabMots.tabMotLigne (4)))
                  then
                     x := mapVariable (To_String (tabMots.tabMotLigne (4)));
                     xIsVariable := 1;
                  else
                     x := Integer'Value(To_String(tabMots.tabMotLigne (4)));
                     xIsVariable := 0;
                  end if;

                  --Si l'instruction est une simple assignation ( x <- 4)
                  if tabMots.nbElements = 4 then
                     InsererInstruction
                       (memCode,
                        mapVariable (To_String (tabMots.tabMotLigne (2))), xIsVariable,x,
                        mapOperations ("->"), 0, 0);
                  else -- Sinon on regarde la seconde opérande

                  if mapVariable.Contains (To_String (tabMots.tabMotLigne (6)))
                  then
                     y := mapVariable (To_String (tabMots.tabMotLigne (6)));
                     yIsVariable := 1;
                  else
                     y := Integer'Value(To_String(tabMots.tabMotLigne (6)));
                     yIsVariable := 0;
                  end if;
                     InsererInstruction
                       (memCode,
                        mapVariable (To_String (tabMots.tabMotLigne (2))), xIsVariable,x,
                        mapOperations(To_String (tabMots.tabMotLigne (5))), yIsVariable, y);
                  end if;

               elsif tabMots.tabMotLigne (2) = To_Unbounded_String ("GOTO")
               then
                  Put_Line ("-> GOTO");
                  InsererInstruction
                    (memCode, -1, 0,
                     Integer'Value (To_String (tabMots.tabMotLigne (3))), 0, 0,
                     0);

               elsif tabMots.tabMotLigne (2) = To_Unbounded_String ("IF") then
                  Put_Line ("-> IF");
                  if mapVariable.Contains (To_String (tabMots.tabMotLigne (3)))
                  then
                     InsererInstruction
                       (memCode, -2, 1,
                        mapVariable (To_String (tabMots.tabMotLigne (3))), 0,
                        0, Integer'Value(To_String (tabMots.tabMotLigne (6))));
                  else
                     InsererInstruction
                       (memCode, -2, 0,
                        Integer'Value (To_String (tabMots.tabMotLigne (3))), 0,
                        0, 0);
                  end if;

               elsif tabMots.tabMotLigne (2) = To_Unbounded_String ("NULL")
               then
                  Put_Line ("-> NULL");
                  InsererInstruction (memCode, -3, 0, 0, 0, 0, 0);

               else
                  Put_Line ("-> Non reconnu");

               end if;

               -- On récupère la ligne suivante
               Get_Line (Fichier, Ligne);
               Put_Line (Ligne);
               -- passe la ligne sous forme d'un tableau de mots
               LigneToTabMot (Ligne, tabMots);
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
      Put_Line (" ");

      -- Affichage de la mémoire de code
      for i in 1 .. getNbInstructions (memCode) loop
         Put (i'Image & " : ");
         Put (GetCaseInstruction (GetInstruction (memCode, i), 1)'Image);
         Put (GetCaseInstruction (GetInstruction (memCode, i), 2)'Image);
         Put (GetCaseInstruction (GetInstruction (memCode, i), 3)'Image);
         Put (GetCaseInstruction (GetInstruction (memCode, i), 4)'Image);
         Put (GetCaseInstruction (GetInstruction (memCode, i), 5)'Image);
         Put (GetCaseInstruction (GetInstruction (memCode, i), 6)'Image);
         Put_Line (" ");
      end loop;

      Put_Line ("####################################");
      Put_Line (" ");

      -- Fermeture du fichier
      Close (File => Fichier);

   end FichierToMemoire;

end parseur;
