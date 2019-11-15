CREATE OR REPLACE FUNCTION succesPlusRealise 
RETURN SUCCES.Titre%TYPE
AS
    idSucc SUCCES.IdSucces%TYPE;
    titreSucc SUCCES.Titre%TYPE;
BEGIN
    SELECT IdSucces
    INTO idSucc
    FROM
        (SELECT IdSucces, count(*) as C
        FROM SUCCES_REALISE
        GROUP BY IdSucces
        ORDER BY C desc)
    WHERE rownum = 1;
    
    SELECT Titre
    INTO titreSucc
    FROM SUCCES
    WHERE IdSucces = idSucc;
    
    RETURN titreSucc;
    
END;
