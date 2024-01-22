with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

package Menu is

   -- Nom fonction : ChoixMode

   -- Sémantique : Permet à l'utilisateur de saisir le chemin du fichier

   -- Paramètres :
   --   chemin    : out Unbounded_String    --> chemin vers le fichier de code intermedaire à executer

   -- Pre : /
   -- Post : /
   procedure ChoixFichier (chemin : out Unbounded_String);

   -- Nom fonction : ChoixMode

   -- Sémantique : Permet à l'utilisateur de choisir le mode d'execution

   -- Paramètres :
   --   /

   -- retour :
   --  Integer --> 1 correspondant au mode 1 (mode normal) ou 2 correspondant au mode debuggueur

   -- Pre : /
   -- Post : /

   function ChoixMode return Integer;

   -- Nom fonction : ChoixSortir

   -- Sémantique : Permet à l'utilisateur de saisir recommencer l'execution d'un nouveau programme ou de sortir

   -- Paramètres :
   --   /

   -- retour :
   --  Integer --> 1 correspondant à sortir du programme ou 2 correspondant à recommencer le programme

   -- Pre : /
   -- Post : /
   function ChoixSortir return Integer;

end Menu;
