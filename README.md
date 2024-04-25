# An informal introduction to Julia

Download the slides from [the latest release](https://github.com/astro-group-bristol/julia-intro/releases/latest).

To setup Julia, install from [Julia Homepage](https://julialang.org/downloads/), or with your distribution package manager of choice.

To gather all dependencies to run the examples, in the root directory start Julia:
```bash
$ julia -q
julia>

# hit the `]` key
julia>]

(@v1.10)> activate .
(julia-intro)> instantiate
```

This will grab all of the dependencies from the `Project.toml` (with the specific versions locked in the `Manifest.toml`).

---

Montserrat font by [Julieta Ulanovsky](https://github.com/JulietaUla/Montserrat), licensed under SIL OFL.
