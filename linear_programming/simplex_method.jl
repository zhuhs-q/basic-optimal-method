using LinearAlgebra
epsilon = 0.00000001 #default, be small anyway

function simplex_method_loop(A, b, c, initial_point, dimension,constraint)
    new_data = zeros(Float64,(dimension,constraint - dimension))
    new_data[1,1] = 100
    while maximum(new_data) > epsilon
        print("yesyesyes")
        inter_set = zeros(Float64,(dimension,dimension))
        inter_set_b = zeros(Float64,dimension)
        other_set = zeros(Float64,(constraint - dimension,dimension))
        other_set_b = zeros(Float64,constraint - dimension)
        new_point = zeros(Float64,(dimension,constraint - dimension,dimension))
        new_data = zeros(Float64,(dimension,constraint - dimension))
        inter = A * initial_point
        j = 0
        l = 0
        for i = 1 : constraint
            if abs(inter[i] - b[i]) < epsilon
                j += 1
                inter_set[j,:] = A[i, :]
                inter_set_b[j] = b[i]
            else
                l += 1
                other_set[l,:] = A[i,:]
                other_set_b[l] = b[i]
            end
        end
        for i = 1 : dimension
            for k = 1 : constraint - dimension
                temp = inter_set[i,:]
                temp_b = inter_set_b[i]
                inter_set[i,:] = other_set[k,:]
                inter_set_b[i] = other_set_b[k]
                new_point[i,k,:] = inv(inter_set) * inter_set_b
                new_data[i,k] = c' * (new_point[i,k,:] - initial_point)
                inter_set[i,:] = temp
                inter_set_b[i] = temp_b
            end
        end
        index = argmax(new_data)
        initial_point = new_point[index[1],index[2],:]
    end
    return initial_point
end

function big_M(A, b, c, dimension, constraint)
    M = 10000000000000 #default, should big any way
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
        new_b[i] = b[i]
        for j = 1 : dimension
            new_A[i,j] = A[i,j]
        end
    end
    initial_point = zeros(Float64, dimension + constraint)
    for i = dimension + 1 : dimension + constraint
        initial_point[i] = b[i-dimension]  
    end
    initial_point = simplex_method_loop(new_A, new_b, new_c, initial_point, dimension+constraint, 2 * constraint)
    return initial_point
end

dimension = 2 #default
constraint= 3 #default
A = rand(Float64,(constraint,dimension)) #default
b = rand(Float64,constraint) #default
c = rand(dimension) #default
# objective(x) = c' * x  default
#CAUTION: Ax <= b is the constraint type
#CAUTION: the program is intended to solve Maximium
#CAUTION: you should ensure the affine independence of your constraint

initial_point = big_M(A, b, c, dimension, constraint)


#print(initial_point)
#optimal_point = simplex_method_loop(A, b, c, initial_point, dimension,constraint)
#print(optimal_point)