import math
import timeit

def integrate(f, x1, x2, num_points = 10_000_000):
    """
    A magical integrator that integrates any function!

    Give it a box, and a function, and after a bit of time, out pops the area.
    """
    dx = (x2 - x1) / num_points

    area = 0.0
    for i in range(num_points):
        low = x1 + i * dx
        high = x1 + (i + 1) * dx
        area += dx * (f(high) + f(low)) / 2

    return area

def quarter_circle(x): return math.sqrt(1 - x**2)

start = timeit.default_timer()
area = integrate(quarter_circle, 0, 1)
duration = timeit.default_timer() - start

print(f"Pi       = {math.pi:.30}\nEstimate = {4 * area:.30}\n\nSeconds: {duration:E}")

