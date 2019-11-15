CREATE OR REPLACE PROCEDURE suppressionJeu( resultat OUT INTEGER,
                                            nomJeu IN JEU.Nom%TYPE)
AS
    e1 EXCEPTION;
    PRAGMA exception_init(e1, -20001);
    e2 EXCEPTION;
    PRAGMA exception_init(e2, -20002);
    e3 EXCEPTION;
    PRAGMA exception_init(e3, -20003);
    checkExist INTEGER;
    checkAcquisition INTEGER;
BEGIN
    --compter le nombre de jeux ayant le meme nom
    SELECT COUNT(*)
    INTO checkExist
    FROM JEU
    WHERE Nom = nomJeu;
    IF checkExist = 0 THEN
        raise_application_error(-20001,'Exception: Jeu inexistant');
    END IF;
    IF checkExist >= 2 THEN
        raise_application_error(-20002,'Plus que 2 jeux ont le meme nom');
    END IF;
    
    
    --check si un jouer possede le jeu
    SELECT count(*) 
    INTO checkAcquisition
    FROM (SELECT * FROM CONTENU_POSSEDE
          WHERE IdContenu IN
            (SELECT IdContenu FROM CONTENU WHERE IdJeu IN
                (SELECT IdJeu FROM JEU WHERE Nom = nomJeu)));
    IF checkAcquisition > 0 THEN
        raise_application_error(-20003,'Exception: Jouer possede le jeu');
    END IF;
    
    --savepoint 
    savepoint saveTest;
    
    --delete from succes calcule 
    DELETE FROM SUCCES_CALCULE
    WHERE IdSucces IN 
        (SELECT IdSucces FROM SUCCES WHERE IdContenu IN
            (SELECT IdContenu FROM CONTENU WHERE IdJeu IN
                (SELECT IdJeu FROM JEU WHERE Nom = nomJeu)));
    
    --delete from succes
    DELETE FROM SUCCES
    WHERE IdSucces IN 
        (SELECT IdSucces FROM SUCCES WHERE IdContenu IN
            (SELECT IdContenu FROM CONTENU WHERE IdJeu IN
                (SELECT IdJeu FROM JEU WHERE Nom = nomJeu)));
    
    --delete from contenu
    DELETE FROM CONTENU
    WHERE IdContenu IN
        (SELECT IdContenu FROM CONTENU WHERE IdJeu IN
            (SELECT IdJeu FROM JEU WHERE Nom = nomJeu));
    
    --delete from jeu
    DELETE FROM JEU
    WHERE IdJeu IN 
        (SELECT IdJeu FROM JEU WHERE Nom = nomJeu);
    
    
    --resultat = 0 if resussi
    resultat := 0;
EXCEPTION
    WHEN e1 THEN 
        dbms_output.put_line('Handle e1: jeu inexistant');
        resultat := 1;
    WHEN e2 THEN 
        dbms_output.put_line('Handle e2: deux jeux avec le meme nom');
        resultat := 2;
    WHEN e3 THEN 
        dbms_output.put_line('Handle e3: joueur possede le jeu');
        resultat := 3;
    WHEN OTHERS THEN
        dbms_output.put_line('Handle others');
        resultat := 4;
        rollback to saveTest;
END;    

