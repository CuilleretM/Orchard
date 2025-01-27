$title Citrus Cultivation Bioeconomic Model - Main

*$setglobal orcharddir  'C:\Users\cuilleret\Documents\gamsdir\projdir\Agroforestry'

* Load parameters and sets
$include "parameter_orchard2.gms "

* Definition of variables
$include "variables_orchard.gms "

* Definition equations
$include "equation_orchard.gms "

* Definition and solving of the model
$include "solvemodel_orchard.gms "

display v_oactIncome.l;