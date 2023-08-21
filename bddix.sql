--1. LISTE DES POTIONS : NUMÉRO, LIBELLÉ, FORMULE ET CONSTITUANT PRINCIPAL. (5 LIGNES)
    SELECT * FROM POTION P ;
--2. LISTE DES NOMS DES TROPHÉES RAPPORTANT 3 POINTS. (2 LIGNES)
	SELECT NOM_CATEG FROM CATEGORIE C WHERE NB_POINTS = 3;
--3. LISTE DES VILLAGES (NOMS) CONTENANT PLUS DE 35 HUTTES. (4 LIGNES)
	SELECT NOM_VILLAGE  FROM VILLAGE V WHERE NB_HUTTES > 35;
--4. LISTE DES TROPHÉES (NUMÉROS) PRIS EN MAI / JUIN 52. (4 LIGNES)
	SELECT NUM_TROPHEE  FROM TROPHEE T WHERE DATE_PRISE BETWEEN '2052-05-01' AND '2052-06-30';
--5. NOMS DES HABITANTS COMMENÇANT PAR 'A' ET CONTENANT LA LETTRE 'R'. (3 LIGNES)
	SELECT NOM FROM  HABITANT H WHERE NOM LIKE 'A%r%' ;
--6. NUMÉROS DES HABITANTS AYANT BU LES POTIONS NUMÉROS 1, 3 OU 4. (8 LIGNES)
	SELECT DISTINCT A.NUM_HAB FROM ABSORBER A WHERE A.NUM_POTION IN (1,3,4);
--7. LISTE DES TROPHÉES : NUMÉRO, DATE DE PRISE, NOM DE LA CATÉGORIE ET NOM DU PRENEUR. (10LIGNES)
	SELECT  T.NUM_TROPHEE, T.DATE_PRISE, C.NOM_CATEG, H.NOM 
	FROM TROPHEE T
	INNER JOIN CATEGORIE C  ON T.CODE_CAT  = C.CODE_CAT
	INNER JOIN HABITANT H ON T.NUM_PRENEUR = H.NUM_HAB;
--8. NOM DES HABITANTS QUI HABITENT À AQUILONA. (7 LIGNES)
	SELECT H.NOM FROM HABITANT H INNER JOIN VILLAGE V ON H.NUM_VILLAGE = V.NUM_VILLAGE 
	AND V.NOM_VILLAGE = 'Aquilona';
--9. NOM DES HABITANTS AYANT PRIS DES TROPHÉES DE CATÉGORIE BOUCLIER DE LÉGAT. (2 LIGNES)
	SELECT H.NOM 
	FROM HABITANT H 
	INNER JOIN TROPHEE T ON H.NUM_HAB = T.NUM_PRENEUR 
	INNER JOIN CATEGORIE C ON T.CODE_CAT = C.CODE_CAT  
	AND C.NOM_CATEG = 'Bouclier de Légat';
--10. LISTE DES POTIONS (LIBELLÉS) FABRIQUÉES PAR PANORAMIX : LIBELLÉ, FORMULE ET CONSTITUANTPRINCIPAL. (3 LIGNES)
	SELECT P.LIB_POTION, P.FORMULE, P.CONSTITUANT_PRINCIPAL FROM POTION P INNER JOIN FABRIQUER F ON P.NUM_POTION = F.NUM_POTION 
	INNER JOIN HABITANT H ON F.NUM_HAB = H.NUM_HAB AND H.NOM = 'Panoramix';
--11. LISTE DES POTIONS (LIBELLÉS) ABSORBÉES PAR HOMÉOPATIX. (2 LIGNES)
	SELECT DISTINCT  P.LIB_POTION FROM POTION P INNER JOIN ABSORBER A ON P.NUM_POTION = A.NUM_POTION 
	INNER JOIN HABITANT H ON A.NUM_HAB = H.NUM_HAB AND H.NOM = 'Homéopatix';
--12. LISTE DES HABITANTS (NOMS) AYANT ABSORBÉ UNE POTION FABRIQUÉE PAR L'HABITANT NUMÉRO 3. (4 LIGNES)
	SELECT DISTINCT H.NOM FROM HABITANT H INNER JOIN ABSORBER A ON H.NUM_HAB = A.NUM_HAB 
	INNER JOIN FABRIQUER F ON A.NUM_POTION = F.NUM_POTION AND F.NUM_HAB = 3;
--13. LISTE DES HABITANTS (NOMS) AYANT ABSORBÉ UNE POTION FABRIQUÉE PAR AMNÉSIX. (7 LIGNES)
	SELECT DISTINCT  H.NOM FROM HABITANT H INNER JOIN ABSORBER A ON H.NUM_HAB = A.NUM_HAB 
	INNER JOIN FABRIQUER F ON A.NUM_POTION  = F.NUM_POTION 
	INNER JOIN HABITANT H2 ON H2.NUM_HAB = F.NUM_HAB AND H2.NOM = 'Amnésix';  
--14. NOM DES HABITANTS DONT LA QUALITÉ N'EST PAS RENSEIGNÉE. (2 LIGNES)
	SELECT NOM FROM HABITANT H WHERE NUM_QUALITE IS NULL ;
--15. NOM DES HABITANTS AYANT CONSOMMÉ LA POTION MAGIQUE N°1 (C'EST LE LIBELLÉ DE LAPOTION) EN FÉVRIER 52. (3 LIGNES)
	SELECT H.NOM FROM HABITANT H  
	INNER JOIN ABSORBER A  ON H.NUM_HAB = A.NUM_HAB 
	INNER JOIN POTION P ON A.NUM_POTION = P.NUM_POTION 
	AND P.LIB_POTION = 'Potion magique n°1' AND A.DATE_A  BETWEEN '2052-02-01' AND '2052-02-29';
--16. NOM ET ÂGE DES HABITANTS PAR ORDRE ALPHABÉTIQUE. (22 LIGNES)
	SELECT NOM, AGE FROM HABITANT H ORDER BY NOM;
--17. LISTE DES RESSERRES CLASSÉES DE LA PLUS GRANDE À LA PLUS PETITE : NOM DE RESSERRE ET NOM DU VILLAGE. (3 LIGNES)
	SELECT R.NOM_RESSERRE, V.NOM_VILLAGE FROM RESSERRE R 
	INNER JOIN VILLAGE V ON R.NUM_VILLAGE = V.NUM_VILLAGE
	ORDER BY R.SUPERFICIE DESC;
--18. NOMBRE D'HABITANTS DU VILLAGE NUMÉRO 5. (4)
	SELECT COUNT(*) FROM HABITANT H WHERE NUM_VILLAGE = 5; 
--19. NOMBRE DE POINTS GAGNÉS PAR GOUDURIX. (5)
	SELECT SUM(C.NB_POINTS) FROM TROPHEE T INNER JOIN HABITANT H ON T.NUM_PRENEUR = H.NUM_HAB 
	INNER JOIN CATEGORIE C ON T.CODE_CAT = C.CODE_CAT AND H.NOM = 'Goudurix';
--20. DATE DE PREMIÈRE PRISE DE TROPHÉE. (03/04/52)
	SELECT MIN(DATE_PRISE) FROM TROPHEE T ;
--21. NOMBRE DE LOUCHES DE POTION MAGIQUE N°2 (C'EST LE LIBELLÉ DE LA POTION) ABSORBÉES. (19)
	SELECT SUM(QUANTITE) FROM ABSORBER A INNER JOIN POTION P ON A.NUM_POTION = P.NUM_POTION 
	AND P.LIB_POTION = 'Potion magique n°2';
--22. SUPERFICIE LA PLUS GRANDE. (895)
	SELECT MAX(SUPERFICIE) FROM RESSERRE R ;
--23. NOMBRE D'HABITANTS PAR VILLAGE (NOM DU VILLAGE, NOMBRE). (7 LIGNES)
	SELECT V.NOM_VILLAGE, COUNT(h.nom) AS NOMBRE_HABITANT_PAR_VILLAGE FROM HABITANT H 
	INNER JOIN VILLAGE V ON H.NUM_VILLAGE =V.NUM_VILLAGE  
	GROUP BY V.NOM_VILLAGE ;
--24. NOMBRE DE TROPHÉES PAR HABITANT (6 LIGNES)
	SELECT H.NOM, COUNT(t.num_preneur) AS NOMBRE_DE_TROPHEE FROM HABITANT H 
	INNER JOIN TROPHEE T ON H.NUM_HAB = T.NUM_PRENEUR GROUP BY H.NOM;
--25. MOYENNE D'ÂGE DES HABITANTS PAR PROVINCE (NOM DE PROVINCE, CALCUL). (3 LIGNES)
	SELECT P.NOM_PROVINCE, AVG(H.AGE) AS MOYENNE_AGE_HABITANT FROM HABITANT H 
	INNER JOIN VILLAGE V ON H.NUM_VILLAGE = V.NUM_VILLAGE 
	INNER JOIN PROVINCE P ON V.NUM_PROVINCE = P.NUM_PROVINCE
	GROUP BY P.NOM_PROVINCE ;
--26. NOMBRE DE POTIONS DIFFÉRENTES ABSORBÉES PAR CHAQUE HABITANT (NOM ET NOMBRE). (9LIGNES)
	SELECT H.NOM, COUNT(distinct P.NUM_POTION) AS NOMBRE_DE_POTIONS_DIFFERENTE FROM HABITANT H 
	INNER JOIN ABSORBER A ON H.NUM_HAB = A.NUM_HAB 
	INNER JOIN POTION P ON A.NUM_POTION = P.NUM_POTION 
	GROUP BY H.NOM;
--27. NOM DES HABITANTS AYANT BU PLUS DE 2 LOUCHES DE POTION ZEN. (1 LIGNE)
	SELECT DISTINCT H.NOM FROM HABITANT H 
	INNER JOIN ABSORBER A ON H.NUM_HAB = A.NUM_HAB 
	INNER JOIN POTION P ON A.NUM_POTION = P.NUM_POTION 
	WHERE P.LIB_POTION = 'Potion Zen' AND A.QUANTITE > 2;
--28. NOMS DES VILLAGES DANS LESQUELS ON TROUVE UNE RESSERRE (3 LIGNES)
	SELECT DISTINCT V.NOM_VILLAGE FROM VILLAGE V INNER JOIN RESSERRE R ON V.NUM_VILLAGE = R.NUM_VILLAGE ;
--29. NOM DU VILLAGE CONTENANT LE PLUS GRAND NOMBRE DE HUTTES. (GERGOVIE)
	SELECT NOM_VILLAGE FROM VILLAGE V WHERE NB_HUTTES = (SELECT MAX(NB_HUTTES)FROM VILLAGE);
--30. NOMS DES HABITANTS AYANT PRIS PLUS DE TROPHÉES QU'OBÉLIX (3 LIGNES).
	SELECT HABITANT.NOM
	FROM HABITANT
	JOIN TROPHEE ON HABITANT.NUM_HAB = TROPHEE.NUM_PRENEUR
	GROUP BY HABITANT.NOM
	HAVING COUNT(NUM_PRENEUR) > (
    SELECT COUNT(NUM_PRENEUR)
    FROM TROPHEE
    INNER JOIN HABITANT ON TROPHEE.NUM_PRENEUR = HABITANT.NUM_HAB
    WHERE HABITANT.NOM = 'Obélix');
