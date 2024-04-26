using Plots

# I have this function
f(x, a, b) =  (x - ((b * x - 5sin(a))^2 )) / (2 + sin((b * x + 1) - 7a)) + 20

# It looks like this
xs = range(-5, 10, 200)
begin
    p = plot()
    for a in 1:3
        plot!(xs, f.(xs, a, 1), label = "a=$a")
    end
    hline!(p, [0], label = nothing, color = :black)
    p
end

function integrate_f(x₁, x₂, a, b)
    integrate(x -> f(x, a, b), x₁, x₂; N = 100_000)
end

# I want to know how the area changes as a function of the different
# parameters. So I add a dispatch that specializes when `a` is a vector.
function integrate_f(x₁, x₂, a::Vector, b)
    areas = zeros(length(a))
    for i in eachindex(a)
        aᵢ = a[i]
        areas[i] = integrate_f(x₁, x₂, aᵢ, b)
    end
    areas
end

# Lets see how the area changes when I change `a`
as = collect(range(-5.0, 3.0, 100))
areas = @time integrate_f(-5, 10, as, 1) ;
plot(as, areas)

# The curve changes rapidly, so it's good we can evaluate it fast because we
# need high resolution to see all the detail
# But I *actually* have two parameters I am interested in...
function integrate_f(x₁, x₂, a::Vector, b::Vector)
    areas = zeros(length(a), length(b))
    for i in eachindex(a)
        aᵢ = a[i]
        for j in eachindex(b)
            bᵢ = b[j]
            areas[i, j] = integrate_f(x₁, x₂, aᵢ, bᵢ)
        end
    end
    areas
end

# The problem I now have is that my parameters space has increased by two
# orders of magnitude, which means I would have to reduce resolution to see the
# result, but then I might miss something!

# Fortunately, with Julia I can use the `Threads.@threads` macro to trivially
# multi-thread this (go up and add `Threads.@threads` before the first `for`
# loop and measure the speed increase!
bs = collect(range(-1, 1.0, 100))
areas = @time integrate_f(-5, 10, as, bs) ;

# Lets see our result!
heatmap(bs, as, areas, xlabel = "b", ylabel = "a")
contour!(bs, as, areas, color = :black)

