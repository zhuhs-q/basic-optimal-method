using ForwardDiff
using LinearAlgebra
include("backtracking_line_search.jl")

dimension = 5 #defult
epsilon = 0.0000001 #default
objective(x) = x' * x +5#default
x = rand(dimension) #default, point selection is also an important step
alpha = 0.1 #default
beta = 0.5 #default
step = 100 #default

g = x -> ForwardDiff.gradient(objective, x); # g = ∇f
gradient = g(x)

while sum(abs,gradient) > epsilon
    gradient = g(x)
    arc = -gradient
    demanding_step = backtracking_line_search(objective,x,alpha,beta,step,arc,gradient)
    x = x + demanding_step * arc
end

print(x) 
print(objective(x))

#brief readme: rough underestimator. for learning only