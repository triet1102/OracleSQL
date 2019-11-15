CREATE VIEW MesSucces AS
    SELECT DISTINCT S.Titre, S.Description, S.Valeur, SR.NoJoueur
    FROM SUCCES S, SUCCES_REALISE SR
    WHERE S.IdSucces = SR.IdSucces
    UNION
    SELECT DISTINCT S.Titre, S.Description, S.Valeur, SC.NoJoueur
    FROM SUCCES S, SUCCES_EN_COURS SC
    WHERE S.IdSucces = SC.IdSucces;
        
    
    
















