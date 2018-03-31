"""
Inverse concatenation (i.e. splitting) of `xs` up into len(cellsiz) parts

```jldoctest
julia> x = collect(1:6)
julia> FluxAddons.invcat(x, [1,2,3])
3-element Array{Array{Int64,1},1}:
 [1]      
 [2, 3]   
 [4, 5, 6]
```
"""
function invcat(xs::T, cellsizes, dim=1) where T
  @pre sum(cellsizes) == size(xs, dim)
  slices = T[]
  lb = 1
  for x in cellsizes
    ub_ = lb + x
    push!(slices, slicedim(xs, dim, lb:ub_- 1))
    lb = ub_
  end
  slices
end
