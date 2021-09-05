using ForwardDiff
using LinearAlgebra
include("backtracking_line_search.jl")

function gradient_algo(dimension,epsilon,objective,x,alpha,beta,step)
    g = x -> ForwardDiff.gradient(objective, x); # g = ∇f
    gradient = g(x)
    while sum(abs,gradient) > epsilon
        gradient = g(x)
        arc = - gradient
        demanding_step = backtracking_line_search(objective,x,alpha,beta,step,arc,gradient)
        x = x + demanding_step * arc
    end
    return x
end


#brief readme: rough underestimator. for learning only