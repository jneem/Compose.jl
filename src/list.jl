
# Basic list

abstract List{T}

immutable ListNil{T} <: List{T} end


copy{T}(l::ListNil{T}) = l


immutable ListNode{T} <: List{T}
    head::T
    tail::List{T}
end


copy{T}(l::ListNode{T}) = ListNode{T}(l.head, l.tail)


head(l::ListNode) = l.head
tail(l::ListNode) = l.tail


# iterator
function start(l::List)
    l
end


function next(::List, l::List)
    (l.head, l.tail)
end


function done(::List, l::List)
    typeof(l) <: ListNil
end


function cons{T}(value, l::List{T})
    ListNode{T}(value, l)
end


function length{T}(l::List{T})
    n = 0
    while typeof(l) != ListNil{T}
        n += 1
        l = l.tail
    end
    n
end


function cat{T}(a::List{T}, b::List{T})
    if a === nothing
        b
    else
        a = copy(a)
        u = a
        while !is(u.tail, nothing)
            u.tail = copy(u.tail)
            u = u.tail
        end
        u.tail = b
        a
    end
end


function list{T}(xs::AbstractArray{T})
    l = ListNil{T}
    for x in xs
        l = cons(x, l)
    end
    l
end


function show{T}(io::IO, a::List{T})
    print(io, "List([")
    while typeof(a) != ListNil{T}
        print(io, a.head)
        if typeof(a.tail) != ListNil{T}
            print(io, ", ")
        end
        a = a.tail
    end
    print(io, "])")
end



