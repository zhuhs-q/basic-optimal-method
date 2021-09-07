using LinearAlgebra
include("simplex_method_loop.jl")
#the program is intended to find the initial point (big M method)

function big_M(A, b, c, dimension, constraint)
    M = 100000000 #default, should big any way
    new_c = zeros(Float64,dimension + constraint)
    new_A = zeros(Float64,(2 * constraint ,constraint + dimension))
    new_b = zeros(Float64,2 * constraint)
    for i = 1 : dimension
        new_c[i] = c[i]
    end
    for i = dimension + 1 : dimension + constraint
        new_c[i] = -M
        new_A[i - dimension, i] = 1
        new_A[i - dimension + constraint, i] = -1
    end 
    for i = 1 : constraint
        new_b = b[i]
        for j = 1 : dimension
            new_A = A[i,j]
        end
    end
    initial_point = zeros(Float64, dimension + constraint)
    for i = dimension + 1 : constraint
        initial_point[i] = b[i-dimension]  
    end
    initial_point = simplex_method_loop(new_A, new_b, new_c, initial_point, dimension+constraint,2 * constraint)
    return initial_point
end