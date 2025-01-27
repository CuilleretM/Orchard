$title Citrus Cultivation Bioeconomic Model - Solve model
Model citrus_model / all /;
Solve citrus_model using nlp maximizing v_oactIncome;

* Display the specific variable value
* Display v_cropAgeYear.2;

* Display the specific value for v_cropAgeYear(clay,1,y01)
* Scalar value_v_cropAgeYear_clay1_y02;
