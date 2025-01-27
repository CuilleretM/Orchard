$title Citrus Cultivation Bioeconomic Model - Parameters

*load data
*$setglobal orcharddir 'C:\Users\cuilleret\Documents\gamsdir\projdir\Agroforestry'
*LOAD SET
set  hh         'household'
    soil       'soil type'
    c          'crops'
    y          'time periods'
    hh         'household'
    soil       'soil type'
    c          'crops'
    task       'task'
    ageclass   'age classes'
    age        'age'
    int        'intensity'
    buypricep
    othcost
    ;
$onEmbeddedCode Connect:
- ExcelReader:
    file: sets_agroforestry.xlsx
    symbols:
      - {name: y,range: year!A4,columnDimension: 0,type: set}
- GAMSWriter:
    symbols: all  # GAMS 48

$offEmbeddedCode
Alias (y, yp);
*SCALAR SECTION
Scalar
    rho                'discount rate'
    life               'plant life (years)'
    harvestingAge 'age of first harvest (years)'
    oldAge 'age of reducing production (years)'
;

$onEmbeddedCode Connect:
- ExcelReader:
    file: par_agroforestry.xlsx
    symbols:
       - {name: harvestingAge,range: harvestingAge!B1,columnDimension: 0,rowDimension: 0}
       - {name: rho,range: rho!B1,columnDimension: 0,rowDimension: 0}
       - {name: life,range: life!B1,columnDimension: 0,rowDimension: 0}
       - {name: oldAge,range: oldAge!B1,columnDimension: 0,rowDimension: 0}
- GAMSWriter:
    symbols: all  # GAMS 48
$offEmbeddedCode

*PARAMETER SECTION
Parameter p_tasklabor(task<) 'task labor'
        v0_cactYld(soil<,c<, ageclass<) 'load data'
        p_selPrice(c)       'sales price (USD per ton)'
        p_buyPrice(buypricep<) 'buying price (USD per ton)'
        v0_cactLev(*,*,*)    'land available (ha)'
        p_inputcost(hh,c,soil,int)
        v0_cactAge(soil, age<) 'Age of trees'
        v0_cropCoef_raw(hh<,c,soil,int<,othcost<) 'load data'
;
$onEmbeddedCode Connect:
- ExcelReader:
    file: par_agroforestry.xlsx
    symbols:
      - {name: p_tasklabor,range: taskLabor!A2,columnDimension: 0,rowDimension: 1}
      - {name: p_buyprice,range: buyprice!A2,columnDimension: 0,rowDimension: 1}
      - {name: v0_cactYld, range: cactYld!A2, columnDimension: 0, rowDimension: 3}    
- GAMSWriter:
    symbols: all  # GAMS 48
$offEmbeddedCode

$onEmbeddedCode Connect:
- ExcelReader:
    file: par_agroforestry.xlsx
    symbols:
      - {name: p_selPrice,range: selprice!A2,columnDimension: 0,rowDimension: 1}
      - {name: v0_cactAge,range: cactAge!A2:C30,columnDimension: 0,rowDimension: 2,valueSubstitutions: { .nan: '' }}
      - {name: v0_cropCoef_raw,range: cact!A2,columnDimension: 1,rowDimension: 4}
- GAMSWriter:
    symbols:
      - name: p_selPrice
      - name: v0_cactAge
      - name: v0_cropCoef_raw
$offEmbeddedCode
v0_cactLev(hh,soil,int)=sum(c,v0_cropCoef_raw(hh,c,soil,int,"area_ha")) ;
p_inputcost(hh,c,soil,int)=v0_cropCoef_raw(hh,c,soil,int,"area_ha")*p_buyPrice("nitr_price_kg")+v0_cropCoef_raw(hh,c,soil,int,"phyto_cost_ha")+v0_cropCoef_raw(hh,c,soil,int,"other_cost_ha");
*+v0_cropCoef_raw(hh,c,soil,int,"plant_nbr_ha")*p_buyPrice("plant_price_nbr")

