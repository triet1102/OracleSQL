CREATE OR REPLACE TRIGGER Suivi_Reseau_TRG
AFTER INSERT OR UPDATE
ON RESEAU
FOR EACH ROW
DECLARE
    isActif INTEGER;
    codeAction SUIVI_RESEAU.Action%TYPE;
BEGIN
    IF INSERTING THEN
        codeAction := 'CRE';
    END IF;
    
    IF UPDATING THEN
        IF :NEW.Actif = '1' THEN
            codeAction := 'ACT';
        END IF;
        IF :NEW.Actif = '0' THEN
            codeAction := 'DES';
        END IF;
    END IF;
    INSERT INTO SUIVI_RESEAU(Moment, CodeReseau, DateSuivi, Action, NoJoueur)
    VALUES (CURRENT_TIMESTAMP, :NEW.Code, to_date(SYSDATE), codeAction, NULL);  
END;










