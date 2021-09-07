using LinearAlgebra
epsilon = 0.00000001 # default, be small anyway

function simplex_method_loop(A, b, c, initial_point, dimension, constraint)
    inter_set = zeros(Float64, (dimension, dimension))
    inter_set_b = zeros(Float64, dimension)
    other_set = zeros(Float64, (constraint - dimension, dimension))
    other_set_b = zeros(Float64, constraint - dimension)
    new_point = zeros(Float64, (dimension, constraint - dimension, dimension))
    new_data = zeros(Float64, (dimension, constraint - dimension))
    new_data = zeros(Float64, (dimension, constraint - dimension))
    new_data[1,1] = 100
    inter = A * initial_point
    j = 0
    l = 0
    instance = 0
    index = 0
    for i = 1:constraint
        if j != dimension
            if abs(inter[i] - b[i]) < epsilon
                j += 1
                inter_set[j,:] = A[i, :]
                inter_set_b[j] = b[i]
            else
                l += 1
                other_set[l,:] = A[i,:]
                other_set_b[l] = b[i]
            end
        else
            index = 1
            instance = i
            break
        end
    end
    if index == 1
        for i = instance:constraint
            l += 1
            other_set[l,:] = A[i,:]
            other_set_b[l] = b[i]
        end
    end
    while maximum(new_data) > epsilon
        for i = 1 : dimension
            for k = 1 : constraint - dimension
                temp = inter_set[i,:]
                temp_b = inter_set_b[i]
                inter_set[i,:] = other_set[k,:]
                inter_set_b[i] = other_set_b[k]
                if det(inter_set) != 0
                    new_point[i,k,:] = inv(inter_set) * inter_set_b
                    new_data[i,k] = c' * (new_point[i,k,:] - initial_point)
                end
                inter_set[i,:] = temp
                inter_set_b[i] = temp_b
            end
        end
        index = argmax(new_data)
        initial_point = new_point[index[1],index[2],:]
        temp = other_set[index[2],:]
        temp_b = other_set_b[index[2]]
        other_set[index[2],:] = inter_set[index[1],:]
        other_set_b[index[2]] = inter_set_b[index[1]]
        inter_set[index[1],:] = temp
        inter_set_b[index[1]] = temp_b
    end
    return initial_point
end

function geometry_find(A, b, c, dimension, constraint)
    initial_point = inv(A[1:dimension,:]) * b[1:dimension]
    abandoned_set = zeros(Float64, (constraint - dimension, dimension))
    abandoned_set_b = zeros(Float64, constraint - dimension)
    for i = dimension + 1:constraint
        if sum(A[i,:] .* initial_point) - b[i] > epsilon
            for j = 1:dimension
                abandoned_set[i - dimension,:] = A[j,:]
                abandoned_set_b[i - dimension] = b[j] 
                A[j,:] = A[i,:]
                b[j] = b[i]
                abandon = abandoned_set * inv(A[1:dimension,:]) *  b[1:dimension] - abandoned_set_b
                if maximum(abandon) < epsilon
                    initial_point = inv(A[1:dimension,:]) *  b[1:dimension]
                    break
                else
                    A[j,:] = abandoned_set[i - dimension,:]
                    b[j] = abandoned_set_b[i - dimension]
                    abandoned_set[i - dimension,:] = zeros(Float64, dimension)
                    abandoned_set_b[i - dimension] = 0 
                end
            end
        end
    end
    return initial_point
end

dimension = 20 # default
constraint = 100 # default
A = 100 * rand(Float64, (constraint, dimension)) # default
constraint_matrix = A
b = 100 * rand(Float64, constraint) # default
constraint_matrix_b = b
c = 100 * rand(dimension) # default
# objective(x) = c' * x  default
# CAUTION: Ax <= b is the constraint type
# CAUTION: the program is intended to solve Maximium
# CAUTION: you should ensure the affine independence of your constraint
initial_point = geometry_find(A, b, c, dimension, constraint)

# print(initial_point)
optimal_point = simplex_method_loop(constraint_matrix, constraint_matrix_b, c, initial_point, dimension, constraint)
# print(optimal_point)|
