package tas is

	type T_Tas is private;

	-- Initialiser un vecteur creux.  Il est nul.
	procedure Initialiser (tas : out T_tas) with
		Post => Est_Nul (tas);


	-- Détruire le vecteur V.
	procedure Detruire (tas: in out T_Tas);


	-- Est-ce que le vecteur V est nul ?
	function Est_Nul (tas : in T_Tas) return Boolean;


	-- Récupérer la composante (valeur) du vecteur V à l'indice Indice.
	function Composante_Recursif (tas : in T_Tas ; Indice : in Integer) return Float
		with Pre => Indice >= 1;


	-- Modifier une composante (Indice, Valeur) d'un vecteur creux.
	procedure Modifier (tas : in out T_Tas ;
				       Indice : in Integer ;
					   Valeur : in Integer ) with
		pre => Indice >= 1,
     post => Composante_Recursif (tas, Indice) = Valeur;


	-- Afficher le vecteur creux à des fins de mise au point.
	procedure Afficher (V : T_Tas);


private

	type T_Cellule;

	type T_Tas is access T_Cellule;

	type T_Cellule is
		record
			nomVar : Integer;
			valeur : Integer;
			Suivant : T_Tas;
		end record;

end tas;
