clear
///////////////////////////////////////////////////////
//  simpson1_3.sce
//
//  Este programa apróxima la integral de una función
//  (F(x) = 1 - (%e ^ (-x))) usando el método de 
//  Simpson 1 / 3
//
//   José Elías Garza Vázquez
//   Andrés Alam Sánchez Torres
//   04 / Feb / 20    version 1.0
//////////////////////////////////////////////////////


//////////////////////////////////////////////////////
//  F
//
//  Función que evalua un valor de x en 1 - (%e ^ (-x))
// 
//   Parametros:
//      dX      valor de x en el que se evalúa la función
// 
//   Regresa:
//     dY       valor calculado de la función
/////////////////////////////////////////////////////
function dY = F(dX)
    dY = 1 - (%e ^ (-dX))
end

//////////////////////////////////////////////////////
//  Simpson
//
//  Funcion que aproxima el área debajo de una curva
//  generada por una función F(x) (integral) a través
//  del método de Simpson 1 / 3
// 
//   Parametros:
//      dMin     mínimo del rango a integrar
//      dMax     máximo del rango a integrar
//      iN       es el número de intervalos o segmentos
//               a usar para calcular el área
//   Regresa:
//     dArea     es el área aproximada
/////////////////////////////////////////////////////
function dArea = Simpson(dMin, dMax, iN)
    // Suma para acumular el valor del numerador en la 
    // fórmula de Simpson
    dSum = F(dMin) + F(dMax)

    // Calcula tamaño de cada segmento para iterar por 
    // cada Xi
    dH = (dMax - dMin) / iN

    // Ciclo para calcular las sumas del numerador
    for i = 1 : iN - 1
        if modulo(i, 2) == 0 then
            dSum = dSum + 2 * F(dH * i + dMin)
        else
            dSum = dSum + 4 * F(dH * i + dMin)
        end
    end

    // Se calcula por completo el área
    dArea = dSum * (dMax - dMin) / (3 * iN)
endfunction


///////// Programa Principal

// Se pide el rango de integración
dMin = input('Introduce el minimo del rango a integrar : ')
dMax = input('Introduce el maximo del rango a integrar : ')

// Validación del rango (mínimo es menor o igual al máximo)
while dMin > dMax
    disp('Error: el minimimo del rango es mayor al maximo.')
    dMin = input('Introduce el minimo del rango a integrar : ')
    dMax = input('Introduce el maximo del rango a integrar : ')
end

// Se pide el número de intervalos
iN = input('Introduce el numero de intervalos')

// Validación del número de intervalos (par y positivo)
while iN < 0 && modulo(iN, 2) ~= 0
    disp('Error: el numero de intervalos debe ser par y positivo.')
    iN = input('Introduce el numero de intervalos')
end

// Se despliegan resultados
disp('La integral aproximada es : ')
disp(Simpson(dMin,dMax,iN))
