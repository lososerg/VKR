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

/* Checking how well are they connected*/

NONPAR CORR
  /VARIABLES=Q23 Q39reverseCoding
  /PRINT=BOTH TWOTAIL NOSIG
  /MISSING=PAIRWISE.
