SET SERVEROUTPUT ON
CREATE OR REPLACE FUNCTION jeuLePlusPopulaire (Code_ESRB IN JEU.CodeESRB%TYPE )
RETURN JEU.Nom%TYPE
AS
    IdJeuESRB JEU.IdJeu%TYPE;
    nbContenu INTEGER := 0;
    nbTmp INTEGER;
    nomJeuRETURN JEU.Nom%TYPE;
    nomJeuTmp JEU.Nom%TYPE;
    CURSOR jeu_cur
    IS 
        SELECT IdJeu
        FROM JEU
        WHERE CodeESRB = Code_ESRB;
BEGIN
    --Cursor pour faire un loop check tous les Jeux ayant le code ESRB
    OPEN jeu_cur;
    LOOP
        FETCH jeu_cur INTO IdJeuESRB;
        EXIT WHEN jeu_cur%NOTFOUND;
        --garder le Nom du Jeu
        SELECT Nom
        INTO nomJeuTmp
        FROM JEU
        WHERE IdJeu = IdJeuESRB;
        
        /*compter nombre de contenu achetes par les joueur actif qui a complete 
        au moins un succes*/
        SELECT COUNT(*)
        INTO nbTmp
        FROM
            (SELECT DISTINCT *
            FROM 
                (SELECT CP.IdContenu, CP.NoJoueur
                FROM CONTENU_POSSEDE CP, SUCCES_REALISE SR
                WHERE CP.IdContenu = SR.IdContenu AND CP.NoJoueur = SR.NoJoueur)
            WHERE IdContenu IN
                (SELECT IdContenu
                FROM CONTENU
                WHERE IdJeu = IdJeuESRB)
            AND NoJoueur IN 
                (SELECT NoJoueur
                FROM JOUEUR
                WHERE Actif = '1'));
        --Verifie si le nombre de vente est le max
        IF nbTmp >= nbContenu THEN
            nbContenu := nbTmp;
            nomJeuRETURN := nomJeuTmp;
        END IF;      
    END LOOP;
    CLOSE jeu_cur;
    RETURN nomJeuRETURN;
END;
/






