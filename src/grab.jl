"mod.s = val"
setinmod!(s::Symbol, val, mod=Main) = Base.eval(mod, :($s = $val))

"Global capture into Main

```
function f(x)
  x = 2x + 3
  @grab x
  y = 3x*2
end

x_grab
"
macro grab(var::Symbol)
  @show var
  grabname = Symbol(var, :_grab)
  :(setinmod!($(Meta.quot(grabname)), $(esc(var))))
end

"""Global capture into Main

```jldoctest
julia> function f(x)
         @grab x = 2x + 3
         y = 3x*2
       end
f (generic function with 1 method)

julia> f(10)
138

julia> x_grab
23
````
x_grab
"""
macro grab(assignexpr::Expr)
  @pre assignexpr.head == :(=) "Must be assignment expression"
  var = assignexpr.args[1]
  grabname = Symbol(var, :_grab)
  quote
    $(esc(assignexpr))
    setinmod!($(Meta.quot(grabname)), $(esc(var)))
  end
end

export @grab