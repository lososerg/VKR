SET UNICODE YES.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=Q39 Q23
  /ORDER=ANALYSIS.

/* recoding Q39 to make scales of both variables unidirected */
RECODE Q39 (1=5) (2=4) (3=3) (4=2) (5=1) (SYSMIS=SYSMIS) INTO Q39reverseCoding.
VARIABLE LABELS  Q39reverseCoding 'Предположим, Вы узнаете, что один из Ваших коллег сообщил в '+
    'службу внутренней безопасности о коррупции в вашем подраздел'.
EXECUTE.

FREQUENCIES VARIABLES=Q39reverseCoding
  /ORDER=ANALYSIS.

/* Checking how well are they connected Spearman and Kendall correlation coefficients*/

NONPAR CORR
  /VARIABLES=Q23 Q39reverseCoding
  /PRINT=BOTH TWOTAIL NOSIG
  /MISSING=PAIRWISE.

/* Saving standardized values of index vars*/

DATASET ACTIVATE DataSet1.
DESCRIPTIVES VARIABLES=Q39reverseCoding Q23
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX.

/* Meassuring correlation between standardized variables*/
CORRELATIONS
  /VARIABLES=ZQ39reverseCoding ZQ23
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
NONPAR CORR
  /VARIABLES=ZQ39reverseCoding ZQ23
  /PRINT=BOTH TWOTAIL NOSIG
  /MISSING=PAIRWISE.

/* Same results achieved as with instandardized data */
