using ForwardDiff
using LinearAlgebra
include("backtracking_line_search.jl")

function coordinate_algo(dimension,epsilon,objective,x,alpha,beta,step)
    g = x -> ForwardDiff.gradient(objective, x); # g = ∇f
    gradient = g(x)
    while sum(abs,gradient) > epsilon
        gradient = g(x)
        i = argmax(gradient)
        j = argmin(gradient)
        if abs(gradient[j]) > abs(gradient[i])
            i = j
        end
        arc = zeros(dimension)
        arc[i] = - gradient[i]
        demanding_step = backtracking_line_search(objective,x,alpha,beta,step,arc,gradient)
        x = x + demanding_step * arc
    end
    return x
end