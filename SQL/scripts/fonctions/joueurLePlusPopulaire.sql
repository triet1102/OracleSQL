SET SERVEROUTPUT ON
CREATE OR REPLACE FUNCTION joueurLePlusPopulaire
RETURN JOUEUR.Surnom%TYPE
AS
   NoJoueurPopulaire JOUEUR.NoJoueur%TYPE;
   SurnomJoueurPopulaire JOUEUR.Surnom%TYPE;
BEGIN
    --trouver NoJoueur du joueur le plus poplulaire
    SELECT Invt
    INTO NoJoueurPopulaire
    FROM
        (SELECT Invt, nb_amis
            FROM    
                (SELECT Invt, count(*) AS nb_amis
                    FROM
                    (SELECT NoJoueurInvitant AS Invt from AMI
                    UNION ALL 
                    SELECT NoJoueurInvite AS Invte FROM AMI)
                    GROUP BY Invt
                    ORDER BY nb_amis DESC)
            WHERE Invt NOT IN
                    (SELECT NoJoueur
                        FROM JOUEUR
                        WHERE Actif = '0' OR Nom IS NULL OR Prenom IS NULL)
            ORDER BY nb_amis DESC)
    WHERE rownum = 1;
    
    --trouver le surnom de ce joueur
    SELECT Surnom
    INTO SurnomJoueurPopulaire
    FROM JOUEUR
    WHERE NoJoueur = NoJoueurPopulaire;
    
    --return le surnom   
    RETURN SurnomJoueurPopulaire;
END;














