$title Citrus Cultivation Bioeconomic Model - Variables
Variable
    v_cropAgeYear(hh,soil,age,int,y) 'Age of trees per year'
    v_cropAgeclass(soil, ageclass, y) 'area cultivated per soil type age class and year (ha)'
    v_harvestAgeclass(soil, ageclass, y) 'area harvested (ha)'
    v_prodQuant(c, y) 'lemon production (tons)'
    process(task, y) 'process level (ha)'
    v_oactCost(y) 'process cost (USD)'
    v_oactSrev(y) 'sales revenue (USD)'
    v_oactIncome 'total benefit (discounted cost)'
      ;

Positive Variable v_cropAgeYear, v_cropAgeclass, v_harvestAgeclass, v_prodQuant, process;
*v0_cactLev(hh,soil,int)