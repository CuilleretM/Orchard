$title Citrus Cultivation Bioeconomic Model - Equations
Equation
    E_CROPAREA(hh,soil,int,y)  'Cultivation area'
    E_CROPPRD(c,y)   'production per crops'
    E_PROCESSCOST(y)        'Process cost'
    E_BENEFIT           'Total benefit'
    E_TREEAGE(hh,soil,age,int,y)   'age of the trees by soiltype'
;

E_CROPAREA(hh,soil,int,y)..
    sum(age, v_cropAgeYear(hh,soil,age,int,y)) =l= v0_cactLev(hh,soil,int);
*E_CROPAREA(hh,soil,int,y)..
*    sum(((age,int), v_cropAgeYear(hh,soil,age,int,y)) =l= v0_cactLev(hh,soil);
E_TREEAGE(hh,soil,age,int,y)..
    v_cropAgeYear(hh,soil,age,int,y) =l= (v0_cactAge(soil, age)* v0_cactLev(hh,soil,int))$(ord(y) = 1)+v_cropAgeYear(hh,soil,age-1,int,y-1)$(ord(y) > 1);

E_CROPPRD(c,y)..
    v_prodQuant(c,y) =l=
        sum((hh, soil, int),
            v0_cactYld(soil, "lemons", "young") * sum(age$(ord(age) < harvestingAge), v_cropAgeYear(hh, soil, age, int, y)) +
            v0_cactYld(soil, "lemons", "adult") * sum(age$(ord(age) >= harvestingAge and ord(age) < oldAge), v_cropAgeYear(hh, soil, age, int, y)) +
            v0_cactYld(soil, "lemons", "old") * sum(age$(ord(age) >= oldAge), v_cropAgeYear(hh, soil, age, int, y)))  ;

E_PROCESSCOST(y)..
   v_oactCost(y) =e= sum((hh, soil, int),
                            p_taskLabor("planting") * sum(age$(ord(age) = 1), v_cropAgeYear(hh, soil, age, int, y)) +
                            p_taskLabor("harvesting") * sum(age$(ord(age) >= harvestingAge), v_cropAgeYear(hh, soil, age, int, y)) +
                            p_taskLabor("herbicide") * sum(age, v_cropAgeYear(hh, soil, age, int, y)) +
                            p_taskLabor("weeding") * sum(age, v_cropAgeYear(hh, soil, age, int, y)) +
                            p_taskLabor("grubbingup") * sum(age$(ord(age) = life), v_cropAgeYear(hh, soil, age, int, y))+
sum(age,p_inputcost(hh,"lemons",soil,int)*v_cropAgeYear(hh, soil, age, int, y)));


E_BENEFIT..
         v_oactIncome =e= sum(y, (sum(c, p_selPrice(c) * v_prodQuant(c,y)) - v_oactCost(y)) * (1 / (1 + rho)**ord(y)));

