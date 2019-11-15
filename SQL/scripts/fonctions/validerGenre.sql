CREATE OR REPLACE FUNCTION validerGenre(codeG IN GENRE.Code%TYPE)
RETURN GENRE.Code%TYPE
AS
    e1 EXCEPTION;
    PRAGMA exception_init(e1, -20001);
    code_return GENRE.Code%TYPE;
    checkExist INTEGER;    
BEGIN
    --verifier si le code exist ou pas
    SELECT count(*)
    INTO checkExist
    FROM GENRE
    WHERE Code = codeG;
    
    IF checkExist = 0 THEN
        raise_application_error(-20001,'Exception: Code inexistant');
    END IF;    
    
    --chercher le code parent
    SELECT CodeGenreParent
    INTO code_return
    FROM GENRE
    WHERE Code = codeG;
    
    RETURN code_return;
END;



