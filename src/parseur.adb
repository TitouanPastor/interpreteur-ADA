package body parseur is

	-----------------------
   -- InitialiserTabMot --
   -----------------------

   procedure InitialiserTabMot (TabMot : out T_Mot) is
   begin
      TabMot.nbElements := 0;
   end InitialiserTabMot;

   -----------------------
   -- InitialisercntVar --
   -----------------------

   procedure InitialisercntVar (cntVar : out Integer) is
   begin
      cntVar := 1;
   end InitialisercntVar;

   ---------------------
   -- InitialiserDico --
   ---------------------

   procedure InitialiserDico (Map : out Integer_Hashed_Maps.Map) is
   begin
      Integer_Hashed_Maps.Clear (Map);
   end InitialiserDico;

   --------------------
   -- LigneToTabMot --
   --------------------

   -- Fonction qui permet de transformer une ligne en tableau de mots
   procedure LigneToTabMots (Fichier : in out File_Type; tabMot : out T_Mot) is
      Mot           : Unbounded_String;
      ligneCourante : Unbounded_String;
   begin
      -- On reinitialise le tableau de mots
      InitialiserTabMot (tabMot);
      -- On récupere la ligne courante
      Get_Line (Fichier, ligneCourante);
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
   end LigneToTabMots;

   -----------------------
   -- InitMapOperations --
   -----------------------

   -- Fonction qui permet d'initialiser le dictionnaire des opérations
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
      map.Include ("OR", 14);
      map.Include ("AND", 15);

   end InitMapOperations;

   ---------------------
   -- ParserOperation --
   ---------------------

   -- Fonction qui permet de parser une ligne d'opération afin de la transformer en une ligne d'entiers
   procedure ParserOperation
     (mapVariable   : in     Variable_Hashed_Maps.Map;
      mapOperations : in     Integer_Hashed_Maps.Map; tabMots : in T_Mot;
      memCode       :    out T_Memoire_Code)
   is
      x, y : Integer; -- valeur dans les opérations x <- y op z avec y et z pouvant etre des variables ou des constantes
      xflag,
      yflag : Integer; -- codes associés aux opérandes qui permettent de définir si ce sont des variables ou des constantes
      offsetOperation : Integer; -- Offset qui permet de construire le code de l'opération en fonction du type
   begin
      offsetOperation := 0;
      --On regarde si la valeur est une constante boolénne
      if To_String (tabMots.tabMotLigne (4)) = "false" then
         xflag := 4;
         x     := 0;
      elsif To_String (tabMots.tabMotLigne (4)) = "true" then
         xflag := 4;
         x     := 1;

      -- On regarde si la première opérande est entourée de quote de type 'X'
      elsif To_String (tabMots.tabMotLigne (4)) (1) = ''' then
         xflag           := 2;
         offsetOperation := 20;
         x := Character'Pos (To_String (tabMots.tabMotLigne (4)) (2));

         -- Si non constante caractère, on regarde si la première opérande est une constante d'un autre type ou une variable
      elsif mapVariable.Contains (To_String (tabMots.tabMotLigne (4))) then

         case mapVariable.Element (To_String (tabMots.tabMotLigne (4))).TypeVar
         is
            when Integer_Type =>
               xflag           := 1;
               offsetOperation := 0;
            when Character_Type =>
               xflag           := 3;
               offsetOperation := 20;
            when Boolean_Type =>
               xflag := 5;
            when others =>
               null;
         end case;
         x :=
           mapVariable.Element (To_String (tabMots.tabMotLigne (4))).indiceTas;
      else
         x     := Integer'Value (To_String (tabMots.tabMotLigne (4)));
         xflag := 0;
      end if;

      --Si l'instruction est une simple assignation ( x <- 4)
      if tabMots.nbElements = 4 then
         InsererInstruction
           (memCode,
            mapVariable.Element (To_String (tabMots.tabMotLigne (2)))
              .indiceTas,
            xflag, x, mapOperations ("->") + offsetOperation, 0, 0);
      else -- Sinon on regarde la seconde opérande

         if mapVariable.Contains (To_String (tabMots.tabMotLigne (6))) then
            y :=
              mapVariable.Element (To_String (tabMots.tabMotLigne (6)))
                .indiceTas;

            if xflag mod 2 = 0 then
               yflag := xflag + 1;
            else
               yflag := xflag;
            end if;

         else
            y := Integer'Value (To_String (tabMots.tabMotLigne (6)));

            if xflag mod 2 = 0 then
               yflag := xflag;
            else
               yflag := xflag - 1;

            end if;

            -- On transforme la constante caractère en entier (code ascii)
            if yflag = 2 then

               y := Character'Pos (To_String (tabMots.tabMotLigne (6)) (2));

            -- On transforme la constante booléenne en entier (0 ou 1)
            elsif yflag = 4 then
               if To_String (tabMots.tabMotLigne (6)) = "false" then
                  y := 0;
               elsif To_String (tabMots.tabMotLigne (6)) = "true" then
                  y := 1;
               end if;

            end if;

         end if;
         -- On insère l'instruction dans la mémoire
         InsererInstruction
           (memCode,
            mapVariable.Element (To_String (tabMots.tabMotLigne (2)))
              .indiceTas,
            xflag, x,
            mapOperations (To_String (tabMots.tabMotLigne (5))) +
            offsetOperation,
            yflag, y);
      end if;
   end ParserOperation;

   ----------------
   -- ParserGoto --
   ----------------

   -- Fonction qui permet de parser une ligne de type GOTO X
   procedure ParserGoto (memCode : out T_Memoire_Code; tabMots : in T_Mot) is
   begin
      InsererInstruction
        (memCode, -1, 0, Integer'Value (To_String (tabMots.tabMotLigne (3))),
         0, 0, 0);
   end ParserGoto;

   --------------
   -- ParserIf --
   --------------

   -- Fonction qui permet de parser une ligne de type IF X = Y GOTO Z
   procedure ParserIf
     (mapVariable : in Variable_Hashed_Maps.Map; memCode : out T_Memoire_Code;
      tabMots     : in T_Mot)
   is
   begin
      if mapVariable.Contains (To_String (tabMots.tabMotLigne (3))) then
         InsererInstruction
           (memCode, -2, 5,
            mapVariable.Element (To_String (tabMots.tabMotLigne (3)))
              .indiceTas,
            0, 0, Integer'Value (To_String (tabMots.tabMotLigne (5))));
      else
         InsererInstruction
           (memCode, -2, 4,
            Integer'Value (To_String (tabMots.tabMotLigne (3))), 0, 0,
            Integer'Value (To_String (tabMots.tabMotLigne (5))));
      end if;
   end ParserIf;

   ----------------
   -- ParserNull --
   ----------------

   -- Fonction qui permet de parser une ligne de type NULL
   procedure ParserNull (memCode : out T_Memoire_Code) is
   begin
      InsererInstruction (memCode, -3, 0, 0, 0, 0, 0);
   end ParserNull;

   ----------------------
   -- ParserLireEcrire --
   ----------------------

   -- Fonction qui permet de parser une ligne de type lire(x) ou écrire(x)
   procedure ParserLireEcrire
     (mapVariable : in Variable_Hashed_Maps.Map; memCode : out T_Memoire_Code;
      tabMots     : in T_Mot)
   is
      xString          : Unbounded_String;
      flagVar : Integer; -- le flag de type de la variable x dans lire(x)
      codeInstruction : Integer; -- le code de l'instruction, soit -4 si c'est lire, soit -5 si c'est écrire
      offsetParenthese : Integer; -- l'offset de la parenthèse ouvrante dans la chaine lire(x) ou écrire(x) (premier caractère de x)
   begin
      -- On récupère si c'est lire ou écrire
      if To_String (tabMots.tabMotLigne (2)) (1 .. 4) = "lire" then
         codeInstruction  := -4;
         offsetParenthese := 6;
      else
         codeInstruction  := -5;
         offsetParenthese := 8;
      end if;
      -- On récupère le x dans la chaine lire(x)
      xString :=
        To_Unbounded_String
          (To_String (tabMots.tabMotLigne (2))
             (offsetParenthese .. Length (tabMots.tabMotLigne (2)) - 1));
      -- On affecte le bon flag suivant le type de la variable
      case mapVariable.Element (To_String (xString)).TypeVar is
         when Integer_Type =>
            flagVar := 1;
         when Character_Type =>
            flagVar := 3;
         when Boolean_Type =>
            flagVar := 5;
         when others =>
            null;
      end case;
      -- On insère l'instruction dans la mémoire
      InsererInstruction
        (memCode, codeInstruction, flagVar,
         mapVariable.Element (To_String (xString)).indiceTas, 0, 0, 0);
   end ParserLireEcrire;

   ----------------------------------
   -- TraiterDeclarationsVariables --
   ----------------------------------

   -- Fonction qui permet de traiter les déclarations de variables
   procedure TraiterDeclarationsVariables
     (Fichier     : in out File_Type; tabMots : in out T_Mot; tas : out T_Tas;
      mapVariable : in out Variable_Hashed_Maps.Map)
   is
      i          : Integer;
      cntVar     : Integer;
      tempNomVar : Unbounded_String;
      enumType   : Enum_Type;
   begin
      InitialisercntVar (cntVar);
      while tabMots.tabMotLigne (1) /= "Début" loop
         -- Insertion du type dans le dictionnaire de variable

         if tabMots.tabMotLigne (tabMots.nbElements) = "Entier" then
            enumType := Integer_Type;

         elsif tabMots.tabMotLigne (tabMots.nbElements) = "Caractère" then
            enumType := Character_Type;

         elsif tabMots.tabMotLigne (tabMots.nbElements) = "Booléen" then
            enumType := Boolean_Type;
         else
            null;
         end if;

         i := 1;
         -- Boucle qui parcours tout le tableau de mots
         -- On vérifie si on ets arrivé au bout des variables
         while tabMots.tabMotLigne (i) /= ":" loop
            AjouterVariable (tas, 0);
            tempNomVar := tabMots.tabMotLigne (i);

            -- Vérifier si le mot suivant est ":"
            if i < tabMots.nbElements
              and then tabMots.tabMotLigne (i + 1) = ":"
            then
               -- La variable n'est pas suivie par une virgule
               mapVariable.Include
                 (To_String (tempNomVar), (cntVar, enumType));
            else
               -- La variable est suivie par une virgule
               mapVariable.Include
                 (To_String (tempNomVar) (1 .. Length (tempNomVar) - 1),
                  (cntVar, enumType));
            end if;
            cntVar := cntVar + 1;
            i      := i + 1;
         end loop;
         -- On récupère la ligne suivante
         LigneToTabMots (Fichier, tabMots);
      end loop;
   end TraiterDeclarationsVariables;

   ----------------------
   -- FichierToMemoire --
   ----------------------

   -- Fonction qui permet de transformer un fichier de code intermédiaire en mémoire
   procedure FichierToMemoire
     (chemin      : in String; tas : out T_Tas; memCode : out T_Memoire_Code;
      mapVariable :    out Variable_Hashed_Maps.Map)
   is
      Fichier       : File_Type;
      Ligne         : Unbounded_String;
      tabMots       : T_Mot;
      mapOperations : Integer_Hashed_Maps.Map;

   begin

      -- Ouverture du fichier
      Open (Fichier, In_File, chemin);

      -- A1 : Initialiser les variables
      InitialiserTabMot (tabMots);
      InitMapOperations (mapOperations);

      --Main loop
      while not End_Of_File (Fichier) and then tabMots.tabMotLigne (1) /= "Fin"
      loop

   -- Pour chaque ligne, on récupère sous forme d'un tableau de mots les mots
         LigneToTabMots (Fichier, tabMots);

      -- A2 : On traite la ligne courante
      -- Cas du programme avec la déclaration des variable à la ligne suivante
         if tabMots.tabMotLigne (1) = "Programme" then

            -- Récupérer la ligne suivante
            LigneToTabMots (Fichier, tabMots);
            -- On ajoute les variables au tas
            TraiterDeclarationsVariables (Fichier, tabMots, tas, mapVariable);

         end if;

         -- Cas du programme avec les instructions
         if tabMots.tabMotLigne (1) = "Début" then
            LigneToTabMots (Fichier, tabMots);

            while tabMots.tabMotLigne (1) /= "Fin" loop

               -- On traite la ligne d'instruction
               -- Si le premier terme de la ligne (en skippant le num de ligne) est une variable
               -- OPERATION
               if mapVariable.Contains (To_String (tabMots.tabMotLigne (2)))
               then
                  ParserOperation
                    (mapVariable, mapOperations, tabMots, memCode);

                  -- GOTO
               elsif tabMots.tabMotLigne (2) = To_Unbounded_String ("GOTO")
               then
                  ParserGoto (memCode, tabMots);

                  -- IF
               elsif tabMots.tabMotLigne (2) = To_Unbounded_String ("IF") then
                  ParserIf (mapVariable, memCode, tabMots);

                  -- NULL
               elsif tabMots.tabMotLigne (2) = To_Unbounded_String ("NULL")
               then
                  ParserNull (memCode);

                  -- LIRE(X) & ECRIRE(X)
               elsif To_String (tabMots.tabMotLigne (2)) (1 .. 4) = "lire" or
                 To_String (tabMots.tabMotLigne (2)) (1 .. 6) = "ecrire"
               then
                  ParserLireEcrire (mapVariable, memCode, tabMots);
               else
                  Put_Line ("-> Opération non reconnue ");
               end if;
               -- On récupère la ligne suivante
               LigneToTabMots (Fichier, tabMots);
            end loop;
         end if;
      end loop;
      -- Fermeture du fichier
      Close (File => Fichier);

   end FichierToMemoire;

end parseur;
