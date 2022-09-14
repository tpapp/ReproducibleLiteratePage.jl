module ReproducibleLiteratePage

export compile_directory

using DocStringExtensions: SIGNATURES
import Literate
import Tar
import Pkg

"Default source file within the directory."
const DEFAULT_SOURCE = "index.jl"

"Default archive."
const DEFAULT_ARCHIVE = "source.tar"

"<div> class for the source footer."
const DIV_CLASS = "source_footer"

"""
$(SIGNATURES)

Put the source, project, and manifest files in `archive_name` using `tar`.
"""
function tar_files(archive_name, dir; source = DEFAULT_SOURCE)
    Tar.create(dir, archive_name) do p
        relpath(p, dir) in ["Project.toml", "Manifest.toml", source]
    end
end

"""
$(SIGNATURES)

Generate a footer for the page, wrapping in [`DIV_CLASS`](@ref).
"""
function generate_footer(archive_name)
    """
    <div class="$(DIV_CLASS)">
    This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).
    Download [the source, project, and manifest]($(archive_name)).
    </div>
    """
end

"""
$(SIGNATURES)

Compile `joinpath(dir, source)` using `Literate.markdown`, put the source, manifest, and
project files in an archive, add it as a footer.
"""
function compile_directory(dir; source = DEFAULT_SOURCE, archive = DEFAULT_ARCHIVE)
    src_file = joinpath(dir, source)
    tar_file = joinpath(dir, archive)
    tar_files(tar_file, dir; source)
    Pkg.activate(dir)
    Literate.markdown(src_file, dir;
                      postprocess = s -> s * generate_footer(tar_file),
                      execute = true,
                      config = Dict("credit" => false), # we add credits back in footer
                      )
end

end # module
