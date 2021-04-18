


*--------------------------------------------------------- 
	1. SETUP THE CURRENT WORKING DIRECTORY LIBRARY NAME
----------------------------------------------------------;
%LET DIR = C:\Users\Rima\Documents\Metro College\Lectures\DSPSAS\Demographic_Profile_Analysis ; 
%LET DIR_RESULT = C:\Users\Rima\Documents\Metro College\Lectures\DSPSAS\Demographic_Profile_Analysis\SAS_Outputs ; 


%PUT &DIR.;
* SETTING UP THE LIBRARY NAME;
LIBNAME Rima "&DIR."; 

* CONNECTING TO THE USER-DEFINED MACROS;
%INCLUDE "&DIR.\User_Defined_Macros.sas";

* CONNECTING TO THE USER-DEFINED FORMATS;
%INCLUDE "&DIR.\User_Defined_Formats.sas";
%INCLUDE "&DIR.\User_Defined_Formats_KEEP_NUMERIC.sas";


%LET DSC = RIMA.PROJECT2;
%LET DS_VARS = RIMA.PROJECT2_VARIABLES;

*-----------------------------------
	2. TURN ON MICRO PREPROCESSOR
-------------------------------------;
PROC OPTIONS OPTION = MACRO;
RUN;

* TURN ON ALL OPTIONS;
OPTIONS MLOGIC MPRINT SYMBOLGEN;


* VIEWING THE DETAILS OF VARIABLES FOR CENSUS DATASET;
PROC PRINT DATA = &DS_VARS; 
RUN;

* PROFILING THE DATA;
PROC CONTENTS DATA = &DSC;
RUN;

PROC CONTENTS DATA = &DSC OUT = RIMA.UNIVERSE_VAR (KEEP = NAME TYPE LENGTH FORMAT);
RUN;



PROC CONTENTS DATA = &DSC VARNUM SHORT;RUN;
*ID PNUM SAMPLE REGION FNLWGT FAM_ID F_PNUM CENFAMID CF_PNUM RSDNC PRMRY PEOPL Q2P2 Q2P5B Q2P6 Q2P6_I Q2P7M Q2P7D 
Q2P7Y AGE AGE_I AGECAT Q2P10 Q2P11 Q2P12 Q2P16 Q2P16_I Q2P13M1 Q2P13M2 Q2P13M3 Q2P13M4 Q2P13M5 Q2P13M6 Q2P13M7 
Q2P13_I Q2P14 Q215P Q2P15 Q215B1 Q215B2 Q215B3 Q2P17 Q217B Q2P18 Q2P19 Q2P20 Q2P21 CITIZEN Q2P23 PLACE1YR CONTY1YR 
STATE Q2P25 Q2P26 Q2P27 Q3P1 Q3P2 Q3P2A Q3P2B Q3P3 Q3P4 Q3P5 HHTYPE ADULTS18 ADULTS19 ADULTS21 CHLDRN14 CHLDRN17 
CHLDRN18 CHLDRN20 Q4P1 OWNBUS Q4P42 Q4P4A Q4P4B Q4P4C Q4P4D Q4P4E Q4P4F Q4P4G Q4P3 Q4P4 Q4P5 Q4P6 Q4P6A Q4P7 Q4P8 
Q4P9 Q4P10 Q4P12 MAJIND00 Q4P16 Q4P17 HOURWEEK WGWK1ST WGHR1ST WGWKOTH WGHROTH Q4P20 Q4P21 Q4P22 Q4P23 Q4P24 Q424A 
Q424B Q424C Q4P25 Q4P26 Q4P27 Q4P28 Q4P29 Q4P31 Q4P30 Q4P0A Q4P32 Q4P33 Q4P34 Q4P35 Q4P36 Q4P37 Q4P38 Q438B Q4P39 
LFS LFS_I Q5P1 Q5P2 Q5P3 Q5P4 Q5P5 Q5P6 Q5P7 Q5P8 Q5P9 CHECK Q5P10 Q5P11 MAJIND99 Q5P12 Q5P14 Q5P15 Q6P1A Q6P2 Q6P4A 
Q6SS1 Q6SS2 Q6SS3 Q6SS4 Q6DI1 Q6DI2 Q6DI3 Q6FS1 Q6FS2 Q6FS3 Q6GA1 Q6GA2 Q6GA3 Q6GA4 Q6CS1 Q6CS2 Q6CS3 Q6CS4 Q6UI1 
Q6UI2 Q6UI3 Q6UI4 PNWAGE PEARN99 WAGEHR99 WAGEWK99 Q6P8A Q6P9 HHINC HHINC_I HHINCCAT HHEARN99 NWAGEINC HHPOVLEV 
HHPOVCAT FAMINC99 FAMINC_I FAMINCAT CNFAMINC CNFINCAT POVLEV POVCAT CFPOVLEV CFPOVCAT INS_EMP EMP_I INS_MDCR MDCR_I 
INS_OWN OWN_I INS_MAA MAA_I INS_MIL MIL_I INS_BHP BHP_I INS_OUT OUT_I INS_OTH OTH_I NUMPLANS PRIMECOV CUR_INS Q7P7 
Q7P6 Q7P5 Q7P3Z WHICH Q7P11 Q7P11_I Q8P1 Q8P2 Q8P3 Q8P3A Q8P3B Q8P4 Q8P5 Q8P6 Q8P7 Q8P7A Q8P8 Q8P9 Q8P10 Q8P11 Q811A 
Q811B Q811C Q811D Q811E MAAWGT;

* VIEWING FEW OBSERVATIONS OF THE CENSUS DATASET ;
PROC PRINT DATA = &DSC(obs = 10); RUN;
/*****************************************************************************
	3. BRIEF CENSUS SUMMARY OF WHASHINGTON STATE IN 2004
*****************************************************************************/

ODS PDF FILE = "&DIR_RESULT.\POPULATION_SIZE_&SYSDATE9..PDF";
	* Householders - Number of householders (6726);
TITLE "NUMBER OF HOUSE HOLDERS";
PROC SQL;
	SELECT COUNT(DISTINCT ID) AS Householders INTO : Householders
	FROM &DSC.;	
QUIT;
	
%PUT &Householders;

* Families - Number of families (4860);
TITLE "NUMBER OF FAMILIES";
PROC SQL;
	SELECT COUNT(DISTINCT CENFAMID) AS Families INTO : Families
	FROM &DSC.;	
QUIT;
%PUT &Families;

* Citizens - Number of citizens (17967);
TITLE "SIZE OF THE POPULATION";
PROC SQL;
	SELECT COUNT(*) AS Population INTO : Population
	FROM &DSC.;	
QUIT;
%PUT &Population;


*------------------------------------------------------------------------------ 
	DISTRIBUTION OF GENDER BY PIE CHART
*------------------------------------------------------------------------------;
TITLE J = CENTER FONT = 'GRAMAND' HEIGHT = 12pt COLOR = WHITE bcolor = DEEPSKYBLUE 
	"Distribution of Gender";
ODS GRAPHICS / NOBORDER RESET WIDTH = 2.5IN HEIGHT = 2.5IN;
%PIECHART_NUMERIC(DSC = &DSC., VARNAME = Q2P6, VARFMT = SEX_FMT, DSKIN = GLOSS)


DATA RIMA.POP;
	POPULATION = &Population.;
	FAMILIES =  &Families.;
	HOUSEHOLDERS = &Householders.;
RUN;

PROC PRINT DATA = RIMA.POP; RUN;
ODS PDF CLOSE;

ODS PDF FILE = "&DIR_RESULT.\POPULATION_PICHART_&SYSDATE9..PDF";
ODS GRAPHICS / NOBORDER RESET WIDTH = 3.5IN HEIGHT = 3.5IN;
TITLE J = CENTER FONT= 'GRAMAND' HEIGHT = 14pt COLOR = WHITE bcolor=DEEPSKYBLUE 
	"Distribution of number of members in House holders";
PROC SQL;
	CREATE VIEW RIMA.HH_NUM_MEM AS
		SELECT ID, COUNT(*) AS NUM_HH_MEMBERS LABEL "NUMBER OF MEMBERS PER HOUSEHOLD"
		FROM RIMA.project2
		GROUP BY ID;

	SELECT NUM_HH_MEMBERS, 
		   CAT(PUT(COUNT(ID), BEST12.), " (", PUT(((COUNT(ID)/&HouseHolders) ) , PERCENT8.2), ")") AS NUM_HH LABEL "NUMBER OF HOUSE HOLDERS"		   
	FROM RIMA.HH_NUM_MEM
	GROUP BY NUM_HH_MEMBERS
	ORDER BY NUM_HH DESC;
	
	ods graphics / reset width = 3.5in height = 3.5in;
	%PIECHART_NUMERIC(DSC = RIMA.HH_NUM_MEM, VARNAME = NUM_HH_MEMBERS, VARFMT = num_mem)

	/*
	PROC SGPIE DATA = RIMA.HH_NUM_MEM;
	    format NUM_HH_MEMBERS num_mem.;
	    STYLEATTRS datacolors= (GOLD RED LIMEGREEN  MAROON MAGENTA BLUE ORANGE PINK ROSE STEEL TAN);
	    donut NUM_HH_MEMBERS /  holevalue holelabel = '#HHs' ringsize=0.5 DATALABELDISPLAY = (PERCENT CATEGORY)
								DATALABELATTRS = (COLOR = Black FAMILY = Gramand Size = 10 STYLE = Normal WEIGHT = Bold)
						DATASKIN = gloss
						HOLEVALUEATTRS=(Color = Green Family=Gramand  Weight=Bold)
						HOLElabelATTRS=(Color = Red Family=Gramand Weight=Bold);
	RUN;
	*/
QUIT;

ODS GRAPHICS / NOBORDER RESET WIDTH = 4IN HEIGHT = 2.5IN;
TITLE J = CENTER FONT= 'GRAMAND' HEIGHT = 14pt COLOR = WHITE bcolor=DEEPSKYBLUE 
	"Distribution of number of families in a house";
PROC SQL;
	CREATE VIEW RIMA.NUM_FAM_PER_HH AS
		SELECT ID, COUNT(DISTINCT FAM_ID) AS NUM_OF_FAMILIES LABEL "NUMBER OF FAMILIES PER HOUSEHOLD"
		FROM RIMA.project2
		GROUP BY ID;
	
		SELECT NUM_OF_FAMILIES, 
				COUNT(ID) AS NUM_HH LABEL "NUMBER OF HOUSE HOLDERS", 
				(CALCULATED NUM_HH/&HouseHolders) AS PERCENTAGE FORMAT = PERCENT8.2
		FROM RIMA.NUM_FAM_PER_HH
		GROUP BY NUM_OF_FAMILIES
		ORDER BY NUM_HH DESC;

		%PIECHART_NUMERIC(DSC = RIMA.NUM_FAM_PER_HH, VARNAME = NUM_OF_FAMILIES, VARFMT = NUM_FMEM, DSKIN = SHEEN, MSLICES = 4);
		%BAR_CHART_DISCRETE(DSC = RIMA.NUM_FAM_PER_HH, VARNAME = NUM_OF_FAMILIES, VARFMT = NUM_FMEM, VAR_DESC = "" );
RUN;
QUIT;

ODS GRAPHICS / NOBORDER RESET WIDTH = 3.5IN HEIGHT = 3.5IN;
TITLE J = CENTER FONT= 'GRAMAND' HEIGHT = 14pt COLOR = WHITE bcolor=DEEPSKYBLUE 
	"Distribution of number of family members";

PROC SQL;
	CREATE VIEW RIMA.NUM_FAM_MEM_PER_FAM AS
		SELECT CENFAMID, COUNT(CF_PNUM) AS NUM_OF_MEMBERS LABEL "NUMBER OF MEMBERS PER FAMILY"
		FROM RIMA.project2
		GROUP BY CENFAMID;

		SELECT NUM_OF_MEMBERS, 
				COUNT(CENFAMID) AS NUM_FM LABEL "NUMBER OF FAMILIES", 
				(CALCULATED NUM_FM/&Families) AS PERCENTAGE FORMAT = PERCENT8.2
		FROM RIMA.NUM_FAM_MEM_PER_FAM
		GROUP BY NUM_OF_MEMBERS
		ORDER BY NUM_FM DESC;

		%PIECHART_NUMERIC(DSC = RIMA.NUM_FAM_MEM_PER_FAM, VARNAME = NUM_OF_MEMBERS, VARFMT = NUM_MEM, DSKIN = SHEEN, MSLICES = 5)
QUIT;
RUN;
ODS PDF CLOSE;



/*****************************************************************************
 	4. SELECTING THE TARGET(Y) AND INDEPENDENT(Xs) VARIABLES ACCORDING TO MY BUSINESS QUESTIONS.
  	   Y = ANNUAL PERSONAL EARNINGS (PEARN)
*****************************************************************************/

* CATEGORICAL VARIABLES:	SEX AGECAT  RACE MARISTATUS REGION EDUCATION BORNCITIZEN CITIZEN 
   							EMPTYPEMAIN WORKTYPE JOPTYPE       
  NUMERICAL VARIABLES: 		AGE HRSPERWEEK JOBWEEKS WGWK1ST WGWKOTH WAGEWK99 PEARN;

* PUT(Q4P25, 1.) AS JOPTYPE, WGWKOTH;


* FOR THE FORMATTING WE HAVE TO MAKE 2 DIGIT VALUES FOR "Q2P17 - EDUCATION";

/*	
PROC SQL;
	UPDATE &DSC
	SET Q2P17 = Q2P17 + 9;
QUIT;
*/
PROC FREQ DATA = &DSC;
	TABLE Q2P17/MISSING;
RUN;

/*-------------------------------
	5. VARIABLE IDENTIFICATION
--------------------------------*/
%LET DS_CENSUS = RIMA.CENSUS;
PROC SQL;
	CREATE TABLE &DS_CENSUS. AS
		SELECT 	PUT(Q2P6, 1.) AS SEX,
				PUT(AGECAT, 1.) AS AGECAT,
				AGE,
				PUT(Q2P13M1, 1.) AS RACE,
				PUT(Q2P14, 1.) AS MARISTATUS,
				PUT(REGION, 1.) AS REGION,
				PUT(Q2P17, 2.) AS EDUCATION,
				PUT(Q2P18, 1.) AS BORNCITIZEN,
				PUT(CITIZEN, 1.) AS CITIZEN,				
				Q4P8 AS HRSPERWEEK,
				PUT(Q4P9, 1.) AS EMPTYPEMAIN,
				PUT(Q4P12, 2.) AS WORKTYPE, 				
				Q5P1 AS JOBWEEKS,
				WGWK1ST LABEL 'WEEKLY EARNINGS - MAIN JOB (LAST WEEK)',				
				PEARN99 AS PEARN LABEL '2004 PERSONAL WAGE EARNINGS'																
		FROM &DSC
		WHERE AGE GE 15 AND PEARN99 IS NOT NULL;
QUIT;


PROC CONTENTS DATA = &DS_CENSUS VARNUM SHORT;RUN;


* FIND THE TOTAL NUMBER OF OBSERVATIONS;
%TOTAL_OBS(DSC = &DS_CENSUS)

/*----------------------------------------------------
	6. SPLIT INTO NUMERIC AND CATEGORICAL VARIABLES
------------------------------------------------------*/
PROC CONTENTS DATA = &DS_CENSUS OUT=CONTENTS;
RUN;

PROC SQL;
SELECT NAME INTO : NUM_ONLY SEPARATED BY " "
FROM CONTENTS
WHERE TYPE EQ 1
;
SELECT NAME INTO : CHAR_ONLY SEPARATED BY " "
FROM CONTENTS
WHERE TYPE EQ 2
;
QUIT;

%LET TARGET_VAR = PEARN;

%PUT &TARGET_VAR;
%PUT &NUM_ONLY;
%PUT &CHAR_ONLY;


/*--------------------------------------------------
	7. CHECK THE AGE CRETERIA FOR ALL VAIABLES
----------------------------------------------------*/
%CHECK_AGE_LIMIT(DSC = &DS_CENSUS, CVARS = &CHAR_ONLY, NVARS = &NUM_ONLY);
* WE FOUND THAT MARITALSTATUS HAVE 141 OBSERVATIONS CONTAIN "A"s. THEREFORE, WE HAVE TO TRANSFORM "A" INTO UNMARRIED(5);
PROC SQL;
	UPDATE &DS_CENSUS
	SET MARISTATUS = '5'
	WHERE MARISTATUS EQ 'A';
QUIT;


* DROP THE OBSERVATIONS THAT CONTAIN UNKNOWN DATA VALUES SUCH AS 'A', 'D', 'N', 'R' AND 'S'.;
ODS PDF FILE = "&DIR_RESULT.\FREQUENCY DISTRIBUTION OF CATEGORICAL VARIABLES &SYSDATE9..PDF";
%DROP_UNKNOWN_VAL_OBS(DSC = &DS_CENSUS, CVARS = &CHAR_ONLY) 
ODS PDF CLOSE;


ODS PDF FILE = "&DIR_RESULT.\MEANS OF NUMERICAL VARIABLES &SYSDATE9..PDF";
%PROC_MEANS(DSC = &DS_CENSUS, NVARS = &NUM_ONLY)
ODS PDF CLOSE;


%TOTAL_OBS(DSC = &DS_CENSUS)


*---------------------------------------------
	8. 	UNIVARIATE ANALYSIS:
		(A). DISTRIBUTION OF THE VARIABLES
 		(B). MISSING VALUE ANALYSIS
 		(C). OUTLIER ANALYSIS;
*-----------------------------------------------;

*--------------------------------
	8.1. CATEGORICAL VARIABLES
*---------------------------------;
%PUT &CHAR_ONLY;
*AGECAT BORNCITIZEN CITIZEN EDUCATION EMPTYPEMAIN MARISTATUS RACE REGION SEX WORKTYPE;

* USER DEFINED FORMAT FOR THE CATEGORICAL VARIABLES;
%LET CFMT = AGECAT_FMT BINARY_FMT BINARY_FMT EDUCA_FMT EMP_FMT MARISTA_FMT RACE_FMT REGION_FMT SEX_FMT WORK_FMT;
%LET DSKIN = CRISP GLOSS MATTE PRESSED SHEEN CRISP GLOSS MATTE PRESSED SHEEN;
%PUT &CFMT;


* UNIVARIATE ANALYSIS FOR CHARACTER VARIABLES ;
ODS PDF FILE = "&DIR_RESULT.\UNIVARIATE ANALYSIS FOR CATEGORICAL VARIABLES &SYSDATE9..PDF";
ODS GRAPHICS / NOBORDER RESET WIDTH = 4in HEIGHT = 4.5in;
%UNI_ANALYSIS_CATE(DSC = &DS_CENSUS, CVARS = &CHAR_ONLY, FMT = &CFMT, DATASKIN = &DSKIN)


* CREATE A VERTICAL BAR CHART FOR GROUPED AGE;
ODS GRAPHICS / NOBORDER RESET WIDTH = 9in HEIGHT = 5.5in;
%BAR_CHART_CATE(DSC = &DS_CENSUS., VARNAME = AGECAT, VARFMT = AGECAT_FMT, VAR_DESC = AGE)
ODS PDF CLOSE;


*------------------------------------------------------
	8.2. UNIVARIATE ANALYSIS FOR NUMERICAL VARIABLES
-------------------------------------------------------;
ODS PDF FILE = "&DIR_RESULT.\UNIVARIATE ANALYSIS FOR NUMERICAL VARIABLES &SYSDATE9..PDF";
ODS GRAPHICS / NOBORDER RESET WIDTH = 3.5in HEIGHT = 3.5in;
%UNI_ANALYSIS_NUMERIC(DSC = &DS_CENSUS, NVARS = &NUM_ONLY)
ODS PDF CLOSE;

* DESIGN A FORMAT TO CONVERT THE NUMERICAL TARGET VARIABLE INTO GROUP;
PROC SQL;
	SELECT MAX(PEARN) INTO : MAX_PEARN
	FROM &DS_CENSUS;
QUIT;

PROC SQL;
	SELECT MIN(PEARN) INTO : MIN_PEARN
	FROM &DS_CENSUS;
QUIT;

%PUT &MAX_PEARN;
%PUT &MIN_PEARN;
* THE TARGET VARIABLE "PEARN" IS GROUPED AND CREATEDA VERTICAL BAR CHART;
PROC FORMAT;
	VALUE PRN_GRP_FMT	&MIN_PEARN. - 40000 = "LESS THAN 40K"
						40000 - 80000 = "40K - 80K"
						80000 - 120000 = "80K - 120K"
						120000 - 160000 = "120K - 160K"
						160000 - 200000 = "160K - 200K"
						200000 - 240000 = "200K - 240K"
						240000 - &MAX_PEARN. = "240K OR OVER";
RUN;

ODS GRAPHICS / NOBORDER RESET WIDTH = 9in HEIGHT = 5.5in;
%BAR_CHART_DISCRETE(DSC = &DS_CENSUS , VARNAME = PEARN, VARFMT = PRN_GRP_FMT, VAR_DESC = PERSONAL ANNUAL WAGE EARNINGS);
ODS PDF CLOSE; 


*-----------------------------------
	9. BIVARIATE ANALYSIS
		TARGET VARIABLE Y(PEARN) VS X-VARIABLE
		(A)CATE VS CATE
		(B)CATE VS NUMERIC
		(C) NUMERIC VS NUMERIC;


*-------------------------------------------------------------------
	9.1 PERFORM CHI-SQUARE TEST BETWEEN TARGET AND CHARACTER VARIABLES
--------------------------------------------------------------------;
ODS PDF FILE = "&DIR_RESULT.\CHI-SQUARE TEST &SYSDATE9..PDF";
* CHI-SQUARE TEST WITH STACKED BAR CHART ;
GOPTIONS RESET = ALL;
ODS GRAPHICS / NOBORDER RESET WIDTH = 12in HEIGHT = 5.5in;
%CHISQUARE_TEST(DSC = &DS_CENSUS, CVARS = &CHAR_ONLY, FMT = &CFMT)

* CHI-SQUARE TEST WITH UNSTACKED BAR CHART ;
ODS GRAPHICS / NOBORDER RESET WIDTH = 12in HEIGHT = 5.5in;
%CHISQUARE_TEST_NS(DSC = &DS_CENSUS, CVARS = &CHAR_ONLY, FMT = &CFMT) 
ODS PDF CLOSE; 


*-----------------------------------------------------------------------------
	9.2 PERFORM ANOVA TEST BETWEEN GROUPED TARGET AND INDEPENDENT  VARIABLES
------------------------------------------------------------------------------;
ODS PDF FILE = "&DIR_RESULT.\ANOVA TEST &SYSDATE9..PDF";
%ANOVA_TEST(DSC = &DS_CENSUS, NVARS = &NUM_ONLY, FMT = PRN_GRP_FMT);
ODS PDF CLOSE;	
*----------------------------------------------------------------------;

*--------------------------------------------------------------------------
	9.3 PERFORM CORRELATION TEST BETWEEN TARGET AND INDEPENDENT VARIABLES
----------------------------------------------------------------------------;
%PUT &NUM_ONLY;

ODS PDF FILE = "&DIR_RESULT.\CORRELATION TEST &SYSDATE9..PDF";
%CORRELATION_TEST(DSC = &DS_CENSUS, NVARS = &NUM_ONLY)
ODS PDF CLOSE;





*---------------------------------------------------------------------------------------------
	10. MULTIVARIATE ANALYSIS

	10.1. SCATTER : PEARN VS HRSPERWEEK BY SEX
--------------------------------------------------------------------------------------------;
ODS PDF FILE = "&DIR_RESULT.\MULTIVARIATE ANALYSIS &SYSDATE9..PDF";
%LET DRPD_OL = RIMA.DROPPED_OL;
PROC SQL;
	CREATE TABLE  &DRPD_OL. AS
	SELECT PEARN, HRSPERWEEK, SEX
	FROM &DS_CENSUS;
QUIT;

 /*%DROP_OUTLIER(DSC = &DRPD_OL., LIBNAME = RIMA, NVAR = pearn, THRESHOLD = 3.0) */

GOPTIONS RESET = ALL CBACK = VERYLIGHTGREEN NOBORDER HSIZE = 9IN VSIZE = 5.5IN;  

SYMBOL1 COLOR = PINK VALUE = "#"; 
SYMBOL2 COLOR = DEEPSKYBLUE VALUE = '"';
LEGEND1 LABEL = ("GENDER" HEIGHT = 2 COLOR = GREEN POSITION = TOP JUSTIFY = CENTER)
VALUE = (COLOR = GREEN )
ACROSS=1 DOWN=2
CFRAME = VERYLIGHTGREEN CBORDER = GREEN
MODE = PROTECT
POSITION = (TOP RIGHT INSIDE);

AXIS1	LABEL =( J = C H = 2 COLOR = RED "HOURS PER WEEK")  
 		VALUE =( H = 1.5   COLOR = BLACK);

AXIS2	LABEL =(A = 90 J = C H = 2 COLOR = RED "PERSONAL WAGE EARNINGS" )
		VALUE =(H = 1.5  COLOR = BLACK);
PROC GPLOT DATA = &DRPD_OL.;
	TITLE J = CENTER HEIGHT = 12pt COLOR = BLUE  "GENDER "  
			  COLOR = GREEN "IS ADDEDD TO THE SCATTER PLOT FOR " 
			  COLOR = BLUE "PEARN " 
			  COLOR = GREEN "AND "
			  COLOR = BLUE "HOURS PER WEEK WORKED";
	PLOT PEARN * HRSPERWEEK = SEX / LEGEND = LEGEND1 HAXIS = AXIS1 VAXIS = AXIS2 CFRAME = VERYLIGHTGREEN ;								
	FORMAT SEX $SEX_FMT.;
RUN;
QUIT;
ODS PDF CLOSE;
*---------------------------------------------------------------------------------------------;

*---------------------------------------------------------------------------------------------
	10.2. SCATTER : PEARN VS AGE BY SEX
--------------------------------------------------------------------------------------------;
%LET DRPD_OLP = RIMA.DROPPED_OLP;

PROC SQL;
	CREATE TABLE &DRPD_OLP. AS
		SELECT PEARN, INPUT(SEX, BEST12.) AS SEX, INPUT(AGECAT, BEST12.) AS AGECAT
		FROM &DS_CENSUS.;
RUN;
QUIT;
PROC CONTENTS DATA = &DRPD_OLP. ; RUN;
%DROP_OUTLIER(DSC = &DRPD_OLP., LIBNAME = RIMA, NVAR = PEARN, THRESHOLD = 3.0) 

ODS PDF FILE = "&DIR_RESULT.\SCATTER PEARN VS AGE BY SEX &SYSDATE9..PDF";
ODS GRAPHICS / RESET WIDTH = 9in HEIGHT = 5.5in;
PROC SGPANEL DATA = &DRPD_OLP.;    
	PANELBY SEX / COLUMNS = 2 NOWALL NOVARNAME NOHEADERBORDER NOBORDER
					HEADERBACKCOLOR = DEEPSKYBLUE 
					HEADERATTRS = (COLOR = GOLD FAMILY = GRAMAND Size = 11  WEIGHT = BOLD); 
	STYLEATTRS DATACOLORS = (GOLD) BACKCOLOR = DEEPSKYBLUE;
	COLAXIS FITPOLICY = ROTATE LABELATTRS=(Color = DEEPSKYBLUE ) VALUEATTRS=(Color = BLACK Family = GRAMAND Size= 11  Weight=Bold);
	ROWAXIS LABELATTRS=( WEIGHT = BOLD Color = BLACK ) VALUEATTRS=(Color = BLACK Family = GRAMAND Size= 12   Weight=Bold);
	VBOX PEARN / CATEGORY = AGECAT DATASKIN = SHEEN FILLATTRS = (COLOR = GREEN TRANSPARENCY = .2) FILL NOTCHES ;
	TITLE J = CENTER HEIGHT = 12pt COLOR = BLUE "PERSONAL ANNUAL WAGE EARNINGS " 
			  COLOR = WHITE "BY " 
			  COLOR = BLUE "SEX "
			  COLOR = WHITE "AND "
			  COLOR = BLUE "AGE";
	FORMAT PEARN AGECAT AGECAT_NUM_FMT. sex SEX_FMT. ;
RUN;
QUIT;
ODS PDF CLOSE;


*---------------------------------------------------
	11. OUTLIER TREATMENTS FOR NUMERICAL VARIABLES
----------------------------------------------------;
%DROP_OUTLIER(DSC = &DS_CENSUS., LIBNAME = RIMA, NVAR = PEARN)
%DROP_OUTLIER(DSC = &DS_CENSUS., LIBNAME = RIMA, NVAR = WGWK1ST)

*---------------------------------------------------;


*-------------------------------------------------------------------------
	11. MISSING VALUE TREATMENT 
-------------------------------------------------------------------------;

* CHECK THE NORMAL DISTRIBUTION BEHAVIOURS;
ODS PDF FILE = "&DIR_RESULT.\NORMAL CURVES OF NUMERICAL VARIABLES &SYSDATE9..PDF";
%LET MISS_VARS = HRSPERWEEK WGWK1ST; /* VARIABLES HAVING MISSING VALUES*/
%CHECK_NORMAL_DISTN(DSC = &DS_CENSUS, VARS = &MISS_VARS);
ODS PDF CLOSE;


*-------------------------------------------------------
11.1.  STANDARDIZE THE MISSING VALUES FOR THE NUMERIC VARIABLES
--------------------------------------------------------;
%LET MISS_VARS = HRSPERWEEK WGWK1ST;
%LET STD_MODE = MEAN MEDIAN; /* ACCORDING TO THE QQPLOT CURVE*/

%STANDADIZE_MISSING_VAR(DSC = &DS_CENSUS, MVARS = &MISS_VARS, STDMODE = &STD_MODE);

*-------------------------------------------------------
11.2.  MISSING VALUE TREATMENT FOR CHARACTER VARIABLES
--------------------------------------------------------;
%MODE_VALUE(DSC = &DS_CENSUS, CVAR = EDUCATION);

PROC FREQ DATA = &DS_CENSUS;
	TABLE EDUCATION/ MISSING;
RUN;


%PUT &CHAR_ONLY;
%PUT &NUM_ONLY;


*--------------------------------------------------------------------------------------------
	11. LINEAR MULTIVARIATE MODELLING
---------------------------------------------------------------------------------------------;
* SET OF INDEPENDENT VARIABLES;
%LET INDE_VAR = SEX AGE MARISTATUS REGION EDUCATION BORNCITIZEN CITIZEN HRSPERWEEK EMPTYPEMAIN WORKTYPE JOBWEEKS WGWK1ST;
%PUT &INDE_VAR;

/*
* STANDARDIZE THE VALUES;
PROC SQL;
	CREATE TABLE RIMA.DS_CENSUS_COPY AS
		SELECT *
		FROM &DS_CENSUS;
QUIT;

PROC STANDARD DATA = RIMA.DS_CENSUS_COPY MEAN = 0 STD = 1 OUT = RIMA.STD_DS;  
	VAR AGE HRSPERWEEK JOBWEEKS WGWK1ST PEARN;
RUN;

*/

*--------------------------------------------------------------------------------------------
	11.1. ASSUMPTIONS FOR MULTIVARIATE LINEAR REGRESSION MODEL
	11.1.1. CHECK THE LINEAR RELATIONSHIP BETWEEN TARGET AND INDEPENDENT VARIABLES
---------------------------------------------------------------------------------------------;
*WHAT IS THIS? LINEAR RELATIONSHIP BETWEEN Y AND Xs;
*WHAT ARE THE CONSQEUENCES? : THE COEFFICIENTS AND R-SQUARED WILL BE UNDERESTIMATED;
*HOW DO WE CHECK/KNOW? ;
ODS PDF FILE = "&DIR_RESULT.\LINEAR RELATIONSHIP ASSUMPTIONS &SYSDATE9..PDF";

GOPTIONS RESET = ALL;
ODS GRAPHICS / NOBORDER RESET WIDTH = 6in HEIGHT = 4.0in;
TITLE "COMPUTING PEARSON CORRELATION COEFFICIENTS";
PROC CORR DATA = &DS_CENSUS PLOTS(MAXPOINTS=NONE)=MATRIX(NVAR=ALL);
 VAR  AGE HRSPERWEEK JOBWEEKS WGWK1ST;
 WITH PEARN;
RUN;


TITLE "PRODUCING CORRELATION MATRIX";
PROC CORR DATA = &DS_CENSUS PLOTS(MAXPOINTS = NONE)= MATRIX(HISTOGRAM);
 VAR  PEARN AGE HRSPERWEEK JOBWEEKS WGWK1ST;
RUN;

*WHAT CAN YOU DO ABOU IT?;
*TRANFORM EITHER Y OR X OR BOTH;
*BOX COX TRANFORMATION;


*--------------------------------------------------------------------------------------------
	11.1.2. CHECK THE RESIDUALS FOLLOW NORMAL DISTRIBUTION
---------------------------------------------------------------------------------------------;
*WHAT IS THIS? 
*WHAT ARE THE CONSQEUENCES? YOU CANNOT PERFORM HYPOTHESIS TESTINGS;
*HOW DO WE CHECK/KNOW? ;

*STB : STANDARDIZED PARAMETERS ESITMATES;
*CLB : CONFIDENCE LIMIT FOR THE PARAMETER ESTIMATES;
*HO : RESIDUALS ARE NORMALLY DISTRIBUTED;
*H1 : RESIDUALS ARE NOT NORMALLY DISTRIBUTED;
*ALPHA =0.05;
*Shapiro-Wilk;

ODS GRAPHICS / NOBORDER RESET WIDTH = 6in HEIGHT = 4.0in;
PROC REG DATA = &DS_CENSUS PLOTS(MAXPOINTS = NONE);
 MODEL PEARN = AGE HRSPERWEEK JOBWEEKS WGWK1ST/STB CLB;
 OUTPUT OUT= STD_RESIUAL P = PREDICT R = RESIDUAL;
RUN;
QUIT;

PROC UNIVARIATE DATA = STD_RESIUAL NORMAL;
 VAR RESIDUAL;
RUN;

*WHAT CAN YOU DO ABOU IT?
*TRANFORM Y VARIABLES : LOG, SQUARE ROOT AND RECIPROCAL;

*--------------------------------------------------------------------------------------------
	11.1.3. CHECK THE MULTICOLINEARITY
---------------------------------------------------------------------------------------------;
*WHAT IS THIS? CORRELATION AMONG X VARAIBLES;
*WHAT ARE THE CONSQEUENCES? THE COEFFICIENT WILL BE UNRELIABLE;
*HOW DO WE CHECK/KNOW?;
*VIF : VARIANT INFLATION FACTOR;
* VIF : > 5 MODERATE ;
* VIF : > 10 SEVERE;

PROC REG DATA = &DS_CENSUS PLOTS(MAXPOINTS = NONE); 
 MODEL PEARN = AGE HRSPERWEEK JOBWEEKS WGWK1ST/VIF;
RUN;
QUIT;

*WHAT CAN YOU DO ABOU IT?
*DROP ONE VARIABLE;
*CREATE A COMPOSITE VARIABLE : BMI;
*TRY DIMENSION REDUCTION TECHNIQUES;


*--------------------------------------------------------------------------------------------
	11.1.4. CHECK THE HOMOSCEDSTICITY
---------------------------------------------------------------------------------------------;
*HETEROSKADESICITY;
* Y- Y^ = ERRORS/RESIDUALS;
*WHAT IS THIS? : THE VARIANCE OF THE RESIDUALS ARE EQUAL;
* What are the consqeuences? :COEFFICENT BECOMES INEFFICIENT AND HYPOTHESIS TESTING NOT RELIABLE;
*How do we check/know? : 

*I.VISUALLZE;

TITLE "PLOT RESIDUALS BY PREDICTED VALUES";
PROC REG DATA = &DS_CENSUS PLOTS(MAXPOINTS = NONE);
 MODEL PEARN = AGE HRSPERWEEK JOBWEEKS WGWK1ST;
 PLOT R. *P.;
RUN;
QUIT;

*II. MODEL SPECIFICTION : WHITE PAGAN AND LARANGE MULTIPLIER TEST(LM) TEST;
*HO :THE RESIUDALS ARE EQUAL;
*H1 : THE RESIDUALS ARE NOT EQUAL;
*ALPHA = 0.05;

TITLE "MODEL SPECIFICATIONS TEST:SPEC ";
PROC REG DATA = &DS_CENSUS PLOTS(MAXPOINTS = NONE);
 MODEL PEARN = AGE HRSPERWEEK JOBWEEKS WGWK1ST/SPEC;
RUN;
QUIT;

*What can you do abou it?
*TRANSFORMATION : Y VARAIBLE TRANSFORMATION SOMETIMES X VARAIBLES NEED TO BE TRANSFORMED;
* Y : BOX COX ---- LOG, SQUARE ROOT,RECIPROCAL;


*--------------------------------------------------------------------------------------------
	11.1.5. CHECK THE AUTOCORRELATION
---------------------------------------------------------------------------------------------;
*WHAT IS THIS? TIME SERIES DATA -
*WHAT ARE THE CONSQEUENCES? : UNDERSTIMATING THE STANDARD ERRORS OF COEFFICEINTS AND HYPOTHESIS GIVE YOU INCORRECT CONLCUSIONS;
*HOW DO WE CHECK/KNOW? : DW : DURBIN WATSON COEFFICIENT TEST;

*DW BETWEEN 1.5 AND 2.5 _ NO AUTOCORRELATION;
*DW LESS THAN 1.5 , POSTIVE AUTOCORRELATION;
*WDW GREATER THAN 2.5 , NEGATIVE AUTOCORRELATION;

TITLE "RUNNING DURBIN WATSON COEFFICIENT TEST ";
PROC REG DATA = &DS_CENSUS PLOTS(MAXPOINTS = NONE);
 MODEL PEARN = AGE HRSPERWEEK JOBWEEKS WGWK1ST/DW;
RUN;
QUIT;

*WHAT CAN YOU DO ABOU IT?
*OMIT KEY PREDICTOR(S);
*DATA TRANFORMATION (ADD LAG VALUES OF THE DEPENDENT VALUES;
ODS PDF CLOSE;



*--------------------------
	KEEP A COPY
---------------------------;
PROC SQL;
	CREATE TABLE RIMA.DS_CENSUS_ORI AS
		SELECT *
		FROM &DS_CENSUS.;
QUIT;
*---------------------------;

*-----------------------------------------------------------------------------------------------
	11.2. CREATING DUMMY VARIABLES 
------------------------------------------------------------------------------------------------;

DATA &DS_CENSUS. REPLACE;
	SET &DS_CENSUS.;

	* CREATE DUMMY VARIABLES FOR EDUCATION;
	IF EDUCATION EQ '10' THEN DO;
		EDU11 = 0; EDU12 = 0; EDU13 = 0; EDU14 = 0; EDU15 = 0; 
		EDU16 = 0; EDU17 = 0; EDU18 = 0; EDU19 = 0; EDU20 = 0;END;
	ELSE IF EDUCATION EQ '11' THEN DO;
		EDU11 = 1; EDU12 = 0; EDU13 = 0; EDU14 = 0; EDU15 = 0; 
		EDU16 = 0; EDU17 = 0; EDU18 = 0; EDU19 = 0; EDU20 = 0;END;
	ELSE IF EDUCATION EQ '12' THEN DO;
		EDU11 = 0; EDU12 = 1; EDU13 = 0; EDU14 = 0; EDU15 = 0; 
		EDU16 = 0; EDU17 = 0; EDU18 = 0; EDU19 = 0; EDU20 = 0;END;
	ELSE IF EDUCATION EQ '13' THEN DO;
		EDU11 = 0; EDU12 = 0; EDU13 = 1; EDU14 = 0; EDU15 = 0; 
		EDU16 = 0; EDU17 = 0; EDU18 = 0; EDU19 = 0; EDU20 = 0;END;
	ELSE IF EDUCATION EQ '14' THEN DO;
		EDU11 = 0; EDU12 = 0; EDU13 = 0; EDU14 = 1; EDU15 = 0; 
		EDU16 = 0; EDU17 = 0; EDU18 = 0; EDU19 = 0; EDU20 = 0;END;
	ELSE IF EDUCATION EQ '15' THEN DO;
		EDU11 = 0; EDU12 = 0; EDU13 = 0; EDU14 = 0; EDU15 = 1; 
		EDU16 = 0; EDU17 = 0; EDU18 = 0; EDU19 = 0; EDU20 = 0;END;
	ELSE IF EDUCATION EQ '16' THEN DO;
		EDU11 = 0; EDU12 = 0; EDU13 = 0; EDU14 = 0; EDU15 = 0; 
		EDU16 = 1; EDU17 = 0; EDU18 = 0; EDU19 = 0; EDU20 = 0;END;
	ELSE IF EDUCATION EQ '17' THEN DO;
		EDU11 = 0; EDU12 = 0; EDU13 = 0; EDU14 = 0; EDU15 = 0; 
		EDU16 = 0; EDU17 = 1; EDU18 = 0; EDU19 = 0; EDU20 = 0;END;
	ELSE IF EDUCATION EQ '18' THEN DO;
		EDU11 = 0; EDU12 = 0; EDU13 = 0; EDU14 = 0; EDU15 = 0; 
		EDU16 = 0; EDU17 = 0; EDU18 = 1; EDU19 = 0; EDU20 = 0;END;
	ELSE IF EDUCATION EQ '19' THEN DO;
		EDU11 = 0; EDU12 = 0; EDU13 = 0; EDU14 = 0; EDU15 = 0; 
		EDU16 = 0; EDU17 = 0; EDU18 = 0; EDU19 = 1; EDU20 = 0;END;
	ELSE DO;
		EDU11 = 0; EDU12 = 0; EDU13 = 0; EDU14 = 0; EDU15 = 0; 
		EDU16 = 0; EDU17 = 0; EDU18 = 0; EDU19 = 0; EDU20 = 1;END;

	* CREATE DUMMY VARIABLES FOR EMPLOYMENT;
	IF EMPTYPEMAIN EQ '1' THEN DO;
		EMP2 = 0; EMP3 = 0; EMP4 = 0; EMP5 = 0;END;
	ELSE IF EMPTYPEMAIN EQ '2' THEN DO;
		EMP2 = 1; EMP3 = 0; EMP4 = 0; EMP5 = 0;END;
	ELSE IF EMPTYPEMAIN EQ '3' THEN DO;
		EMP2 = 0; EMP3 = 1; EMP4 = 0; EMP5 = 0;END;
	ELSE IF EMPTYPEMAIN EQ '4' THEN DO;
		EMP2 = 0; EMP3 = 0; EMP4 = 1; EMP5 = 0;END;
	ELSE DO;
		EMP2 = 0; EMP3 = 0; EMP4 = 0; EMP5 = 1;END;

	* CREATE DUMMY VARIABLES FOR MARITAL STATUS;
	IF MARISTATUS EQ '1' THEN DO;
		MARI2 = 0; MARI3 = 0; MARI4 = 0; MARI5 = 0;END;
	ELSE IF MARISTATUS EQ '2' THEN DO;
		MARI2 = 1; MARI3 = 0; MARI4 = 0; MARI5 = 0;END;
	ELSE IF MARISTATUS EQ '3' THEN DO;
		MARI2 = 0; MARI3 = 1; MARI4 = 0; MARI5 = 0;END;
	ELSE IF MARISTATUS EQ '4' THEN DO;
		MARI2 = 0; MARI3 = 0; MARI4 = 1; MARI5 = 0;END;
	ELSE DO;
		MARI2 = 0; MARI3 = 0; MARI4 = 0; MARI5 = 1;END;
RUN;

PROC PRINT DATA = &DS_CENSUS.(OBS = 50);
RUN;

PROC CONTENTS DATA = &DS_CENSUS. ;RUN;

	
* DROP THE CATEGORICAL VARIABLES AFTER THE DUMMY VARIABLE CREATIONS;	
DATA &DS_CENSUS.  (DROP = AGECAT RACE MARISTATUS REGION EDUCATION CITIZEN EMPTYPEMAIN WORKTYPE );
	SET &DS_CENSUS. ;
RUN;


*-----------------------------------------------------------------------------------------------
	11.3. CREATE THE FINAL DATASET FOR MULTIVARIATE LINEAR REGRESSION MODELLING
------------------------------------------------------------------------------------------------;
%LET DS_MODEL = RIMA.DSMODEL;
DATA &DS_MODEL.;
	SET &DS_CENSUS.;
	SEXN = INPUT(SEX, BEST12.);
	BORNCITIZENN = INPUT(BORNCITIZEN, BEST12.);
RUN;

* DROP THE CHARACTER VARIABLES;
DATA &DS_MODEL.  (DROP = SEX BORNCITIZEN);
	SET &DS_MODEL. ;
RUN;

* RENAME THE VARIABLES;
 DATA &DS_MODEL.;
 	RENAME SEXN = SEX BORNCITIZENN = BORNCITIZEN;
	SET &DS_MODEL. ;
RUN;

PROC PRINT DATA = &DS_MODEL.(OBS = 24);
RUN;

PROC CONTENTS DATA = &DS_MODEL. VARNUM SHORT; RUN;

%LET IND_VARS = AGE HRSPERWEEK JOBWEEKS WGWK1ST EDU11 EDU12 EDU13 EDU14 EDU15 EDU16 EDU17 EDU18 EDU19 EDU20 EMP2 EMP3 EMP4 EMP5 MARI2 MARI3 MARI4 MARI5 SEX BORNCITIZEN;

/*%LET IND_VARS = AGE HRSPERWEEK JOBWEEKS WGWK1ST;*/

* NORMALIZE THE DATA;
/*%LET ZDS_MODEL = RIMA.ZDSMODEL;
PROC STANDARD DATA = &DS_MODEL. MEAN = 0 STD = 1 OUT = &ZDS_MODEL.;  
	VAR AGE &IND_VARS. ;
RUN;*/

* CREATING THE MULTIVARIATE REGRESSION MODEL WITH STEPWISE SELECTION WITH SLENTRY OF 0.5;
ODS PDF FILE = "&DIR_RESULT.\LINEAR RELATIONSHIP MODEL &SYSDATE9..PDF";
ODS GRAPHICS / NOBORDER RESET WIDTH = 6in HEIGHT = 4in;

PROC REG DATA = &DS_MODEL. PLOTS(MAXPOINTS = NONE) PLOTS(UNPACK) = (DIAGNOSTICS RESIDUALPLOT);
	MODEL PEARN = &IND_VARS. / SELECTION = STEPWISE SLENTRY=.5 RSQUARE ADJRSQ CP;
RUN;
ODS PDF CLOSE;



* RUN THE MODEL WITH SELECTED VAIABLES;
ODS GRAPHICS / NOBORDER RESET WIDTH = 9in HEIGHT = 4.5in;
%LET IND_VARS_S = AGE JOBWEEKS WGWK1ST EDU13 EDU16 EDU17 EDU18 EDU19 EDU20 MARI5 SEX BORNCITIZEN;
PROC REG DATA = &DS_MODEL. PLOTS(MAXPOINTS = NONE)  = (DIAGNOSTICS RESIDUALPLOT);;
	MODEL PEARN = &IND_VARS_S. / SELECTION = STEPWISE SLENTRY=.5 RSQUARE ADJRSQ CP;
RUN;



*-------------------------------------------------------------------------------------;
PROC PRINT DATA = &DS_MODEL.(FIRSTOBS = 3000 OBS=3000);
RUN;
DATA SCORE;
	CALCULATED_PEARN = 	(-7398.67498) + 
		60.54 * 55 +		/*Age*/
		248.28 * 52 + 		/*#Weeks worked*/
		39.6 * 480.769 + 	/* Main job last week salary */
		(-2165.81) * 0 +	/* EDU13 */
 		935.96244 * 1 + /*EDU16*/
		1685.31742 * 0 +  /*EDU17*/
		3956.27347 * 0 + /*EDU18*/
		 5392.48349 * 0 + /*EDU19*/
		5912.24165 * 0 + /*EDU20*/
		(-1461.68270) * 0 + /*MRI5*/
		(-2373.68480) * 2 +  /*SEX*/
		1099.68890 * 1;  /*BORNCITIZEN*/

RUN;
PROC PRINT DATA = SCORE;
RUN;
*----------------------------------------------------------------------------------------------;

*-----------------------------------------------------------------------------------------------
	12. TESTING FOR BUSINESS QUESTIONS
	
	12.3. Does the work hours per week depend on his/ger gender and age 
------------------------------------------------------------------------------------------------;
PROC REG DATA = &DS_MODEL. PLOTS(MAXPOINTS = NONE);
	MODEL HRSPERWEEK =  AGE SEX / SELECTION = STEPWISE SLENTRY=.5 RSQUARE ADJRSQ CP;
RUN;

* SIMPLE LINEAR REGRESSION (ONE PREDICTOR VARIABLE);
%MACRO SLR(WAC = , TVAR = , PREVARS = );
	%LET N = %SYSFUNC(COUNTW(&PREVARS));
	TITLE "SIMPLE LINEAR REGRESSION: SUMMARY";
	%DO I = 1 %TO &N;
		%LET PVAR = %SCAN(&PREVARS., &I); 
		TITLE "SIMPLE LINEAR REGRESSION WITH THE SINGLE PREDICTOR, %UPCASE(&PVAR.)";
		PROC REG DATA = &WAC. PLOTS(MAXPOINTS = 10000);
		 MODEL &TVAR. = &PVAR.; 
		RUN;
	%END;
%MEND SLR;

* Business question 3;
%SLR(WAC = &DS_MODEL., HRSPERWEEK = HRSPERWEEK, PREVARS = AGE SEX)

* Business question 4 ;
%SLR(WAC = &DS_MODEL., TVAR = AGE, PREVARS = EMP2 EMP3 EMP4 EMP5)


* Business question 5;
%SLR(WAC = &DS_MODEL., TVAR = PEARN, PREVARS = WGWK1ST)


ODS GRAPHICS / NOBORDER RESET WIDTH = 9in HEIGHT = 5in;
PROC REG DATA = &DS_MODEL. PLOTS(MAXPOINTS = NONE) ;
	MODEL pearn = JOBWEEKS WGWK1ST / SELECTION = STEPWISE SLENTRY=.5 RSQUARE ADJRSQ CP;
RUN;


%CHISQUARE_TEST(DSC = RIMA.DS_CENSUS_ORI, CVARS = AGECAT EMPTYPEMAIN, FMT = AGECAT_RMT EMP_FMT, TARVAR = AGECAT)

PROC FREQ DATA = RIMA.DS_CENSUS_ORI;
	TABLE AGECAT * EMPTYPEMAIN / CHISQ NOROW NOCOL;
	FORMAT  AGECAT $AGECAT_FMT. EMPTYPEMAIN $EMP_FMT.;
RUN;



*-----------------------------------------------------------------------------------------------;


PROC CONTENTS DATA = RIMA.DS_CENSUS_ORI ; 
RUN;

AGE HRSPERWEEK JOBWEEKS WGWK1ST PEARN EDU11 EDU12 EDU13 EDU14 EDU15 EDU16 EDU17 EDU18 EDU19 EDU20 EMP2 EMP3 EMP4 EMP5 MARI2 MARI3 MARI4 MARI5 SEX BORNCITIZEN 







*=============================;
PROC REG DATA = &DS_MODEL. NOPRINT OUTEST = RIMA.ESTIMATES;
	MODEL PEARN = &IND_VARS_S. ;
RUN;;
QUIT;

PROC SCORE DATA = crime_new score=estimates
out=scored type=parms;
var pctmetro poverty single;
RUN;


*=============================;




PROC REG DATA = &DS_MODEL. PLOTS(MAXPOINTS = NONE);
	MODEL PEARN = &IND_VARS_S. / DW SPEC;
	OUTPUT OUT = RESIDS R = RES;
RUN;

PROC UNIVARIATE DATA = RESIDS NORMAL PLOT;
	VAR RES;
RUN;




*===================================================================================================;

PROC TRANSREG;RUN;


* SIMPLE LINEAR REGRESSION (ONE PREDICTOR VARIABLE);
%MACRO SLR(WAC = , PREVARS = );
	%LET N = %SYSFUNC(COUNTW(&PREVARS));
	TITLE "SIMPLE LINEAR REGRESSION: SUMMARY";
	%DO I = 1 %TO &N;
		%LET PVAR = %SCAN(&PREVARS, &I); 
		TITLE "SIMPLE LINEAR REGRESSION WITH THE SINGLE PREDICTOR, %UPCASE(&PVAR)";
		PROC REG DATA = &WAC PLOTS(MAXPOINTS = 10000);
		 MODEL &TARGET_VAR = &PVAR; 
		RUN;
	%END;
%MEND SLR;
ODS PDF FILE = "&DIR_RESULT.\SIMPLE LINEAR REGRESSION (SLR) &SYSDATE9..PDF";
%SLR(WAC = &WAC_ENCD, PREVARS = &INDE_VAR)
ODS PDF CLOSE;

* SIMPLE LINEAR REGRESSION (ONE PREDICTOR VARIABLE);
%MACRO SLR_INFLUENCE(WAC = , PREVARS = );
	%LET N = %SYSFUNC(COUNTW(&PREVARS));
	TITLE "SIMPLE LINEAR REGRESSION: SUMMARY";
	%DO I = 1 %TO &N;
		%LET PVAR = %SCAN(&PREVARS, &I); 
		TITLE "SIMPLE LINEAR REGRESSION WITH THE SINGLE PREDICTOR, %UPCASE(&PVAR)";
		PROC REG DATA = &WAC PLOTS(ONLY) = (COOKSD(LABEL) RSTUDENTBYPREDICTED(LABEL));
		 MODEL &TARGET_VAR = &PVAR/ INFLUENCE R; 
		RUN;
		QUIT;
	%END;
%MEND SLR_INFLUENCE;
ODS PDF FILE = "&DIR_RESULT.\SIMPLE LINEAR REGRESSION (SLR_INFLUENCE) &SYSDATE9..PDF";
%SLR_INFLUENCE(WAC = &WAC_ENCD, PREVARS = &INDE_VAR)
ODS PDF CLOSE;


* MULTIVARIATE LINEAR REGRESSION;
ODS PDF FILE = "&DIR_RESULT.\MULTIVARIATE LINEAR REGRESSION (MLR_WITHOUT PLOT) &SYSDATE9..PDF";
PROC REG DATA = &WAC_ENCD PLOTS(MAXPOINTS = 10000);
 TITLE "RUNNING ALL POSSIBLE REGRESSION WITH ALL PREDICTOR VARAIBLES";
 MODEL &TARGET_VAR = SEX AGE MARISTATUS EDUCATION CITIZEN HRSPERWEEK EMPTYPEMAIN WORKTYPE 
					JOBWEEKS WGWK1ST;
RUN;
QUIT;
ODS PDF CLOSE;

* MULTIVARIATE LINEAR REGRESSION;
ODS PDF FILE = "&DIR_RESULT.\MULTIVARIATE LINEAR REGRESSION (MLR_WITH PLOT) &SYSDATE9..PDF";
PROC REG DATA = &WAC_ENCD PLOTS(ONLY) = (RSQUARE ADJRSQ CP);
 TITLE "GENERATING PLOTS OF R-SQUARED, ADJUSTED RSQUARE AND CP";
 MODEL &TARGET_VAR = &INDE_VAR. / SELECTION = RSQUARE ADJRSQ CP; 
RUN;
QUIT;
ODS PDF CLOSE;

* MULTIVARIATE LINEAR REGRESSION;
ODS PDF FILE = "&DIR_RESULT.\MULTIVARIATE LINEAR REGRESSION (AUTOMATED MODEL SELECTION) &SYSDATE9..PDF";
PROC REG DATA = &WAC_ENCD PLOTS(MAXPOINTS = 10000);
 TITLE "FORWARD, BACKWARD, AND STEPWISE SELECTION METHODS";
 MODEL &TARGET_VAR = &INDE_VAR. / SELECTION = FORWARD; 
 MODEL &TARGET_VAR = &INDE_VAR. / SELECTION = BACKWARD; 
 MODEL &TARGET_VAR = &INDE_VAR. / SELECTION = STEPWISE; 
RUN;
QUIT;
ODS PDF CLOSE;


*=======================================================================================;

%LET CENSUS_M = RIMA.CENSUSM;	/*DATASET WITH LESSER NUMBER OF CLASSES FOR CATEGORICAL VARIABLES*/
PROC SQL;
	CREATE TABLE &CENSUS_M. AS
		SELECT 	PEARN99 AS PEARN LABEL '2004 PERSONAL WAGE EARNINGS', 
				Q2P17,
				CASE 
					WHEN Q2P17 LE 14 THEN "No Degree"
					WHEN Q2P17 LE 17 THEN "Bachelor's Degree"
					WHEN Q2P17 LE 19 THEN "Master's Degree"
					ELSE "Doctorate Degree"
				END AS EDUCATION
		FROM &DSC. 
		WHERE AGE GE 15;
QUIT;

* PEARN VS EDUCATION CHI-SQUARE-------------------------;
%LET TARVAR = PEARN;
%LET INDVAR = EDUCATION;

PROC SORT DATA = &CENSUS_M OUT = RIMA.CENTMP;
	BY &TARVAR.; 
RUN;

PROC FREQ DATA = RIMA.CENTMP;
	BY &TARVAR.;
	TABLE &INDVAR. / OUT = RIMA.CENTMPFREQ; 
	FORMAT  &TARVAR. PRN_GRP_FMT.;
RUN;

PROC SQL;
	ALTER TABLE RIMA.CENTMPFREQ
	ADD PP NUM(8);
QUIT;

PROC SQL;
	UPDATE RIMA.CENTMPFREQ
	SET PP = PERCENT/100.0;
QUIT;

/* PROC PRINT DATA = RIMA.CENTMPFREQ(OBS=24);RUN; */
ODS GRAPHICS / NOBORDER RESET WIDTH = 12in HEIGHT = 5.5in;
PROC SGPLOT DATA = RIMA.CENTMPFREQ NOWALL NOBORDER DATTRMAP = RIMA.EDUMAP;
	TITLE J = CENTER HEIGHT = 12pt COLOR = WHITE BCOLOR= DEEPSKYBLUE 
		"RELATIONSHIP BETWEEN " COLOR = BLUE "%UPCASE(&TARVAR.) " HEIGHT = 12pt COLOR = WHITE " AND " COLOR = BLUE "%UPCASE(&INDVAR.)";
	STYLEATTRS BACKCOLOR = DEEPSKYBLUE ;

	YAXIS VALUEATTRS = (COLOR= BLACK FAMILY = GRAMAND SIZE = 12 WEIGHT = BOLD)
			LABELATTRS = (COLOR= BLACK FAMILY = GRAMAND SIZE = 12 WEIGHT = BOLD)
			DISPLAY = (NOTICKS  NOLINE NOVALUES)					
			LABEL = "PERCENT OF WAGE EARNINGS FREQUENCY";

	XAXIS VALUEATTRS = (COLOR= BLACK FAMILY = GRAMAND SIZE = 12 WEIGHT = BOLD)
		  	DISPLAY = (NOTICKS NOLABEL NOLINE)
			DISCRETEORDER = DATA;
	FORMAT PP PERCENT10.2;
	VBAR &TARVAR. / RESPONSE = PP GROUP=&INDVAR. GROUPDISPLAY = STACK
					DATALABEL DATALABELATTRS = (SIZE = 11 WEIGHT = BOLD)
					SEGLABEL SEGLABELATTRS = (SIZE = 8 )
					ATTRID = MYID;
	KEYLEGEND / LOCATION = OUTSIDE POSITION = RIGHT ACROSS = 1 NOBORDER;
	FORMAT &TARVAR. PRN_GRP_FMT. ;
RUN;
QUIT;	

DATA RIMA.EDUMAP;
RETAIN ID "MYID";
INPUT VALUE $ 1-17 FILLCOLOR $ 17-30;
cards;
No Degree          RED

Bachelor's Degree  GREEN

Master's Degree    YELLOW
Doctorate Degree   MARROWN
;
RUN;

proc sgplot data=shoes dattrmap=attrmap;

vbar product / response=sales group=region groupdisplay=stack stat=sum attrid=myid;

run;	