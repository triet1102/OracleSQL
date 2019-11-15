CREATE OR REPLACE PROCEDURE ajoutForfait(Code       IN FORFAIT.Code%TYPE DEFAULT 'FortF',
                                        Nom         IN FORFAIT.Nom%TYPE ,
                                        Description IN FORFAIT.Description%TYPE,
                                        Prix        IN PERIODE.Prix%TYPE )
IS
BEGIN
    INSERT INTO FORFAIT(Code, Nom, Description)
        VALUES(Code, Nom, Description); 
    INSERT INTO PERIODE (DateDebut, DateFin, Prix, CodeForfait)
        VALUES (SYSDATE, ADD_MONTHS(SYSDATE, 12) , Prix, Code);
END;


