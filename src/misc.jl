fields(x) = [getfield(x, field) for field in fieldnames(x)]

"Splat arguments `@splat(f)` -> `x -> f(x...)`"
macro splat(f)
  :(xs -> $(esc(f))(xs...))
end