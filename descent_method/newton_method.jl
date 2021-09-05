using ForwardDiff
using LinearAlgebra
include("backtracking_line_search.jl")

function newton_algo(epsilon,objective,x)
    g = x -> ForwardDiff.gradient(objective, x); # g = ∇f
    gradient = g(x)
    hessian = ForwardDiff.hessian(objective, x)
    while sum(abs,gradient) > epsilon
        gradient = g(x)
        hessian = ForwardDiff.hessian(objective, x)
        x = x - (gradient' * inv(hessian))'
    end
    return x
end
