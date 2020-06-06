///////////////////////////////////////////////////////
//  final.sce
//
//  Este programa calcula las regresiones lineal, cuadrática,
//  exponencial y potencial para un conjunto de pares coordenados,
//  calcula sus errores cuadrados y en base a estos escoge la mejor
//  regresión  
//
//   José Elías Garza Vázquez
//   Andrés Alam Sánchez Torres
//   04 / Feb / 20    version 1.0
//////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//  regresionLineal
//
//  Funcion que calcula los coeficientes de una ecuacion
//  de primer grado por medio de sus formulas de regresión
//  aplicadas a un conjunto de pares coordenados contenidos
//  por una matriz.
//
//   Parametros:
//     pares     es la matriz que contiene a los pares 
//               coordenados
//   Regresa:
//  coeficientes  es un vector que contiene los 2
//                coeficientes a0 y a1 de la ecuación. 
//
/////////////////////////////////////////////////////
function coeficientes = regresionLineal(pares)
    // Obtengo el numero de datos
    n = size(pares)(1)   
    // Obtengo la sumatoria de todas las x 
    xSum = sum(pares(:, 1))
    // Obtengo la sumatoria de todas las y
    ySum = sum(pares(:, 2))
    // Elaboro ciclo para obtener la sumatoria de todos los productos x*y
    xySum = 0
    for i = 1 : n
        xySum = xySum + pares(i, 1)*pares(i, 2)
    end
    // Obtengo la sumatoria de todas las x elevadas al cuadrado
    x2Sum = sum(pares(:, 1)^2)
    // Obtengo el promedio de x
    meanX = mean(pares(:, 1))
    // Obtengo el promedio de y
    meanY = mean(pares(:, 2))
    // Uso la ecuacion para calcular el primer coeficiente con los datos anteriores
    a1 = (n*xySum - xSum*ySum)/(n*x2Sum - (xSum)^2)
    // Uso la ecuacion para calcular el segundo coeficiente con los datos anteriores y el primer coeficiente
    a0 = meanY - a1*meanX
    // Genero el vector con los dos coeficientes de la ecuacion
    coeficientes = [a0, a1]
endfunction

//////////////////////////////////////////////////////
//  regresionCuadratica
//
//  Funcion que calcula los coeficientes de una ecuacion 
//  cuadrática utilizando una matriz para el sistema de 
//  ecuaciones y el método de Gauss-Jordan, dada una matriz
//  con los pares coordenados a usar y el número de pares
//
//   Parametros:
//     pares   es la matriz que contiene los pares 
//             coordenados para la regresion
//   Regresa:
// coeficientes  un vector que contiene a los coeficientes 
//               a0, a1 y a2 de la ecuacion  
/////////////////////////////////////////////////////
function coeficientes = regresionCuadratica(pares)
    // Obtengo el numero de datos
    n = size(pares)(1)
    // Obtengo la sumatoria de todas las x
    xSum = sum(pares(:, 1))
    // Obtengo la sumatoria de todas las y
    ySum = sum(pares(:, 2))
    // Elaboro ciclo para obtener la sumatoria de todos los productos x*y
    xySum = 0
    for i = 1 : n
        xySum = xySum + pares(i, 1)*pares(i, 2)
    end
    // Obtengo la sumatoria de todas las x elevadas al cuadrado 
    x2Sum = sum(pares(:, 1)^2)
    // Obtengo la sumatoria de todas las x elevadas al cubo
    x3Sum = sum(pares(:, 1)^3)
    // Obtengo la sumatoria de todas las x elevadas a 4
    x4Sum = sum(pares(:, 1)^4)
    // Elaboro ciclo para obtener la sumatoria de todos los productos (x^2)*y
    x2ySum = 0
    for i = 1 : n
        x2ySum = x2ySum + (pares(i, 1)^2)*pares(i, 2)
    end
    // Genero una matriz aumentada del sistema de ecuaciones que se forma con los datos anteriores
    sistema = [n,     xSum,  x2Sum, ySum;
    xSum,  x2Sum, x3Sum, xySum;
    x2Sum, x3Sum, x4Sum, x2ySum]
    // Elaboro ciclo para resolver el sistema con Gauss-Jordan
    for k = 1 : 3
        // Para cada fila hago que el elemento de la diagonal principal sea 1
        sistema(k, :) = sistema(k, :)/sistema(k, k)
        for i = 1 : 3
            // Para cada fila que no sea la del elemento de la diagonal principal ...
            if i ~= k
                // ... sumo la fila del elemento de la diagonal principal, multiplicada por un número para hacer un 0 bajo el elemento
                sistema(i, :) = sistema(i, :) + sistema(k, :)*(-sistema(i, k))
            end
        end
    end
    // Tomo las soluciones de la matriz después de tratada con Gauss-Jordan
    coeficientes = sistema(:, 4)

endfunction

//////////////////////////////////////////////////////
//  regresionExponencial
//
//  Funcion que calcula los coeficientes de un modelo 
//  exponencial utilizando una matriz para el sistema de 
//  ecuaciones y el método de Gauss-Jordan, dada una matriz
//  con los pares coordenados a usar.
//
//   Parametros:
//     pares   es la matriz que contiene los pares 
//             coordenados para la regresion
//   Regresa:
// coeficientes  un vector que contiene a los coeficientes 
//               a0, a1 de la ecuacion  
/////////////////////////////////////////////////////
function coeficientes = regresionExponencial(pares)
    // Obtengo el numero de datos
    n = size(pares)(1)
    // Obtengo la sumatoria de todas las x
    xSum = sum(pares(:, 1))
    // Obtengo la sumatoria de todas los lny
    lnySum = sum(log(pares(:, 2)))
    // Obtengo la sumatoria de todas las x elevadas al cuadrado 
    x2Sum = sum(pares(:, 1)^2)
    // Elaboro ciclo para obtener la sumatoria de todos los productos x*lny
    xlnySum = 0
    for i = 1 : n
        xlnySum = xlnySum + pares(i, 1)*log(pares(i, 2))
    end
    // Genero una matriz aumentada del sistema de ecuaciones que se forma con los datos anteriores
    sistema = [n,    xSum,  lnySum;
    xSum, x2Sum, xlnySum]
    // Elaboro ciclo para resolver el sistema con Gauss-Jordan
    for k = 1 : 2
        // Para cada fila hago que el elemento de la diagonal principal sea 1
        sistema(k, :) = sistema(k, :)/sistema(k, k)
        for i = 1 : 2
            // Para cada fila que no sea la del elemento de la diagonal principal ...
            if i ~= k
                // ... sumo la fila del elemento de la diagonal principal, multiplicada por un número para hacer un 0 bajo el elemento
                sistema(i, :) = sistema(i, :) + sistema(k, :)*(-sistema(i, k))
            end
        end
    end
    // Tomo las soluciones de la matriz después de tratada con Gauss-Jordan
    coeficientes = sistema(:, 3)

endfunction

//////////////////////////////////////////////////////
//  regresionPotencia
//
//  Funcion que calcula los coeficientes de un modelo 
//  utilizando una matriz para el sistema de 
//  ecuaciones y el método de Gauss-Jordan, dada una matriz
//  con los pares coordenados a usar.
//
//   Parametros:
//     pares   es la matriz que contiene los pares 
//             coordenados para la regresion
//   Regresa:
// coeficientes  un vector que contiene a los coeficientes 
//               a0 y a1 del modelo.  
/////////////////////////////////////////////////////
function coeficientes = regresionPotencia(pares)
    // Obtengo el numero de datos
    n = size(pares)(1)
    // Obtengo la sumatoria de todos los lnx
    lnxSum = sum(log(pares(:, 1)))
    // Obtengo la sumatoria de todos los lny
    lnySum = sum(log(pares(:, 2)))
    // Obtengo la sumatoria de todos los lnx elevados al cuadrado 
    ln2xSum = sum(log(pares(:, 1))^2)
    // Elaboro ciclo para obtener la sumatoria de todos los productos lnx*lny
    lnxlnySum = 0
    for i = 1 : n
        lnxlnySum = lnxlnySum + log(pares(i, 1))*log(pares(i, 2))
    end
    // Genero una matriz aumentada del sistema de ecuaciones que se forma con los datos anteriores
    sistema = [n,    lnxSum,  lnySum;
    lnxSum, ln2xSum, lnxlnySum]
    // Elaboro ciclo para resolver el sistema con Gauss-Jordan
    for k = 1 : 2
        // Para cada fila hago que el elemento de la diagonal principal sea 1
        sistema(k, :) = sistema(k, :)/sistema(k, k)
        for i = 1 : 2
            // Para cada fila que no sea la del elemento de la diagonal principal ...
            if i ~= k
                // ... sumo la fila del elemento de la diagonal principal, multiplicada por un número para hacer un 0 bajo el elemento
                sistema(i, :) = sistema(i, :) + sistema(k, :)*(-sistema(i, k))
            end
        end
    end
    // Tomo las soluciones de la matriz después de tratada con Gauss-Jordan
    coeficientes = sistema(:, 3)

endfunction

//////////////////////////////////////////////////////
//  SetLineal
//
//  Funcion que calcula el conjunto de predicciones 
//  de un modelo lineal, dado un conjunto de pares
//  coordenados.
//
//   Parametros:
//     pares   es la matriz que contiene los pares 
//             coordenados para la regresion
//   Regresa:
//     dYSet   es el vector que contiene las 
//             predicciones del modelo para las
//             x del set dado  
/////////////////////////////////////////////////////
function dYSet = SetLineal(pares)
    // se obtienen los coeficientes del modelo
    coeficientes = regresionLineal(pares)
    // elaboro ciclo calcular el vector de predicciones
    for i = 1 : size(pares)(1)
        // evaluo el modelo en las x de los pares coordenados dados
        dYSet(i) = coeficientes(1) + coeficientes(2) * pares(i, 1)
    end 
endfunction

//////////////////////////////////////////////////////
//  SetCuadratico
//
//  Funcion que calcula el conjunto de predicciones 
//  de un modelo cuadratico, dado un conjunto de pares
//  coordenados.
//
//   Parametros:
//     pares   es la matriz que contiene los pares 
//             coordenados para la regresion
//   Regresa:
//     dYSet   es el vector que contiene las 
//             predicciones del modelo para las
//             x del set dado  
/////////////////////////////////////////////////////
function dYSet = SetCuadratico(pares)
    // se obtienen los coeficientes del modelo
    coeficientes = regresionCuadratica(pares)
    // elaboro ciclo calcular el vector de predicciones
    for i = 1 : size(pares)(1)
        // evaluo el modelo en las x de los pares coordenados dados
        dYSet(i) = coeficientes(1) + coeficientes(2) * pares(i, 1) + coeficientes(3) * pares(i, 1) ^ 2
    end 
endfunction

//////////////////////////////////////////////////////
//  SetExponencial
//
//  Funcion que calcula el conjunto de predicciones 
//  de un modelo exponencial, dado un conjunto de pares
//  coordenados.
//
//   Parametros:
//     pares   es la matriz que contiene los pares 
//             coordenados para la regresion
//   Regresa:
//     dYSet   es el vector que contiene las 
//             predicciones del modelo para las
//             x del set dado  
/////////////////////////////////////////////////////
function dYSet = SetExponencial(pares)
    // se obtienen los coeficientes del modelo
    coeficientes = regresionExponencial(pares)
    // elaboro ciclo calcular el vector de predicciones
    for i = 1 : size(pares)(1)
        // evaluo el modelo en las x de los pares coordenados dados
        dYSet(i) = (%e ^ coeficientes(1)) * %e ^ (coeficientes(2) * pares(i, 1))
    end 
endfunction

//////////////////////////////////////////////////////
//  SetPotencial
//
//  Funcion que calcula el conjunto de predicciones 
//  de un modelo potencial, dado un conjunto de pares
//  coordenados.
//
//   Parametros:
//     pares   es la matriz que contiene los pares 
//             coordenados para la regresion
//   Regresa:
//     dYSet   es el vector que contiene las 
//             predicciones del modelo para las
//             x del set dado  
/////////////////////////////////////////////////////
function dYSet = SetPotencial(pares)
    // se obtienen los coeficientes del modelo
    coeficientes = regresionPotencia(pares)
    // elaboro ciclo calcular el vector de predicciones
    for i = 1 : size(pares)(1)
        // evaluo el modelo en las x de los pares coordenados dados
        dYSet(i) = (%e ^ coeficientes(1)) * (pares(i, 1) ^ coeficientes(2))
    end 
endfunction

//////////////////////////////////////////////////////
//  r2
//
//  Funcion que calcula el error cuadrado de las 
//  predicciones obtenidas por un modelo 
//
//   Parametros:
//     dYSet       es el vector que contiene las 
//                 predicciones del modelo 
//   dRealSet      es el vector que contiene los 
//                 valore reales para cada x dada
//
//   Regresa:
// errorCuadrado   es el error cuadrado de las 
//                 predicciones de los modelos con 
//                 respecto a los valores reales 
/////////////////////////////////////////////////////
function errorCuadrado = r2(dYSet, dRealYSet)
    n = size(dRealYSet)(1)
    meanY = mean(dRealYSet)
    dNum = 0
    dDenum = 0
    for i = 1 : n
        dNum = dNum + (dRealYSet(i) - dYSet(i)) ^ 2
        dDenum = dDenum + (dRealYSet(i) - meanY) ^ 2
    end
    errorCuadrado = 1 - dNum / dDenum
endfunction

///////// Programa Principal

// pido los valores
dXSet = input('Conjunto de valores de x: ')

dYSet = input('Conjunto de valores de y: ')

dX = input('Para que valor desea estimar? ')

// extraigo los conjuntos de 'x' y 'y'
dPares(:, 1) = dXSet
dPares(:, 2) = dYSet

// obtengo los coeficientes de cada modelo
dCoefLin = regresionLineal(dPares)
dCoefCuad = regresionCuadratica(dPares)
dCoefExpo = regresionExponencial(dPares)
dCoefPot = regresionPotencia(dPares)

// se precalculan los valores de r^2 para cada modelo
dR2Lin = r2(SetLineal(dPares), dPares(:, 2))
dR2Cuad = r2(SetCuadratico(dPares), dPares(:, 2))
dR2Expo = r2(SetExponencial(dPares), dPares(:, 2))
dR2Pot = r2(SetPotencial(dPares), dPares(:, 2))

// despliego los modelos y sus errores cuadrados
disp('Modelos:')
disp('Lineal : y = ' + string(dCoefLin(1)) + ' + (' + string(dCoefLin(2)) + ') * x, r2 = ' + string(dR2Lin))
disp('Cuadratica : y = ' + string(dCoefCuad(1)) + ' + (' + string(dCoefCuad(2)) + ') * x + (' + string(dCoefCuad(3)) + ') * x^2 , r2 = ' + string(dR2Cuad))
disp('Exponencial : y = ' + string(%e^dCoefExpo(1)) + ' * e ^ (' + string(dCoefExpo(2)) + ') , r2 = ' + string(dR2Expo))
disp('Potencial : y = ' + string(%e^dCoefPot(1)) + ' * x ^ (' + string(dCoefPot(2)) + ') , r2 = ' + string(dR2Pot))

// se comparan los valores de r^2 para saber cual es el mejor modelo
if (dR2Lin > dR2Cuad & dR2Lin > dR2Expo & dR2Lin > dR2Pot) then
    dY = dCoefLin(1) + dCoefLin(2) * dX
    disp('El mejor modelo es el lineal con r2 = ' + string(dR2Lin))
    disp('Usando el mejor modelo el valor estimado para x = dX es: ' + string(dY))
elseif (dR2Cuad > dR2Lin & dR2Cuad > dR2Expo & dR2Cuad > dR2Pot) then
    dY = dCoefCuad(1) + dCoefCuad(2) * dX + dCoefCuad(3) * dX ^ 2
    disp('El mejor modelo es el cuadratico con r2 = ' + string(dR2Cuad))
    disp('Usando el mejor modelo el valor estimado para x = dX es: ' + string(dY))
elseif (dR2Expo > dR2Lin & dR2Expo > dR2Cuad & dR2Expo > dR2Pot) then
    dY = (%e ^ dCoefExpo(1)) * %e ^ (dCoefExpo(2) * dX)
    disp('El mejor modelo es el exponencial con r2 = ' + string(dR2Expo))
    disp('Usando el mejor modelo el valor estimado para x = dX es: ' + string(dY))
else
    dY = (%e ^ dCoefPot(1)) * dX ^ dCoefPot(2)
    disp('El mejor modelo es el potencial con r2 = ' + string(dR2Pot))
    disp('Usando el mejor modelo el valor estimado para x = dX es: ' + string(dY))
end




// [1960, 1970, 1990, 1995, 2000, 2005, 2010]
// [580.6, 1194.6, 1650.04, 1633.05, 1646.18, 1600.89, 1495.18]
