-- Ce package permet de lire un fichier texte contenant le code intermediaire et de le traduire en mémoire (T_Tas et T_Memoire_Code)
with Ada.Strings.Unbounded;         use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Text_IO;         use Ada.Text_IO;
with Memoire_Code; use Memoire_Code;
with tas;          use tas;
with Dico_entiers; use Dico_entiers;

package parseur is


   CAPACITE : Integer := 1000;  -- Capacité maximale du Tableau de mots

   type T_Tab_Mot is private;  -- Type privé pour le tableau de mots

   type T_Mot is record -- Type enregistrement pour le tableau de mots
      tabMotLigne    : T_Tab_Mot;  -- Tableau de mots correspondant à la ligne
      nbElements : Integer;  -- Nombre d'éléments actuellement dans le tableau
   end record;


   -- Nom fonction : FichierToMemoire

   -- Sémantique : Lit un fichier texte contenant le code intermediaire et le traduit en mémoire (T_Tas et T_Memoire_Code)

   -- Paramètres :
   --   - chemin : String : chemin du fichier texte
   --   - memVar : out T_Tas : tas contenant les variables
   --   - memCode : out T_Memoire_Code : mémoire contenant le code intermediaire
   --   - dico_entiers : out Integer_Hashed_Maps.Map : table de correspondance entre les variables et leurs valeurs

   -- Pre  => chemin /= null,
   -- Post => memVar /= null, memCode /= null;
   procedure FichierToMemoire
     (chemin : in String; memVar : out T_Tas; memCode : out T_Memoire_Code; dico_entiers : out Integer_Hashed_Maps.Map);


   -- Nom fonction : InitialiserTabMot

   -- Sémantique : Initialise le tableau qui permet de stocker chaque mot d'une ligne

   -- Paramètres :
   --    - TabMot : out T_Tab_Mot --> le tableau de mot correspondant à la ligne courante

   -- Pre  => rien,
   -- Post => tabMotLigne.nbElements = 0;
   procedure InitialiserTabMot (tabMot : out T_Tab_Mot);


   -- Nom fonction : LigneToTabMot

   -- Sémantique : Prend une ligne en entrée et retourne le tableau TabMot dans lequel il y a un mot de la ligne par case

   -- Paramètres :
   --    - ligneCourante : in String --> la ligne du code intermédiaire qu'il faut mettre sous forme de mots
   --    - tabMot : le tableau de mot correspondant à la ligne

   -- Pre  => rien,
   -- Post => ligneCourante non vide
   procedure LigneToTabMot (ligneCourante : in String; tabMot : out T_Tab_Mot );


     -- Nom fonction : InitialisercntVar

   -- Sémantique : Initialise le compteur de variables

   -- Paramètres :
   --    - compteur : out T_Dico--> le compteur de variables

   -- Pre  => rien,
   -- Post => ?
   procedure InitialisercntVar (compteur : out Integer);



   private

   type T_Tab_Mot is
     array (1 .. CAPACITE) of String;  -- Définition du type tableau de mots



end parseur;
