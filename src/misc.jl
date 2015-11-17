type Counter
  X::Int64
end

GLOBAL_COUNTER = Counter(0)
inc(c::Counter) = c.X +=1
genint() = (inc(GLOBAL_COUNTER);GLOBAL_COUNTER.X-1)
genvar(prefix="x") = "$prefix$(genint())"
restart_counter!() = GLOBAL_COUNTER.X = 0

"Generate printers for a type `T` which depend on `string(T)`"
function printers(T::Type)
  @eval print(io::IO, x::$T) = print(io, string(x))
  @eval println(io::IO, x::$T) = println(io, string(x))
  @eval show(io::IO, x::$T) = print(io, string(x))
  @eval showcompact(io::IO, x::$T) = print(io, string(x))
end

macro unimplemented()
  error("not yet implemented")
end

fields(X) = [getfield(X, field) for field in fieldnames(X)]

function implementme()
  error("this interface should be imlemented for the appropriate types")
end
