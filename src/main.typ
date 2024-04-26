#import "@preview/polylux:0.3.1": *
#import "tamburlaine.typ": *
#import emoji

#show: tamburlaine-theme.with(aspect-ratio: "4-3")
#show link: item => underline(text(blue)[#item])

#enable-handout-mode(true)

#let pretty-title = par(leading: 28pt)[
  #text(weight: "black", size:103pt, juliafy(
    "An informal introduction to")
  )
  #h(16em)
  #move(
    dx: -4em,
    dy: -4.8em,
    image("figs/julia_logo.svg", width: 40%)
  )
]

#let fat-text(t) = {
  text(size: 40pt, weight: "black", juliafy(t))
}
#let boxed(t, fill-color: JULIA_RED) = {
  rect(width: 100%, inset: (top: 10pt, bottom: 10pt), fill: fill-color, radius: 5pt, text(fill: SECONDARY_COLOR, t))
}

#title-slide(
  title: pretty-title,
  authors: ("Fergus Baker",),
  where: juliafy("Astro Dev Group"),
  date: datetime(year: 2024, month: 4, day: 26)
)


#slide(title:"Before we begin ...")[
  #one-by-one(start:2)[
  If you want to follow along:
  - #link("https://julialang.org/downloads/")[https://julialang.org/downloads/]
  - "One-liner" install
  #v(-2em)
][
  #align(right, fat-text("... alternatively ..."))
  #v(-1em)
  #block(inset: (left: 4em))[
    Julia is installed on the *Astrophysics Servers*
  ]
][
  #v(-1em)
  #fat-text("Shell in, join in!")
  #v(-0.5em)
  #align(center, text(size: 14pt)[
  ```
  lx21966@hm00: ~ $ module load julia/1.8.5
  lx21966@hm00: ~ $ julia
                 _
     _       _ _(_)_     |  Documentation: https://docs.julialang.org
    (_)     | (_) (_)    |
     _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
    | | | | | | |/ _` |  |
    | | |_| | | | (_| |  |  Version 1.8.5 (2023-01-08)
   _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
  |__/                   |

  julia>
  ```
  ])
  ]
]

#slide(title:"Why Julia when there's X Y Z?", title-size: 42pt)[
  #v(-0.8em)
  #one-by-one(start:2)[
  #boxed(fill-color: white.darken(10%), align(center, fat-text("The \"Two Language Problem\"")))
  #v(-0.8em)
][
  #grid(
    columns: (50%, 50%),
    [
      #uncover("3-")[*Prototyping language*]
      #uncover("4-")[
      - For _ease_ 😎
      - Simple language, quick to put stuff together 🔨
      - _Convenient_, few lines of code 🌝
      - Has all the tooling and utilities, nice package management 🥦
      ]
    ],
    [#uncover("3-")[*The 'real' language*]
    #uncover("5-")[
      - For _speed_ ⚡
      - Complex language, time-consuming
      - _Difficult_ and error prone 🪲
      - Many lines of code
      - Probably won't do your analysis in this language 👀
    ]
    ]
  )
  #uncover("6-")[
  #boxed(fill-color: JULIA_GREEN)[
    Especially in *science*: skill disconnect between *researcher* and *developer*
  ]
]
]
]

#slide(title:"Solving the problem")[
  #one-by-one(start: 2)[
  A language that does both!
][
  - Julia is #text(fill: JULIA_RED)[*simple*], #text(fill: JULIA_PURPLE)[*fast*], and #text(fill: JULIA_GREEN)[*scalable*]
  - Dynamically typed (optionally strongly typed)
  - Lets you reach under the hood *when you need to*
]
  #uncover("4-")[
  #v(-1.0em)
  #align(right, fat-text("And solving many more"))
]
  #v(0.2em)
  #line-by-line(start: 4)[
  - Macro system for *domain specific languages* (DSLs)
  - Multiple-dispatch for *highly optimized* execution / native and xPU backends / distributed]
  #v(-0.5em)
#uncover("6")[
  #boxed(fill-color: white.darken(10%), text(fill:TEXT_COLOR)[
    Julia is a *JIT* compiled, *garbage collected* language (MIT)
    - *Compiler embedded* in the runtime, built on *LLVM*
    - Lisp-style macros that manipulate AST
    - C/Fortran ABI and *Python* interop (*! astro*)
  ])
]
]

#slide(title:"Syntax")[
  #grid(
    columns: (60%, 40%),
    row-gutter: 10pt,
  [
  #uncover("2-")[
  ```julia
  println("Hello World")
  5 + 3
  ```
]
#uncover("3-")[
  ```julia
  items = [1, 2, 3, 4, 5, 6]
  items[1] # indices start at 1
  ```
]
#uncover("4-")[
  ```julia
  items² = items .^ 2
  ```
]
#uncover("5-")[
  ```julia
  dot_product = items' * items
  ```
  ```julia
  matrix = items' .* items
  ```
]
  ],
  [
    #uncover("2-")[
  Familiar imperative syntax
  #v(2.1em)
]
  #uncover("4-")[
  *Broadcast* mechanism
]
  #v(-0.2em)
  #uncover("5-")[
  ```julia
  91
  ```
  ```julia
  6×6 Matrix{Int64}:
   1   2   3   4   5   6
   2   4   6   8  10  12
   3   6   9  12  15  18
   4   8  12  16  20  24
   5  10  15  20  25  30
   6  12  18  24  30  36
  ```
  ]])
]

#slide(title:"Control flow and more")[
  #grid(columns: (40%, 1fr),
  [
  #uncover("2-")[
  'Blocks' return values
  #v(-0.5em)
  ```julia
  x = if y > 0
      reduced = sqrt(y)
      2 * reduced
  else
      4
  end
  ```
]
  ],[
  #uncover("3-")[
  String interpolation
  #v(-0.5em)
  ```julia
  for s in ["hello", "bonjour", "hoi"]
      greeting = uppercasefirst(s)
      println("$greeting Julia!")
  end
  ```
]
  ]
)
  #uncover("4-")[
  Many ways to define a *function*
]
  #set text(size: 23pt)
  #v(-0.5em)
  #grid(
    columns: (55%, 45%),
  [
  #uncover("4-")[
  ```julia
  function quadratic_solve(a, b, c)
      Δ = √(b^2 - 4a * c)
      root1 = (-b + Δ) / (2a)
      root2 = (-b - Δ) / (2a)
      return (root1, root2)
  end
  ```
  (The `return` is optional)
]
  ],[
    #uncover("5-")[
    Or more mathsy:
    ```julia
    f(x) = 5x^2 + 3x - 4
    ```
    Use whichever feels \
    best 😇
  ]
  ]
)
]

#slide(title:"Side effects")[
  If a function *modifies* its arguments, it's name ends *by convention* with a *`!`* (called a "bang" 🧨)
  #uncover("2-")[
  #align(center)[
  ```julia
  a = [7, 2, 9, 3, 5, 1, 8, 4, 5]

  b = sort(a) # does not touch `a`
  sort!(a)    # modifes `a` inplace
  @assert a .== b
  ```
  ]
]
  #uncover("3-")[
  #align(right, fat-text("Easier to reason about code"))
]
#uncover("4-")[
  #boxed(fill-color:JULIA_BLUE, text(fill: SECONDARY_COLOR, [
    #v(0.2em)
    Many functions have *`!`* alternatives. \
    This is not enforced, but common *convention*.
    #v(0.2em)
  ]))
]
]

#slide(title: "")[
  #v(-6em)
  #align(right, par(leading: 20pt, text(weight: "black", size: 160pt, juliafy("A first example"))))
  #v(-4em)
  #boxed(fill-color: JULIA_BLUE)[
    #v(0.2em)
    See `examples/01-trapezoid-julia.jl`. *Compare* this to the Python implementation.
    #v(0.2em)
  ]
]

#slide(title:"Why is Julia so fast?")[
  The #text(fill:JULIA_RED)[*compiler*] performs #text(fill: JULIA_GREEN)[*type inference*] on our code
  #uncover("2-")[
  - Compiles a *specialized* version for *inferred types*
  - Generates *machine code* (JIT compiled)
  - In practice: first time you call a function there's a small *compile time* overhead
  - If the *types change*, the call stack is *recompiled*
]
  #v(-0.5em)
#uncover("3-")[
  #align(right, fat-text("Known as \"multiple dispatch\""))
]
#uncover("4-")[
  #v(-0.5em)
  In Julia *multiple dispatch* is the *core idiom*
  - Most languages have a *one definition rule* (ODR)
  - ODR: a function can only have *one* implementation
  - Some have *overloading* (C++ recently more sophisticated with C++20 Concepts)
]
]

#slide(title:"A look at multiple dispatch")[
  ```julia
  measure(x) = sqrt(x^2)
  ```
  #one-by-one(start:2)[
  But what if my number is *complex*?
][
  ```julia
  measure(x::Complex) = sqrt(x.re^2 + x.im^2)
  ```
][
  But what if my number is actually a *vector*?
][
  ```julia
  measure(x::Vector) = sqrt(x' * x)
  ```
][
  #v(0.2em)
  #align(right)[Retain the #text(fill: JULIA_RED)[*meaning*], focus on the #text(fill: JULIA_PURPLE)[*action*]]
  Have the #text(fill: JULIA_GREEN)[*implementation*] do the #text(fill: JULIA_BLUE)[*right*] (or fast) thing
  #grid(
    columns: (27%, 33%, 1fr), [
    ```julia
    measure(5.0)
    ```
    ], [
    ```julia
    measure(3 - 6im)
    ```
    ], [
    ```julia
    measure([5, 1, 8])
    ```
  ])
][
  #boxed(fill-color: white.darken(10%), align(center, fat-text("What's the compiler doing?")))]
]

#slide(title: "Inspecting deeper")[
  Meet some *new friends* 🐴 🐬:
  #grid(
    columns: (23%, 23%, 1fr),
    [ ```julia
      typeof(x)
      ``` ],
    [ ```julia
      methods(f)
      ``` ],
    [ ```julia
      @code_warntype f(x)
      ``` ],
  )
  #uncover("2-")[
  They show us what the *compiler* sees and uses:
]
  #grid(
    columns: (30%, 1fr),
    column-gutter: 3em,
    [
      #uncover("2-")[
  ```julia
  julia> typeof(5.0)
  Float64
  julia> typeof(5)
  Int64
  ```
]
  ],[
    #uncover("3-")[
  ```julia
  julia> methods(measure)
  # 3 methods for generic function
  "measure" from Main:
   [1] measure(x::Vector)
       @ REPL[15]:1
   [2] measure(x::Complex)
       @ REPL[14]:1
   [3] measure(x)
       @ REPL[13]:1
  ```
]
  ]
)
]

#slide(title:"@code_warntype")[
  See the *types inferred* by the compiler
  #set align(center)
  ```julia
  julia> @code_warntype measure([5, 1, 8])
  MethodInstance for measure(::Vector{Int64})
    from measure(x::Vector) @ Main REPL[15]:1
  Arguments
    #self#::Core.Const(measure)
    x::Vector{Int64}
  Body::Float64
  1 ─ %1 = Main.:var"'"(x)::LinearAlgebra.Adjoint{Int64, Vector{Int64}}
  │   %2 = (%1 * x)::Int64
  │   %3 = Main.sqrt(%2)::Float64
  └──      return %3
  ```
]

#slide(title:"The compiler")[
  #block(
    move(dx: 2.5em, image("figs/julia-source-to-native.png", width: 90%))
  )
  #align(right, text(size: 12pt, "Image: Carsten Bauer"))
]

#slide(title:"")[
  #v(-6em)
  #align(right, par(leading: 20pt, text(weight: "black", size: 140pt, juliafy("Going nowhere faster"))))
  #v(-5.5em)
  #boxed(fill-color: JULIA_BLUE)[
    #v(0.2em)
    See `examples/02-threaded-julia.jl` for an example of `@threads` macro.
    #v(0.2em)
  ]
]

#slide(title:"Aside: automatic differentiation", title-size: 42pt)[
  #set align(center)
  There's an excellent video: \
  https://www.youtube.com/watch?v=vAp6nUMrKYg
  #image("./figs/auto-diff-youtube.png", width: 80%)
  Go watch it!
]

#slide(title:"AD crash course", title-size: 42pt)[
  A *magical way* of taking derivatives of functions
  #boxed(fill-color: JULIA_PURPLE)[
    #v(0.2em)
    Use a *dual number*, as in $x + dif x$. (Ab)use the *chain rule*.
    #v(0.2em)
  ]

  $
  dif (x + y) &arrow.r.bar dif x + dif y \
  dif (x y) &arrow.r.bar dif x #h(6pt) y + x #h(3pt)dif y
  $
  #uncover("2-")[
  Implementing in Julia:
  #text(size: 22pt)[
  #grid(columns: (30%, 1fr),
  [ ```julia
  struct Dual
      x::Float64
      dx::Float64
  end
  ``` ],[
  ```julia
  x::Dual + y::Dual =
      Dual(x.x + y.x, x.dx + y.dx)
  x::Dual * y::Dual =
      Dual(x.x * y.x, x.dx * y.x + x.x * y.dx)
  # and `/` `^` ... left to the reader
  ```
  ])
]
  With *multiple dispatch* straight forward to define!]
]

#slide(title:"Example: extrema")[
  Don't reinvent the wheel, *ForwardDiff.jl* has all we need:
  #align(center, text(size: 22pt)[
  ```julia
  using ForwardDiff
  f(x) = x^5 - 4x^3 + x^2 - 3
  @assert 36 == ForwardDiff.derivative(f, 2)
  ```
  ])
  #uncover("2-")[
  Root finding
  #v(-0.5em)
]

  #grid(columns: (60%, 1fr),
  text(size: 22pt)[
    #uncover("2-")[
  ```julia
  function newton_root(f, x₀; N = 10)
      df(x) = ForwardDiff.derivative(f, x)
      for i in 1:N
          x₀ -= f(x₀) / df(x₀)
      end
      return x₀
  end
  ```
]
  ],
  block[
    #uncover("2-")[
  Find extrema with: $f'(x) = 0$
]
  #v(1em)
  #uncover("3-")[
  #fat-text("Try it out!")
]
  ]
)
  #uncover("3-")[
  #boxed(fill-color: JULIA_GREEN)[
    See `examples/03-root-finding.jl` for an example.
  ]
]
]

#slide(title:"Julia for astrophysics")[
  #v(-0.3em)
  There's a growing *JuliaAstro* community full of wonderful people ✨🔭
    #uncover("2-")[
  #boxed(fill-color: JULIA_GREEN)[
    #v(0.2em)
    Julia is *excellent* for data science, optimization problems, differential equation, machine learning...
    #v(0.2em)
]
  ]
  #uncover("3-")[
  Multiple dispatch is teaming with *emergent features*, propagate uncertainties just like dual numbers with *Measurements.jl*, or units with *Unitful.jl*
  - Easy access to various accelerator backends
  - Pandas-like *DataFrames.jl* and ML in *Lux.jl*
  - Interoperate with your favourite Python packages, but do the heavy lifting in *Julia*
  - High degree of *reproducibility* thanks to *Pkg.jl*
]
]

#slide(title:"But maybe why not Julia?")[
  #one-by-one(start:2)[
  Learning a *new* language can be difficult, especially one as *different* as Julia
][
  - *Pre-compile* times can be frustrating
  - Sometimes *error reporting* is a mess
  - Ecosystem *maturity* still growing
  - Type stability can be subtle and insanity inducing (c.f. Cthulhu.jl)
][
  #boxed(fill-color: JULIA_GREEN)[
    #v(0.2em)
    But it's steadily *getting better*, and seeing *widespread adoption*
    #v(0.2em)
  ]
  Worth glancing at #link("https://julialang.org/blog/2022/02/10years/")[Why we use Julia, 10 years later].
]
]

#slide(title:"Where to find more")[
  #uncover("2-")[
  #boxed(fill-color: JULIA_GREEN)[
    #v(0.2em)
    #align(center)[*Ask me* #uncover("3-")[(at the pub later 🫶)]]
    #v(0.2em)
  ]
]
  #v(-1.0em)
  #uncover("4-")[
  #boxed(fill-color: JULIA_BLUE)[
    #v(0.2em)
    #align(center)[Ask your colleagues *Andy*, *Gloria*, *Matt* ...]
    #v(0.2em)
  ]
]
  #uncover("5-")[
  The #link("https://docs.julialang.org/en/v1/")[Julia Documentation] is full of good things!
  - As is the #link("https://docs.sciml.ai/Overview/stable/")[SciML documentation]
  - I wrote a #link("https://github.com/RSE-Cambridge/julia-study-group/wiki/Resources")[list of resources] for the Cambridge RSE group
  Checkout the #link("https://www.youtube.com/user/JuliaLanguage")[Julia YouTube channel] and join the *Slack*!
  Open *meetup suggestions* for Julia topics in our #link("https://github.com/astro-group-bristol/developer-group")[Astro Developer Group].
  #boxed(fill-color: JULIA_PURPLE)[
    #v(0.2em)
    #align(center)[Keep an eye out for *JuliaCon* 2024!]
    #v(0.2em)
  ]
]
]

#slide(title: "")[
  #v(-6em)
  #align(right, par(leading: 25pt, text(weight: "black", size: 160pt, juliafy("Thank you for listening"))))
  #v(-4em)
]
