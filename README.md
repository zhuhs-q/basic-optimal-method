# basic-optimal-method
* the project is intended to collect basic convex optimal methods and their extensions. 
* they are raw and of course not for commercial use. most of them haven't been packed yet.
* for me, the project is for reviewing those algorithms, and i hope it may help you in some ways.
* every class shall be updated within a week
## descent-method
* In fact, all the descent algorithms are examples of it, the difference is the norm they use
* for convenience, all the descent algorithms equiped with backtracking line searching
* examine it with "descent_method_main.jl"
### gradient descent method
* example of steepest descent method with l2 norm
* use backtracking for line searching
* not packed yet
* example : x' * x
### coordinate descent method
* example of steepest descent method with l1 norm
* use backtracking for line searching
* not packed yet
* example : x' * x
### newton method
* example of steepest descent method with hessian matrix
* not packed yet
* example : x' * x

## Linear programming
Linear programming is never easy programming, clever trick and geomerical intuition lead us to a higher level
### simplex method
* in my opinion, the simplex consists of two stage: find the initial point and find the optimal point. and in the program, these two stages are based on geometrical intuition and easy to understand.
### simplex method with cutting for Interger Programming
* we implement cutting plane method with gomory's cut

## factorable progrmming
The code is based on the essay <Global optimization of mixed-interger-nonlinear programs: A theoretical and computational study> of Tawarmalani and Sahinidis.
  solvers based on this essay popular nowadays. 
