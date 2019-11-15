CREATE OR REPLACE TRIGGER Suivi_Ami_TRG
AFTER INSERT OR UPDATE OR DELETE 
ON AMI
FOR EACH ROW
DECLARE
BEGIN
    IF INSERTING OR UPDATING THEN
        INSERT INTO SUIVI_AMITIE(Moment, NoJoueurInvitant, NoJoueurInvite, DateSuivi, CodeStatut)
        VALUES(CURRENT_TIMESTAMP, :NEW.NoJoueurInvitant, :NEW.NoJoueurInvite, to_date(SYSDATE), :NEW.CodeStatut);
    END IF;
        
    IF DELETING THEN
        INSERT INTO SUIVI_AMITIE(Moment, NoJoueurInvitant, NoJoueurInvite, DateSuivi, CodeStatut)
        VALUES(CURRENT_TIMESTAMP, :OLD.NoJoueurInvitant, :OLD.NoJoueurInvite, to_date(SYSDATE), :OLD.CodeStatut);
    END IF;
END;













