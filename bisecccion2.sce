clear
///////////////////////////////////////////////////////
//  Bisección.sce
//
//  Este programa aproxima la solucion de una función 
//  de volumen utilizando el método de bisección, dado
//  un rango [xl, xu], un error aproximado máximo y un 
//  número máximo de iteraciones 
//
//   José Elías Garza Vázquez
//   Andrés Alam Sánchez Torres
//   15 / Ene / 20    version 1.0
//////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//  F
//
//  Funcion que calcula f(x) = (%pi/3)(3*R - x)(x)^2
//  cuando f(x) = 30 y R = 3
//
//   Parametros:
//      dX     es el valor de x para evaluar
//   Regresa:
//     dY     es el calculo de f(x)
/////////////////////////////////////////////////////
function F(dX)
    R = 3
    disp((%pi/3)(3*R - dX)(dX)^2 - 30)
endfunction

disp(2*F(6))


//////////////////////////////////////////////////////
//  bisección
//
//  Funcion que aproxima x para (%pi/3)(3*R - x)(x)^2
//  cuando f(x) = 30 y R = 3, dado un rango [xl, xu]
//
//   Parametros:
//      dXl     es el valor inferior del rango
//      dXu     es el valor superior del rango
//      dEa     es el valor de error máximo deseado
//      iIter   es el numero máximo de iteraciones
//   Regresa:
//      No hay valor de retorno
/////////////////////////////////////////////////////
function biseccion(dXl, dXu, dEa, iIter)
    // Variable booleana para marcar si ya no se debe seguir iterando
    bCompletado = 0
    // Se inicializa un contador de iteraciones
    iIteraciones = 0
    // Variable para guardar el error aproximado
    dEaActual = 0
    // Variable para guardar la última aproximación de x para calcular 
    // el error aproximado
    dXAnterior = 0
    // Se inicializa variable de string para indicar la razón por
    // la que se completó la iteración
    sRespuesta = ''
    // Se inicia el ciclo de la bisección
    while (~bCompletado & iIteraciones < iIter)
        // Se calcula la x de la mitad de los límites, la aproximación
        dXr = (dXl + dXu) / 2
        // Variables para guardar la evaluación de la función en los límites
        dFxl = F(dXl)
        dFxu = F(dXu)
        dFxr = F(dXr)
        // Se desplegará el valor de la x aproximada
        sDisplay = "xr = " + string(dXr)
        // Si la función en la nueva x es 0, es la raíz exacta
        if dFxr == 0 then
            sRespuesta = "La raiz encontrada es exacta"
            // Se completó por encontrar la raíz
            bCompletado = 1
        elseif dFxr * dFxl < 0 then
            // Si el producto de la función en xr y xl < 0, los nuevos límites
            // son xl y xu = xr
            dXu = dXr 
        else
            // El caso restante implica F(xr) * F(xu) < 0, por lo que los nuevos límites
            // son xl = xr y xu
            dXl = dXr
        end
        // Se aumenta el número de iteraciones
        iIteraciones = iIteraciones + 1
        // Solo hay error aproximado cuando no es la primera iteración
        if iIteraciones <> 1 then
            // Se calcula error aproximado actual
            dEaActual = abs((dXr - dXAnterior) / dXr) * 100
            // Se desplegará el error aproximado
            sDisplay = sDisplay + ", Error aproximado = " + string(dEaActual)
            if dEaActual < dEa then
                sRespuesta = "La raiz encontrada fue aproximada con el error absoluto porcentual"
                // Se completó por tener un error menor al deseado
                bCompletado = 1
            end
        end
        // Se actualiza el valor de x anterior para calcular el error
        dXAnterior = dXr
        // Se despliega la línea de la iteración
        disp(sDisplay)
    end

    if iIteraciones >= iIter
        // Se completó por sumerar el número de iteraciones
        sRespuesta = "La raiz encontrada fue aproximada con el numero de iteraciones dado"
    end
    // Desplegar respuesta
    disp(sRespuesta)
    // Desplegar valor aproximado de la raíz
    disp('La raiz es: ' + string(dXr))

endfunction


/////// Programa Principal
dXl = input('Introduce el limite inferior. ')
dXu = input('Introduce el limite superior. ')
dEa = input('Introduce el error aproximado maximo. ')
iIter = input('Introduce el maximo numero de iteraciones. ')
biseccion(dXl, dXu, dEa, iIter)
