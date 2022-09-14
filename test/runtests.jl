using ReproducibleLiteratePage
using Test

dir = joinpath(@__DIR__, "example")
compile_directory(dir)
result = read(joinpath(dir, "index.md"), String)
@test occursin(ReproducibleLiteratePage.DIV_CLASS, result)
@test isfile(joinpath(dir, "source.tar"))
