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

/* Getting var distribution by couintry*/
SORT CASES  BY CNTRY.
SPLIT FILE LAYERED BY CNTRY.

FREQUENCIES VARIABLES=Q39reverseCoding Q23
  /ORDER=ANALYSIS.

/* Making Q23 less diverse*/
RECODE Q23 (0=1) (1=1) (2=1) (3=2) (4=2) (5=3) (6=3) (7=4) (8=4) (9=5) (10=5) (SYSMIS=SYSMIS) INTO 
    Q23_5scale.
VARIABLE LABELS  Q23_5scale 'В некоторых странах полиция и другие официальные органы согласны '+
    'идти навстречу тем, кто нарушает правила, и люди могут '.
EXECUTE.

/* Computing corr coef with reduced scalse of Q23 */

CORRELATIONS
  /VARIABLES=Q23_5scale Q39reverseCoding
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
NONPAR CORR
  /VARIABLES=Q23_5scale Q39reverseCoding
  /PRINT=BOTH TWOTAIL NOSIG
  /MISSING=PAIRWISE.

/* */

FREQUENCIES VARIABLES=Q23_5scale
  /ORDER=ANALYSIS.
