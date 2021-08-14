module MeshIO

using GeometryBasics
using ColorTypes
using Printf
import FileIO

using GeometryBasics: raw, value, decompose_normals, convert_simplex
import FileIO: DataFormat, @format_str, Stream, File, filename, stream
import FileIO: skipmagic, add_format

import Base.show

include("io/off.jl")
include("io/ply.jl")
include("io/stl.jl")
include("io/obj.jl")
include("io/2dm.jl")
include("io/msh.jl")

"""
    load(fn::File{MeshFormat}; pointtype=Point3f, uvtype=Vec2f,
         facetype=GLTriangleFace, normaltype=Vec3f)

"""
function load(fn::File{format}; element_types...) where {format}
    open(fn) do s
        skipmagic(s)
        load(s; element_types...)
    end
end

function save(fn::File{format}, msh::AbstractMesh; element_types...) where {format}
    open(fn, "w") do s
        save(s, msh; element_types...)
    end
end

if Base.VERSION >= v"1.4.2"
    include("precompile.jl")
    _precompile_()
end

end # module
