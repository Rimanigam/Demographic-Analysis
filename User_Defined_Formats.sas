PROC FORMAT;
	VALUE $REGION_FMT '1' = "North Puget"
					  '2' = "West Balance"
					  '3' = "King"
					  '4' = "Puget Metro"
					  '5' = "Clark"
					  '6' = "East Balance"
					  '7' = "Spokane"
					  '8' = "Tri-cities";

	VALUE $BINARY_FMT	'0' = "NO"
						'1' = "YES";

	VALUE $SEX_FMT '1' = "MALE"
				  '2' = "FEMALE";

	VALUE $RACE_FMT	'1' = "White"
					'2' = "Black"
					'3' = "American Indian/Alaskan Native"
					'4' = "Native Hawaiian/Other PI"
					'5' = "Asian";

	VALUE $EMP_FMT  '1' = "Government"
					'2' = "Private company (for profit)"
					'3' = "Nonprofit organization"
					'4' = "Self-employed"
					'5' = "Working in the family business"
					OTHER = "MISSING";

	VALUE $NULL_FMT;

	VALUE $WORK_FMT	'11' = "Management"
					'13' = "Business and Financial"
					'15' = "Computer and Mathematical"
					'17' = "Architecture and Engineering"
					'19' = "Life, Physical, and Social Science"
					'21' = "Community and Social Service"
					'23' = "Legal"
					'25' = "Education, Training and Library"
					'27' = "Arts, Design, Entertainment, Sports, and Media"
					'29' = "Healthcare Practitioners &Technical"
					'31' = "Healthcare Support"
					'33' = "Protective Service"
					'35' = "Food Preparation & Serving Related"
					'37' = "Building & Grounds, Cleaning & Maintenance"
					'39' = "Personal Care and Service"
					'41' = "Sales and Related"
					'43' = "Office and Administrative Support"
					'45' = "Farming, Fishing, and Forestry"
					'47' = "Construction and Extraction"
					'49' = "Installation, Maintenance, & Repair"
					'51' = "Productions"
					'53' = "Transportation and Material Moving"
					'55' = "Military Specific";

		VALUE $AGECAT_FMT  '1' = "0 < AGE < 10"
					   	   '2' = "15 (*ESC*){Unicode '2264'x} AGE < 20"
						   '3' = "20 (*ESC*){Unicode '2264'x} AGE < 30"
						   '4' = "30 (*ESC*){Unicode '2264'x} AGE < 40"
						   '5' = "40 (*ESC*){Unicode '2264'x} AGE < 50"
						   '6' = "50 (*ESC*){Unicode '2264'x} AGE < 60"
						   '7' = "60 (*ESC*){Unicode '2264'x} AGE < 70"
						   '8' = "70 (*ESC*){Unicode '2264'x} AGE < 80"
						   '9' = "80 OR OVER";
	

	VALUE $MARISTA_FMT 	'1' = "Married"
						'2' = "Divorced"
						'3' = "Separated"
						'4' = "Widowed"
						'5' = "Never Married";

	VALUE $EDUCA_FMT  '10' = "Less than 9th grade"
					 '11' = "9th grade - 12th grade"
					 '12' = "High school grad"
					 '13' = "GED"
					 '14' = "Vocational certificate"
					 '15' = "Some college, no degree"
					 '16' = "Associate degree in college"
					 '17' = "Bachelor's degree"
					 '18' = "Master's degree"
					 '19' = "Professional school degree"
					 '20' = "Doctorate degree"
					 OTHER = "MISSING";
	
	VALUE $EDUCA_S_FMT  '10' - '14' = "No Degree"
					 '15' - '17' = "Bachelor's Degree"
					 '18' - '19' = "Master's degree"
					 '20' = "Doctorate degree";

	VALUE months 1 = "January"
				 2 = "February"
				 3 = "March"
				 4 = "April"
				 5 = "May"
				 6 = "June"
				 7 = "July"
				 8 = "August"
				 9 = "September"
				 10 = "October"
				 11 = "November"
				 12 = "December";

	VALUE racis 0 = "No more selected"
				1 = "White" 
				2 = "Black" 
				3 = "American Indian/Alaskan Native"
				4 = "Native Hawaiian/Other PI"
				5 = "Asian";

	VALUE impute 0 = "Not imputed"
				 1 = "Imputed";

	VALUE occu_aca 1 = "Occupational/Vocational"
				   2 = "Academic";

	VALUE country 	1 = 'Afghanistan'
					2 = 'Africa'
					3 = 'Argentina'
					5 = 'Australia'
					6 = 'Austria'
					7 = 'Bangladesh'
					8 = 'Byelorussia'
					9 = 'Belgium'
					10 = 'Belize'
					11 = 'Burma'
					12 = 'Bosnia'
					13 = 'Brazil'
					14 = 'Bulgaria'
					15 = 'Cambodia'
					16 = 'Canada'
					18 = 'Caribbean'
					20 = 'Chile'
					21 = 'China'
					22 = 'Colombia'
					23 = 'CostaRica'
					25 = 'Cuba'
					26 = 'Czechoslovakia'
					28 = 'Denmark'
					29 = 'Ecuador'
					31 = 'Egypt'
					32 = 'ElSalvador'
					33 = 'Eritrea'
					34 = 'Estonia'
					35 = 'Ethiopia'
					36 = 'Fiji'
					37 = 'Finland'
					38 = 'France'
					39 = 'Gambia'
					40 = 'Germany'
					41 = 'Ghana'
					42 = 'Greece'
					44 = 'Guatemala'
					45 = 'Guinea'
					46 = 'Holland'
					47 = 'Honduras'
					48 = 'HongKong'
					49 = 'Hungary'
					50 = 'Iceland'
					51 = 'India'
					52 = 'Indonesia'
					53 = 'Iran'
					54 = 'Iraq'
					55 = 'Ireland'
					56 = 'Israel'
					57 = 'Italy'
					58 = 'Jamaica'
					59 = 'Japan'
					60 = 'Kazakhstan'
					61 = 'Korea'
					62 = 'Laos'
					63 = 'Latvia'
					64 = 'Lebanon'
					65 = 'Malaysia'
					66 = 'Mexico'
					68 = 'Micronesia'
					69 = 'Netherlands'
					70 = 'Nicaragua'
					71 = 'Nigeria'
					72 = 'Norway'
					73 = 'Pakistan'
					74 = 'Palestine'
					75 = 'Panama'
					77 = 'Peru'
					78 = 'Philippines'
					79 = 'Poland'
					80 = 'Portugal'
					81 = 'Romania'
					82 = 'Russia'
					83 = 'Samoa'
					84 = 'SaudiArabia'
					85 = 'Senegal'
					86 = 'Singapore'
					87 = 'Somalia'
					88 = 'SouthAfrica'
					89 = 'Spain'
					90 = 'Sweden'
					91 = 'Switzerland'
					93 = 'Taiwan'
					94 = 'Thailand'
					95 = 'Tonga'
					96 = 'Turkey'
					97 = 'Uganda'
					98 = 'Ukraine'
					99 = 'UnitedKingdom'
					100 = 'UnitedStates'
					101 = 'Venezuela'
					102 = 'Vietnam'
					103 = 'WestIndies'
					104 = 'WesternSamoa'
					105 = 'Yugoslavia'
					107 = 'Zimbabwe'
					108 = 'Guam'
					109 = 'Algeria'
					110 = 'AmericanSamoa'
					111 = 'Bermuda'
					112 = 'Croatia'
					113 = 'CzechRepublic'
					114 = 'DominicanRepublic'
					115 = 'EastAfrica'
					116 = 'Europe'
					117 = 'Guyana'
					118 = 'Kenya'
					119 = 'Kyrgyzstan'
					120 = 'Kuwait'
					121 = 'Libya'
					122 = 'Lithuania'
					123 = 'Malta'
					124 = 'Morocco'
					125 = 'Namibia'
					126 = 'Nepal'
					127 = 'NewZealand'
					128 = 'Scotland'
					129 = 'Slovakia'
					130 = 'Sudan'
					131 = 'Syria'
					132 = 'Tanzania'
					133 = 'Trinidad'
					134 = 'WestAfrica'
					135 = 'EastGermany'
					136 = 'SouthKorea'
					137 = 'Asia'
					138 = 'Haiti'
					139 = 'NorthAfrica'
					140 = 'SriLanka'
					141 = 'PapuaNewGuinea'
					142 = 'Azerbaijan'
					143 = 'SouthAmerica'
					144 = 'Luxembourg'
					145 = 'PuertoRico'
					146 = 'CentralAmerica'
					147 = 'Macao'
					148 = 'Grenada';
	VALUE place1year 1 = "Another Washington county"
					 2 = "Another state"
					 3 = "Another country"
					 4 = "Same Washington county";

	VALUE Q2P27_fmt 1 = "Job relocation"
					2 = "Closer to family"
					3 = "Better job opportunity"
					4 = "Like the climate, environment, recreation"
					5 = "Better social services/benefits"
					6 = "Other"
					7 = "School"
					8 = "Cost of living";

	VALUE Q3P1_fmt  1 = "One family house"
					2 = "A multi-unit complex"
					3 = "A mobile home or trailer"
					4 = "Manufactured home"
					5 = "Something else"
					6 = "Public housing";
	
	VALUE Q3P2_fmt  1 = "Own"
					2 = "Rent"
					3 = "Don't own and occupy without paying rent";

	VALUE Q3P2A_fmt 1 = "Own free and clear"
					2 = "Own with a mortgage or loan"
					3 = "Own with a government subsidy"
					4 = "Other";
	
	VALUE HHTYPE_fmt 1 = "Husband-wife family household"
					 2 = "Other family household"
					 3 = "Non-family household (2 or more persons)"
					 4 = "Single-person household";

	

	VALUE HHINCCAT_fmt  1 = "$0-$4,999"
						2 = "$5,000-$14,999"
						3 = "$15,000-$24,999"
						4 = "$25,000-$34,999"
						5 = "$35,000-$49,999"
						6 = "$50,000-$74,999"
						7 = "$75,000-$99,999"
						8 = "$100,000-$149,999"
						9 = "$150,000 and over";
	
	VALUE Q2P17_fmt	1 = "Less than 9th grade"
					2 = "9th grade - 12th grade (no high school diploma)"
					3 = "High school grad (with diploma)"
					4 = "GED"
					5 = "Vocational certificate"
					6 = "Some college, no degree"
					7 = "Associate degree in college"
					8 = "Bachelor degree"
					9 = "Master degree"
					10 = "Professional school degree"
					11 = "Doctorate degree";

	

	VALUE NUM_MEM	1 = "1 Member"
					2 = "2 Members"
					3 = "3 Members"
					4 = "4 Members"
					5 = "5 Members"
					6 = "6 Members"
					7 = "7 Members"
					8 = "8 Members"
					9 = "9 Members"
					10 = "10 Members"
					11 = "11 Members"
					12 = "12 Members";

	VALUE NUM_FMEM	1 = "1 Family"
					2 = "2 Families"
					3 = "3 Families"
					4 = "4 Families"
					5 = "5 Families"
					6 = "6 Families"
					7 = "7 Families"
					8 = "8 Families";

	VALUE Q4P25_fmt	1 = "Permanent"
					2 = "Temporary";
	
	VALUE $ARISTA_FMT	'1' = "Married"
						'2' = "Divorced"
						'3' = "Separated"
						'4' = "Widowed"
						'5' = "Never Married"
						OTHER = "MISSING";	
RUN;
