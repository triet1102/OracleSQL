CREATE OR REPLACE PROCEDURE ajusterPromotion(Code   OUT PERIODE.CodeForfait%TYPE ,
                                            new_prix  OUT PERIODE.Prix%TYPE )
IS
    forfait_populaire PERIODE.CodeForfait%TYPE;
    max_prix PERIODE.Prix%TYPE;
BEGIN
    --select max prix
    SELECT max(Prix)
    INTO max_prix
    FROM PERIODE;
    
    --select le code forfait le plus populaire
    SELECT code
    INTO forfait_populaire
    FROM
        (SELECT CodeForfait AS code, count(*) AS count
        FROM PERIODE
        GROUP BY CodeForfait
        ORDER BY count desc)
    WHERE rownum = 1;
    Code :=  forfait_populaire;
    
    --update prix pour le code le plus populaire si son prix < max prix
    UPDATE PERIODE
    SET Prix = Prix * 1.1
    WHERE Prix IN
        (SELECT Prix
        FROM PERIODE 
        WHERE CodeForfait = forfait_populaire AND Prix != max_prix);
    --select new prix  
    SELECT Prix
    INTO new_prix
    FROM
        (SELECT Prix
        FROM PERIODE 
        WHERE CodeForfait = forfait_populaire 
        order by Prix desc)
    WHERE rownum = 1;
END;
/





