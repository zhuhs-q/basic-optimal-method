using LinearAlgebra
include("simplex_method_step.jl")
epsilon = 0.000000001
function simplex_method_loop(A, b, c, initial_point, dimension,constraint)
    while maximum(simplex_method_step(A, b, c, initial_point, dimension,constraint)[2]) > epsilon
        index = argmax(simplex_method_step(A, b, c, initial_point, dimension,constraint)[2])
        initial_point = simplex_method_step(A, b, c, initial_point, dimension,constraint)[1,index[1],index[2],:]
    end
    return initial_point
end
