CREATE OR REPLACE TRIGGER Genre_TRG
BEFORE UPDATE
ON JEU
FOR EACH ROW
DECLARE
    Code_Parent GENRE.Code%TYPE;
BEGIN
    IF :NEW.CodeGenre != :OLD.CodeGenre THEN
        SELECT CodeGenreParent
        INTO Code_Parent
        FROM GENRE
        WHERE Code = :OLD.CodeGenre;        
        IF Code_Parent = :OLD.CodeGenre THEN
            DELETE 
            FROM SOUS_GENRE_JEU
            WHERE CodeSousGenre IN
                (SELECT Code
                FROM GENRE
                WHERE CodeGenreParent = :OLD.CodeGenre);        
        END IF;
    END IF;
END;
/























