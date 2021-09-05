using LinearAlgebra
function backtracking_line_search(objective,x,alpha,beta,step,arc,gradient)
    while objective(x + step * arc) > objective(x) + alpha * step * gradient' * arc
        step = beta * step
    end
    return step
end

