using Plots
using ForwardDiff

function newton_root(f, x₀; N = 10)
    df(x) = ForwardDiff.derivative(f, x)
    for i in 1:N
        x₀ -= f(x₀) / df(x₀)
    end
    return x₀
end

# Define a utility operator
∂(f) = x -> ForwardDiff.derivative(f, x)

# A test function
g(x) = -(x - 1.2)^2 * cos(5x - 1) + 3

# Visualise it
xs = range(-1, 1, 100)
plot(xs, g)

# Trivially plot the derivative
plot!(xs, ∂(g))
hline!([0], linestyle = :dash, color = :black)

# Our guess / starting point
# (please don't program with emojis)
🤔 = 0.0

# Solve for the root
🤠 = newton_root(∂(g), 🤔)

# Plot the point
scatter!([🤠], [g(🤠)])

# But there's a few more! Add more guesses
x₀ = [-0.5, 0.5]
sols =  newton_root.(∂(g), x₀)
scatter!(sols, g.(sols))


# AD is *magical*, because we it treats the function as "opaque" It isn't doing
# symbolic things, so we can even take the derivative of our area integrals and
# solve for optimal points

as = collect(range(-5.0, 3.0, 100))
areas = @time integrate_f(-5, 10, as, 1) ;
plot(as, areas)

# Define my derivative function
∂fa = ∂(a -> integrate_f(-5, 10, a, 1))

# Calculate and plot
deriv = @time ∂fa.(as)
plot!(as, deriv)

# Think about what just happened there: our trapezoid integration function was
# called 100 times, but now propagating the `ForwardDiff.Dual` number type to
# let us find how the area changes as a function of `a`! Doing this with finite
# difference or stenciling methods would have been horrendous, but with Julia
# we can skip that and move on with our analysis.

# Guess a ≈ -2 for the minima
a₀ = newton_root(∂fa, -2.0)

# And plot the point
scatter!([a₀], [integrate_f(-5, 10, a₀, 1)])

