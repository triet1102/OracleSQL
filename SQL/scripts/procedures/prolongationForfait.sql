CREATE OR REPLACE PROCEDURE prolongationForfait(Code            IN FORFAIT.Code%TYPE DEFAULT 'FortF',
                                                nb_joueur_aff   OUT INTEGER)
IS
BEGIN
    UPDATE PERIODE_FORFAIT_JOUEUR
    SET DateAchat = ADD_MONTHS(DateAchat,2)
    WHERE IdPeriode IN
        (select IdPeriode
        from PERIODE
        where CodeForfait = Code);
    
    select count (distinct NoJoueur) as Nb_affectes
    into nb_joueur_aff
    from PERIODE_FORFAIT_JOUEUR
    where IdPeriode IN
        (select IdPeriode
        from PERIODE
        where CodeForfait = Code);
    
    UPDATE PERIODE
    SET DateFin = ADD_MONTHS(DateFin,2)
    WHERE IdPeriode IN
        (select IdPeriode
        from PERIODE
        where CodeForfait = Code);
END;
