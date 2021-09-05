using ForwardDiff
using LinearAlgebra
include("backtracking_line_search.jl")
include("newton_method.jl")
include("gradient_algorithm_l2.jl")
include("coordinate_algorithm_l1.jl")
include("gradient_algorithm_l2.jl")
include("coordinate_algorithm_l1.jl")
dimension = 10 #defult
epsilon = 0.001 #default
objective(x) =  x' * x   #default
x = rand(dimension) #default, point selection is also an important step
alpha = 0.1 #default
beta = 0.5 #default
step = 100 #default


x = newton_algo(epsilon,objective,x)
x = coordinate_algo(dimension,epsilon,objective,x,alpha,beta,step)


print(x) 
print(objective(x))

#brief readme: rough underestimator. for learning only