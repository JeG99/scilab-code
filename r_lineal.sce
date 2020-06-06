clear 
///////////////////////////////////////////////////////
//  r_lineal.sce
//
//  Este programa obtiene los coefientes de una ecuacion 
//  lineal por medio de sus fórmulas de regresión, dado
//  un conjunto de pares coordenados.
//  
//   José Elías   Garza Vázquez
//   22 / 01  / 20    version 1.0
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

/////// Programa Principal

// pido los valores
n = input("Inserte el número de pares coordenados que desea utilizar: ")
// Creo una matriz con el número de espacios que el usuario pidio
data = zeros(n, 2)
// Elaboro ciclo para pedir los pares
for i = 1 : n
    for j = 1 : 2
        if(j == 1)
            data(i, j) = input("inserta x: ")
        else
            data(i, j) = input("inserta y: ")
        end
    end
end

//despliego los coeficientes resultantes de la regresion
A = regresionLineal(data)
disp("a0 = " + string(A(1)) + ", a1 = " + string(A(2))) 
