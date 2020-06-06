clear
///////////////////////////////////////////////////////
//  maclaurin_cos.sce
//
//  Este programa aproxima valores de la función coseno
//  usando series de Maclaurin pidiendo un valor en "x" 
//  y el valor del exponente del término hasta el que 
//  se quiere sumar.
//  
//   José Elías   Garza Vázquez
//   09 / 01  / 20    version 1.0
//////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//  F
//
//  Funcion que calcula f(x) = cos x
//
//   Parametros:
//     dX     es el valor de x para evaluar
//   Regresa:
//     dY     es el valor real de coseno de x
/////////////////////////////////////////////////////
function dY = F(dX)
    dY = cos(dX)
endfunction

//////////////////////////////////////////////////////
//  maclaurin
//
//  Funcion que calcula la sumatoria de los términos 
//  de una serie para aproximar cosenos con Maclaurin 
//  dado el valor de x y el exponente del último 
//  término a sumar.
//   
//   Parametros:
//      dX     es el valor de x para evaluar
//      iN     es el exponente del último término a sumar
//   Regresa:
//  dSummation     es el valor aproximado del coseno de x
/////////////////////////////////////////////////////
function dSummation = maclaurin(dX, iN)
    // Inicializo la suma
    dSummation = 0 
    // Inicializo un contador para alternar el signo de cada término
    counter = 0 
    // Elaboro ciclo para cada término de la serie aumentando siempre en 2 para mantener la paridad del exponente
    for i = 0 : 2 : iN 
        // Sumo un término más de la serie
        dSummation = dSummation + ((-1)^counter)*(dX^i)/factorial(i) 
        // Alterno el signo del siguiente término de la serie
        counter = counter + 1 
    end 
endfunction

/////// Programa Principal

// pido los valores
dX = input("Inserte x: ")
iN = input("Inserte n: ")
// Elaboro el ciclo para validar la entrada del usuario
while(modulo(iN, 2) ~= 0 | iN < 0)
    // Pido nuevamente el valor si el usuario inserta un valor inválido
    iN = input("Inserte un exponente par y mayor a 0: ")
end

// Elaboro el ciclo para calcular errores relativos aumentando siempre en 2 para garantizar la paridad del exponente
for i = 0 : 2 : iN 
    // Obtengo la aproximación en la iteración actual
    dSum = maclaurin(dX, i) 
    // Calculo el Error Real relativo
    dEt = 100*abs((F(dX) - dSum)/F(dX)) 
    // Implemento condición para agregar el Error de Aproximación relativo desde la segunda iteración
    if i < 2 then 
        // Despliego estado de la primera iteración
        disp("para x = " + string(dX) + " y n = " + string(iN) + ascii(10) + " n = " + string(i) + " suma = " + string(dSum) + " Error Real rel % = " + string(dEt))
    else
        // Calculo el Error de Aproximación relativo
        dEa = 100*abs((dSum - dOldSum)/dSum) 
        // Despliego estado desde la segunda iteración
        disp("n = " + string(i) + " suma = " + string(dSum) + " Error Real rel % = " + string(dEt) + " Error aprox rel % = " + string(dEa)) 
    end
    // Guardo el valor de la aproximación anterior
    dOldSum = dSum
end
