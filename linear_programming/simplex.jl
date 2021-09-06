using LinearAlgebra

dimension = 3 #default
constraint_number = 50 #default
A = rand(Float64,(constraint_number,dimension)) #default
constrait = A
b = rand(Float64,constraint_number) #default
constrait_b = b
c = rand(dimension) #default
#CAUTION: Ax <= b is the constraint type
#CAUTION: the program is intended to solve Maximium
#CAUTION: you should ensure the affine independence of your constraint
index = 0
objective(x) = c' * x 
x = inv(A[1:dimension,:]) * b[1:dimension]
for i = dimension + 1 : constraint_number
    if A[i,:]' * x > b[i]
        index = 0
        for j = 1 : dimension
            temp = A[j,:]
            temp_b = b[j]
            b[j] = b[i]
            A[j,:] = A[i,:]
            if temp' * inv(A[1:dimension,:]) * b[1:dimension] < temp_b
                x = inv(A[1:dimension,:]) * b[1:dimension]
                index = 1
                break
            else
                A[j,:] = temp
                b[j] = temp_b
            end
        end
        if index == 0
            print("NO")
            break
        end 
    end
end
for i = 1 : constraint_number
    if (constrait * x - constrait_b)[i] > 0.00001
        print("bad")
        break
    end
end
