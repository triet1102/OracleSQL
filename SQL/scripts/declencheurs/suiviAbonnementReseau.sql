CREATE OR REPLACE TRIGGER SUIVI_ABONNEMENT_RESEAU_TRG
AFTER INSERT OR DELETE
ON ABONNEMENT_RESEAU
FOR EACH ROW
DECLARE
    codeAction SUIVI_RESEAU.Action%TYPE;
BEGIN
    IF INSERTING THEN
        codeAction := 'ABO';
        INSERT INTO SUIVI_RESEAU(Moment, CodeReseau, DateSuivi, Action, NoJoueur)
        VALUES (CURRENT_TIMESTAMP, :NEW.CodeReseau, to_date(SYSDATE), codeAction, :NEW.NoJoueur);
    END IF;
    
    IF DELETING THEN
        codeAction := 'DSA';
        INSERT INTO SUIVI_RESEAU(Moment, CodeReseau, DateSuivi, Action, NoJoueur)
        VALUES (CURRENT_TIMESTAMP, :OLD.CodeReseau, to_date(SYSDATE), codeAction, :OLD.NoJoueur);
    END IF;  
END;












