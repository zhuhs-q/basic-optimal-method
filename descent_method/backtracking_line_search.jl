using LinearAlgebra
function backtracking_line_search(objective,x,alpha,beta,step,arc,gradient)
    demanding_step = step
    while objective(x + demanding_step * arc) > objective(x) + alpha * demanding_step * gradient' * arc
        demanding_step = beta * demanding_step
    end
    return demanding_step
end

