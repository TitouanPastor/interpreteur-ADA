
-- Ce package permet de lire un fichier texte contenant le code intermediaire et de le traduire en mémoire (T_Tas et T_Memoire_Code)

with Memoire_Code; use Memoire_Code;
with Tas; use Tas;

package parseur is


  -- Nom fonction : FichierToMemoire

  -- Sémantique : Lit un fichier texte contenant le code intermediaire et le traduit en mémoire (T_Tas et T_Memoire_Code)

  -- Paramètres : 
  -- chemin : String : chemin du fichier texte
  -- memVar : out T_Tas : tas contenant les variables
  -- memCode : out T_Memoire_Code : mémoire contenant le code intermediaire

  -- Pre  => chemin /= null,
  -- Post => memVar /= null, memCode /= null;
   procedure FichierToMemoire(chemin : String; memVar : out T_Tas; memCode : out T_Memoire_Code);

end parseur;
