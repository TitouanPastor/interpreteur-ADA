-- Ce package permet de lire un fichier texte contenant le code intermediaire et de le traduire en mémoire (T_Tas et T_Memoire_Code)
with Ada.Strings.Unbounded;         use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Hash;
with Ada.Text_IO; use Ada.Text_IO;
with Memoire_Code; use Memoire_Code;
with tas;          use tas;
with Map_entiers; use Map_entiers;
with Map_Variables; use Map_Variables;

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
   --   - tas : out T_Tas : tas contenant les variables
   --   - memCode : out T_Memoire_Code : mémoire contenant le code intermediaire
   --   - dico_entiers : out Integer_Hashed_Maps.Map : table de correspondance entre les variables et leurs valeurs

   -- Pre  => chemin /= null,
   -- Post => memVar /= null, memCode /= null;
   procedure FichierToMemoire
     (chemin : in String; tas : out T_Tas; memCode : out T_Memoire_Code; mapVariable : out Variable_Hashed_Maps.Map);


   private

   type T_Tab_Mot is
     array (1 .. CAPACITE) of Unbounded_String;  -- Définition du type tableau de mots



end parseur;
