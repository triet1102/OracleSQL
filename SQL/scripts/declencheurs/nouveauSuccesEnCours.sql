CREATE OR REPLACE TRIGGER NOUVEAU_SUCCES_EN_COURS_TRG
BEFORE INSERT
ON SUCCES_EN_COURS
FOR EACH ROW
DECLARE
    CURSOR cur_list IS
        SELECT IdContenu, NoJoueur, IdSucces
        FROM SUCCES_REALISE
        WHERE SUCCES_REALISE.IdContenu = :NEW.IdContenu AND SUCCES_REALISE.NoJoueur = :NEW.NoJoueur AND SUCCES_REALISE.IdSucces = :NEW.IdSucces;

    curChoice cur_list%ROWTYPE;

BEGIN
    OPEN cur_list;
    FETCH cur_list INTO curChoice;
    IF cur_list%FOUND THEN
        raise_application_error( -20010, 'Dupicate!' );
    END IF;

END;
/





