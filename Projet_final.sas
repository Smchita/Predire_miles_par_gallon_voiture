/*creer un librairie */
LIBNAME TOTO "/home/u62454045/Projet_final";
/* exportation les fichiers */
proc import datafile="/home/u62454045/Projet_final/auto-mpg-1.xlsx"
 OUT= TOTO.auto_mpg_1
 DBMS=xlsx REPLACE;
GETNAMES=YES;
RUN;

proc import datafile="/home/u62454045/Projet_final/auto-mpg-2.xlsx"
OUT= TOTO.auto_mpg_2
DBMS=xlsx REPLACE;
GETNAMES=YES;
RUN;

proc import datafile="/home/u62454045/Projet_final/auto-mpg-3.xlsx"
OUT= TOTO.auto_mpg_3
DBMS=xlsx REPLACE;
GETNAMES=YES;
RUN;

proc print data=TOTO.auto_mpg_3;
run;

proc import datafile="/home/u62454045/Projet_final/auto-mpg-a-predire.xlsx"
OUT= TOTO.auto_mpg_a_predire
DBMS=xlsx REPLACE;
GETNAMES=YES;
RUN;

/*concatenation entre auto-mpg-1 et auto-mpg-2 */
proc sort data=TOTO.auto_mpg_1;
by Identifiant;
run;

proc sort data=TOTO.auto_mpg_2;
by Identifiant;
run;

data TOTO.Auto_mpg_1_2;
merge TOTO.auto_mpg_1 TOTO.auto_mpg_2;
by Identifiant;
 run;

/*concatenation entre auto-mpg-1-2 et auto-mpg-3 */
data TOTO.auto_mpg;
set TOTO.Auto_mpg_1_2 TOTO.auto_mpg_3;
run;
proc print data=TOTO.auto_mpg; 
run ;


/***************************************************************/
/*------------------------------------------------------*/
/* Etape */


/* l'ajout d'une nouvelle variable qui calcule l'age de chaque voiture */ 
data TOTO.auto_mpg;
set TOTO.auto_mpg;
age=1983-annee_du_modele;
drop annee_du_modele;
run;

/* on determine les statistique discriptive du jeu de donnees */
proc means data=TOTO.auto_mpg N NMISS MIN MAX RANGE MEAN MEDIAN STD;
var Poids puissance acceleration age mpg ;
run;
/* on voit ici qui y'a trop de valeurs manquantes */

/* on determine les statistique discriptive du jeu de donnees pour chaque origine */
proc means data=TOTO.auto_mpg N NMISS MIN MAX RANGE MEAN MEDIAN STD;
var Poids puissance acceleration age;
class origine;
run; 
/* on observe que y'a des valeurs manquantes pour chaque origine */


/* creer le fichier TOTO.auto_mpg_clean qui contient le modele sans valeurs manquantes*/

data TOTO.auto_mpg_clean;
set TOTO.auto_mpg;
/* pour USA*/
if acceleration=. and origine='USA' then acceleration=15;
if puissance=. and origine='USA' then puissance=105;
if Poids=. and origine='USA' then Poids=3372.50;
/* pour EUROPE*/
if acceleration=. and origine='Europe' then acceleration=15;
/* pour ASIE*/
if acceleration=. and origine='Asie' then acceleration=16.40;
run;
/******verifier s'il ya encore des valeur manquantes */
/*******************************/
proc means data=TOTO.auto_mpg_clean N NMISS MIN MAX RANGE MEAN MEDIAN STD;
var Poids puissance acceleration age mpg ;
class origine;
run; 
/* voir s'il ya des valeurs atypiques*/
/****************************************/
PROC SORT DATA=TOTO.auto_mpg_clean ;
BY origine;
RUN;
/*poids*/
PROC BOXPLOT data=TOTO.auto_mpg_clean;
PLOT poids* origine
/ CAXIS = black CTEXT = black CBOXES = black
BOXSTYLE = schematic
IDCOLOR = black IDSYMBOL=dot;
inset min mean max stddev /
header = 'Overall Statistics'
pos=tm;
insetgroup min max NHIGH NLOW NOUT RANGE Q1 Q2 Q3/
header = 'Extremes groupe';
RUN;

/*puissance */
PROC SORT DATA=TOTO.auto_mpg_clean ;
BY origine;
RUN;
PROC BOXPLOT data=TOTO.auto_mpg_clean;
PLOT puissance* origine
/ CAXIS = black CTEXT = black CBOXES = black
BOXSTYLE = schematic
IDCOLOR = black IDSYMBOL=dot;
inset min mean max stddev /
header = 'Overall Statistics'
pos=tm;
insetgroup min max NHIGH NLOW NOUT RANGE Q1 Q2 Q3/
header = 'Extremes groupe';
RUN;

/* acceleration*/
PROC SORT DATA=TOTO.auto_mpg_clean ;
BY origine;
RUN;
PROC BOXPLOT data=TOTO.auto_mpg_clean;
PLOT acceleration* origine
/ CAXIS = black CTEXT = black CBOXES = black
BOXSTYLE = schematic
IDCOLOR = black IDSYMBOL=dot;
inset min mean max stddev /
header = 'Overall Statistics'
pos=tm;
insetgroup min max NHIGH NLOW NOUT RANGE Q1 Q2 Q3/
header = 'Extremes groupe';
RUN;

/*cylindres*/
PROC SORT DATA=TOTO.auto_mpg_clean ;
BY origine;
RUN;
PROC BOXPLOT data=TOTO.auto_mpg_clean;
PLOT cylindres* origine
/ CAXIS = black CTEXT = black CBOXES = black
BOXSTYLE = schematic
IDCOLOR = black IDSYMBOL=dot;
inset min mean max stddev /
header = 'Overall Statistics'
pos=tm;
insetgroup min max NHIGH NLOW NOUT RANGE Q1 Q2 Q3/
header = 'Extremes groupe';
RUN;

/*deplacement*/
PROC SORT DATA=TOTO.auto_mpg_clean ;
BY origine;
RUN;
PROC BOXPLOT data=TOTO.auto_mpg_clean;
PLOT deplacement* origine
/ CAXIS = black CTEXT = black CBOXES = black
BOXSTYLE = schematic
IDCOLOR = black IDSYMBOL=dot;
inset min mean max stddev /
header = 'Overall Statistics'
pos=tm;
insetgroup min max NHIGH NLOW NOUT RANGE Q1 Q2 Q3/
header = 'Extremes groupe';
RUN;

/*****************************************************/
/*fichier 2 ajout des variables usa et europe et asie*/
data TOTO.auto_mpg_clean2;
set TOTO.auto_mpg_clean;
if origine='USA' then USA=1;
else USA=0;
if origine='Europe' then EUROPE=1;
else EUROPE=0;
if origine='Asie' then Asie=1;
else Asie=0;
run;
proc print data=TOTO.auto_mpg_clean2;
run;
proc means data=TOTO.auto_mpg_clean2 N NMISS MIN MAX RANGE MEAN MEDIAN STD;
var Poids puissance acceleration age mpg ;
class origine;
run; 


/*** ETAPE 3  ***/ 
/**** la correlation entre les variables , on observe que toute les variable sont coreller entre eux */
PROC CORR DATA=TOTO.auto_mpg_clean2 PLOTS=SCATTER(NVAR=all);
   VAR  mpg poids puissance USA Europe Asie acceleration cylindres Deplacement age ;
RUN;

Proc REG data=TOTO.auto_mpg_clean2 corr; 
title 'Régression ' ; 
model mpg=poids puissance USA Europe Asie  cylindres Deplacement age / dw spec vif collinoint r influence;
 plot p.*obs. ;
run;
/* on observe que les variables puissance europe cylindres deplacement ne sont pas significatif */


/*** enlever les valeurs atypiques */


data TOTO.auto_mpg_clean3;
set TOTO.auto_mpg_clean2;
IF acceleration=22.2 and origine=:'USA' Then delete;
IF acceleration=22.1 and origine=:'USA' Then delete;
IF puissance=133 and origine=:'Europe' Then delete;
IF puissance=125 and origine=:'Europe' Then delete;
IF puissance=120 and origine=:'Europe' Then delete;
If deplacement=183 and origine=:'Europe' Then delete;
if cylindres=6 and origine=:'Europe' Then delete;
if cylindres=5 and origine=:'Europe' Then delete;
if cylindres=6 and origine=:'Asie' Then delete;
if cylindres=3 and origine=:'Asie' Then delete;
run;


PROC SORT DATA=TOTO.auto_mpg_clean3 ;
BY origine;
RUN;
/*poids*/
PROC BOXPLOT data=TOTO.auto_mpg_clean3;
PLOT poids* origine
/ CAXIS = black CTEXT = black CBOXES = black
BOXSTYLE = schematic
IDCOLOR = black IDSYMBOL=dot;
inset min mean max stddev /
header = 'Overall Statistics'
pos=tm;
insetgroup min max NHIGH NLOW NOUT RANGE Q1 Q2 Q3/
header = 'Extremes groupe';
RUN;

/*puissance */
PROC SORT DATA=TOTO.auto_mpg_clean3 ;
BY origine;
RUN;
PROC BOXPLOT data=TOTO.auto_mpg_clean3;
PLOT puissance* origine
/ CAXIS = black CTEXT = black CBOXES = black
BOXSTYLE = schematic
IDCOLOR = black IDSYMBOL=dot;
inset min mean max stddev /
header = 'Overall Statistics'
pos=tm;
insetgroup min max NHIGH NLOW NOUT RANGE Q1 Q2 Q3/
header = 'Extremes groupe';
RUN;

/* acceleration*/
PROC SORT DATA=TOTO.auto_mpg_clean3 ;
BY origine;
RUN;
PROC BOXPLOT data=TOTO.auto_mpg_clean3;
PLOT acceleration* origine
/ CAXIS = black CTEXT = black CBOXES = black
BOXSTYLE = schematic
IDCOLOR = black IDSYMBOL=dot;
inset min mean max stddev /
header = 'Overall Statistics'
pos=tm;
insetgroup min max NHIGH NLOW NOUT RANGE Q1 Q2 Q3/
header = 'Extremes groupe';
RUN;

/*cylindres*/
PROC SORT DATA=TOTO.auto_mpg_clean3 ;
BY origine;
RUN;
PROC BOXPLOT data=TOTO.auto_mpg_clean3;
PLOT cylindres* origine
/ CAXIS = black CTEXT = black CBOXES = black
BOXSTYLE = schematic
IDCOLOR = black IDSYMBOL=dot;
inset min mean max stddev /
header = 'Overall Statistics'
pos=tm;
insetgroup min max NHIGH NLOW NOUT RANGE Q1 Q2 Q3/
header = 'Extremes groupe';
RUN;

/*deplacement*/
PROC SORT DATA=TOTO.auto_mpg_clean3 ;
BY origine;
RUN;
PROC BOXPLOT data=TOTO.auto_mpg_clean3;
PLOT deplacement* origine
/ CAXIS = black CTEXT = black CBOXES = black
BOXSTYLE = schematic
IDCOLOR = black IDSYMBOL=dot;
inset min mean max stddev /
header = 'Overall Statistics'
pos=tm;
insetgroup min max NHIGH NLOW NOUT RANGE Q1 Q2 Q3/
header = 'Extremes groupe';
RUN;

data TOTO.auto_mpg_clean4;
set TOTO.auto_mpg_clean3;
IF acceleration=24.8 and origine=:'Europe' Then delete;
IF acceleration=24.6 and origine=:'Europe' Then delete;
IF acceleration=23.7 and origine=:'Europe' Then delete;
IF acceleration=23.5 and origine=:'Europe' Then delete;
run;

/*acceleration*/
PROC SORT DATA=TOTO.auto_mpg_clean4;
BY origine;
RUN;
PROC BOXPLOT data=TOTO.auto_mpg_clean4;
PLOT acceleration* origine
/ CAXIS = black CTEXT = black CBOXES = black
BOXSTYLE = schematic
IDCOLOR = black IDSYMBOL=dot;
inset min mean max stddev /
header = 'Overall Statistics'
pos=tm;
insetgroup min max NHIGH NLOW NOUT RANGE Q1 Q2 Q3/
header = 'Extremes groupe';
RUN;

/* le regression avec les variables significatif <0.05 , sans supprimer les vleurs atypiques*/
Proc REG data=TOTO.auto_mpg_clean2 corr; 
title 'Régression ' ; 
model mpg=poids USA age / dw spec vif collinoint r influence;
 plot p.*obs. ;
run;


Proc REG data=TOTO.auto_mpg_clean4 corr; 
title 'Régression ' ; 
model mpg=poids  USA  age europe  / dw spec vif collinoint r influence;
 plot p.*obs. ;
run;


/* le regression avec les variables significatif <0.05 , on  supprimant les vleurs atypiques*/
proc print data=TOTO.auto_mpg_clean4;
run;
data TOTO.auto_mpg_clean5;
set TOTO.auto_mpg_clean4;
IF Identifiant=321  then delete;
IF Identifiant=269  then delete;
IF Identifiant=328  then delete;
IF Identifiant=239  then delete;
IF Identifiant=327  then delete;
IF Identifiant=243  then delete;
IF Identifiant=324  then delete;
IF Identifiant=308  then delete;
IF Identifiant=382  then delete;
IF Identifiant=348  then delete;
run;


Proc REG data=TOTO.auto_mpg_clean5 corr; 
title 'Régression ' ; 
model mpg=poids USA age europe/ dw spec vif collinoint r influence;
 plot p.*obs. ;
run;

/* mpg= 47.46 -0.006*poids -3.17 *USA -0.68*age -1.99124*Europe

/*  Construction du modèle de prédiction et prédiction */
/* notre modele final contient l'ancinne variable et les 4 nouveau variables age ,usa ,europe,asie */

data TOTO.auto_mpg_a_predire_clean;
set TOTO.auto_mpg_a_predire;
age=83-annee_du_modele;
drop annee_du_modele;
run;

data TOTO.auto_mpg_a_predire_clean2;
set TOTO.auto_mpg_a_predire_clean;
if origine='USA' then USA=1;
else USA=0;
if origine='Europe' then EUROPE=1;
else EUROPE=0;
if origine='Asie' then Asie=1;
else Asie=0;
run;

data TOTO.auto_mpg_a_predire_clean2;
set TOTO.auto_mpg_a_predire_clean2;
drop mpg;
run;

data TOTO.auto_mpg_a_predire_clean3;
set TOTO.auto_mpg_a_predire_clean2;
if Identifiant=50 then mpg=47.46-0.006*2123 -0.68*12 -1.99124;
if Identifiant=160 then mpg= 47.46 -0.006*3897 -3.17 *1 -0.68*8 -1.99124*0;
if Identifiant=161 then  mpg= 47.46 -0.006*3730 -3.17 *1 -0.68*8 -1.99124*0;
if Identifiant=51 then  mpg= 47.46 -0.006*2074 -3.17 *0 -0.68*12 -1.99124*1;
if Identifiant=293 then  mpg= 47.46 -0.006*1975 -3.17 *0 -0.68*4 -1.99124*0;
if Identifiant=302 then  mpg= 47.46 -0.006*2020 -3.17 *0 -0.68*4 -1.99124*0;
run;





