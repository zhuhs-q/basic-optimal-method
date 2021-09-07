using LinearAlgebra
epsilon = 0.00000001 #default, be small anyway
function simplex_method_step(A, b, c, initial_point, dimension,constraint)
    inter_set = zeros(Float64,(dimension,dimension))
    inter_set_b = zeros(Float64,dimension)
    other_set = zeros(Float64,(constraint - dimenstion,dimension))
    other_set_b = zeros(Float64,(constraint - dimension))
    new_point = zeros(Float64,(dimension,constraint - dimension,:))
    new_data = zeros(Float64,(dimension,constraint - dimension))
    inter = A * initial_point
    j = 0
    l = 0
    for i = 1 : dimension
        if abs(inter[i]) < epsilon
            j += 1
            inter_set[j,:] = A[i, :]
            inter_set_b[j] = b[i]
        else
            l += 1
            other_set[l,:] = A[i,:]
            other_set_b[l] = a[i]
        end
    end
    for i = 1 : dimension
        for k = 1 : constraint - dimension
            temp = inter_set[i,:]
            temp_b = inter_set_b[i]
            inter_set[i,:] = other_set[k,:]
            inter_set_b[i] = other_set_b[k]
            new_point[i,k,:] = inv(inter_set) * inter_set_b
            new_data[i,k] = (new_point[i,k,:] - initial_point)' * c
            inter_set[i,:] = temp
            inter_set_b[i] = temp_b
        end
    end
    return new_point, new_data
end

