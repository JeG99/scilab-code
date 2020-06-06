clear
function [] = gauss(mat)
    
    rows = size(mat)(1)
    /*
    for i = 1 : rows
        if mat(i, i) ~= 0
            mat(i, :) = (1/mat(i, i))*mat(i, :)
        end
    end
    */
    cols = rows + 1
    for i = 1 : rows
        for j = 1 : cols
            if j < i
                disp(mat(i, :))
                //disp(mat(i, j))
                disp(mat(j, j))
                //mat(i, :) = -mat(i, j)*mat(j, :)+mat(i, :)  
            end
        end
    end

    //disp(mat)
    
endfunction

matriz = [1, 2, 3, 2; 
4, 5, 6, 4;
7, 8, 9, 5;]

gauss(matriz)
