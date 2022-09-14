using ReproducibleLiteratePage
using Test

@testset "sanity check" begin
    # paths
    dir = joinpath(@__DIR__, "example")
    md_file = joinpath(dir, "index.md")
    tar_file = joinpath(dir, "example_source.tar")

    # cleanup before tests, so that local testing does not pass spuriously
    rm(md_file; force = true)
    rm(tar_file; force = true)

    # compile and basic checks
    compile_directory(dir)
    result = read(md_file, String)
    @test occursin(ReproducibleLiteratePage.DIV_CLASS, result)
    @test isfile(tar_file)

end
