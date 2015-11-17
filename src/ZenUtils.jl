"A bunch of domain general functions and macros that I find useful in many different projects"
module ZenUtils

import Base: string, print, println, show, showcompact

export printers,
       unimplemented,
       fields


include("misc.jl")
end
