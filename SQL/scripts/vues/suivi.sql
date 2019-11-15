CREATE VIEW suiviReseau AS
    SELECT SR.Moment, SR.Action, SR.CodeReseau, R.Nom
    FROM SUIVI_RESEAU SR, RESEAU R
    WHERE SR.CodeReseau = R.Code AND SR.NoJoueur IS NULL
    ORDER BY SR.Moment DESC;
/

CREATE VIEW suiviReseauJoueur AS
    SELECT SR.Moment, SR.Action, SR.CodeReseau, J.Surnom
    FROM SUIVI_RESEAU SR, JOUEUR J
    WHERE SR.NoJoueur = J.NoJoueur 
    ORDER BY SR.Moment DESC;
/

CREATE VIEW suiviAmitie AS
    SELECT SA.Moment, J.Surnom, SA.NoJoueurInvitant, SA.NoJoueurInvite, SA.DateSuivi, SA.CodeStatut
    FROM SUIVI_AMITIE SA, JOUEUR J
    WHERE SA.NoJoueurInvitant = J.NoJoueur 
    ORDER BY SA.Moment DESC;

/
    

    