clear
///////////////////////////////////////////////////////
//  interpolacion_lagrange.sce
//
//  Este programa aproxima la evaluación de ln x por
//  medio de la interpolación con el método de Lagrange 
//  dada una x y una lista de pares coordenados.
//
//   José Elías Garza Vázquez
//   Andrés Alam Sánchez Torres
//   04 / Feb / 20    version 1.0
//////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//  fn
//
//  Funcion que aproxima f(x) = ln x en un punto dada 
//  una x y una lista de pares coordenados, con el 
//  método de interpolación de Lagrange.
//
//   Parametros:
//      mat     es la matriz que contiene todos los pares
//              coordenados
//       x      es el valor de x para evaluar
//   Regresa:
//    summation     es el valor aproximado de ln x
//                  para la x dada
/////////////////////////////////////////////////////
function summation = fn(mat, x)
    // inicializo la sumatoria 
    summation = 0
    // obtengo número de pares coordenados
    n = size(mat)(1)
    // elaboro ciclo para calcular sumatoria
    for i = 1 : n
        // calculo el siguiente término a sumar
        nextTerm = li(n, i, x, mat)*mat(i, 2)
        // sumo el siguiente término
        summation = summation + nextTerm 
    end
endfunction

//////////////////////////////////////////////////////
//  li
//
//  Funcion que calcula el siguiente factor a multilpicar
//  por el siguiente valor de ln x dado por la matriz, para 
//  sumar el producto en la función fn.
//
//   Parametros:
//      n     es la cantidad de pares coordenados dados
//      i     es el índice actual en la sumatoria en fn
//      x     es el valor en x que se desea aproximar 
//            para ln x
//     mat    es el conjunto de todos los pares coordenados
//   Regresa:
//   product  es el siguiente factor a multiplicar en 
//            la sumatoria hecha en fn 
/////////////////////////////////////////////////////
function product = li(n, i, x, mat)
    // inicializo el productorio
    product = 1
    // elaboro ciclo para calcular productorio
    for j = 1 : n
        // si el índice actual es distinto al actual de la sumatoria en fn ...
        if j ~= i
            // ... calculo el siguiente factor para el productorio 
            nextFactor = (x - mat(j, 1))/(mat(i, 1) - mat(j, 1))
            // multiplico el producto actual por el factor
            product = product*nextFactor
        end    
    end
endfunction

/////// Programa Principal

// pido los valores

// inicializo el valor de x a evaluar
x = 0
// elaboro ciclo para recibir x dentro del dominio de ln x
while(x > 0)
    // pido x de nuevo si el valor está fuera del dominio de ln x
    x = input("Inserte un valor de x para aproximar ln x")
end

// pido una matriz con los pares coordenados
pares = input("Inserte una lista de pares coordenados" + ascii(10) + "Ej: [1, 2.41; 4, 4.234; 2, 3]")


// Se despliega la evaluación de ln x aproximada
disp(fn(pares, 2))         
