-- Ce package permet de lire un fichier texte contenant le code intermediaire et de le traduire en mémoire (T_Tas et T_Memoire_Code)
with Ada.Strings.Unbounded;         use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Text_IO;         use Ada.Text_IO;
with Memoire_Code; use Memoire_Code;
with tas;          use tas;
with Dico_entiers; use Dico_entiers;

package parseur is

   -- Nom fonction : FichierToMemoire

   -- Sémantique : Lit un fichier texte contenant le code intermediaire et le traduit en mémoire (T_Tas et T_Memoire_Code)

   -- Paramètres :
   -- chemin : String : chemin du fichier texte
   -- memVar : out T_Tas : tas contenant les variables
   -- memCode : out T_Memoire_Code : mémoire contenant le code intermediaire
   -- dico_entiers : out Integer_Hashed_Maps.Map : table de correspondance entre les variables et leurs valeurs

   -- Pre  => chemin /= null,
   -- Post => memVar /= null, memCode /= null;
   procedure FichierToMemoire
     (chemin : in String; memVar : out T_Tas; memCode : out T_Memoire_Code; dico_entiers : out Integer_Hashed_Maps.Map);

end parseur;
