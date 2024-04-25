"""
   integrate(f, x₁, x₂; N = 10_000_000)

A magical integrator that integrates any function!

Give it a box, and a function, and after a bit of time, out pops the area.
"""
function integrate(f, x₁, x₂; N = 10_000_000)
    Δx = (x₂ - x₁) / N

    area = 0.0
    for i in 1:N
        low = x₁ + (i - 1) * Δx
        high = x₁ + i * Δx
        area += Δx * (f(high) + f(low)) / 2
    end

    return area
end


quarter_circle(x) = √(1 - x^2)

area = @time integrate(quarter_circle, 0.0, 1.0) ;

println("π        = $(Float64(π))\nEstimate = $(4 * area)")

