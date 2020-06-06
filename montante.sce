clear

function montante(mat)
    [rows, cols] = size(mat)
    pivot = 1
    X = zeros(rows, cols)
    for i = 1 : rows

        X(i, :) = mat(i, :)
        disp(mat(i, i))
        
        for j = 2 : rows
            if j ~= i
                for k = 1 : cols
                    X(j, k) = mat(i, i)*mat(j, k) - mat(j, i)*mat(i, k)
                    X(j, k) = X(j, k)/pivot
                end
            end
        end
        disp(mat)
        mat = X
        pivot = mat(i, i)
    end
    mat = mat/mat(1, 1)
    disp(mat)
endfunction

A = [1 2 3 4
5 6 7 8
9 10 11 12]

montante(A)
