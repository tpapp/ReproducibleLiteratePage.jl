# ReproducibleLiteratePage.jl

![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)
[![build](https://github.com/tpapp/ReproducibleLiteratePage.jl/workflows/CI/badge.svg)](https://github.com/tpapp/ReproducibleLiteratePage.jl/actions?query=workflow%3ACI)
[![codecov.io](http://codecov.io/github/tpapp/ReproducibleLiteratePage.jl/coverage.svg?branch=master)](http://codecov.io/github/tpapp/ReproducibleLiteratePage.jl?branch=master)

A simple package to generate a markdown file from Julia source marked up with [Literate.jl](https://github.com/fredrikekre/Literate.jl), with the source, project and manifest files added in a `tar` archive linked at the bottom of the page.

I am using it for my [blog](https://www.tamaspapp.eu), and currently do not plan to register it, but feel free to ask.

## Example

```julia
# +++
# var = 42
# +++

# A file we will compile

1+1
```

will be compiled into

`````markdown
+++
var = 42
+++

A file we will compile

````julia
1+1
````

````
2
````

~~~
<div class="source_footer">
~~~
This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).\
Download [the source, project, and manifest](example_source.tar).
~~~
</div>
~~~
`````

Note the code fence, which can be used to add page variables with [Franklin.jl](https://franklinjl.org/).

## About the package name

The term “reproducible” here refers to the [*explicit environment*](https://pkgdocs.julialang.org/v1/glossary/). Note that despite best effort, *computational results* may not be fully reproducible in Julia (eg floating point results can depend on the architecture and compilation options), and this package does not aim to guarantee anything about that. The purpose of this package is to bundle short code examples with their environment so that users can keep running them in the future as package versions move on.[^1]

[^1]: Note that sources for unregistered packages can also become unavailable.
