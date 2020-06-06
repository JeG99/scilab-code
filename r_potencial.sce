clear
///////////////////////////////////////////////////////
//  r_potencia.sce
//
//  Este programa obtiene los coeficientes de un modelo
//  por medio de regresión potencia con un sistema de 
//  ecuaciones, dado un conjunto de pares coordenados.
//  
//   José Elías   Garza Vázquez
//   23 / 01  / 20    version 1.0
//////////////////////////////////////////////////////

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
A = regresionPotencia(data)
disp("a0 = " + string(A(1)) + ", a1 = " + string(A(2))) 
