using LinearAlgebra
include("simplex_method_loop.jl")
include("simplex_find_initial_point.jl")
dimension = 5 #default
constraint= 50 #default
A = rand(Float64,(constraint,dimension)) #default
b = rand(Float64,constraint) #default
c = rand(dimension) #default
objective(x) = c' * x  #default
#CAUTION: Ax <= b is the constraint type
#CAUTION: the program is intended to solve Maximium
#CAUTION: you should ensure the affine independence of your constraint

initial_point = big_M(A, b, c, dimension, constraint)
optimal_point = simplex_method_loop(A, b, c, initial_point, dimension,constraint)