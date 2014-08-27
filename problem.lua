--[[
Corey Camel lives in a desert oasis 1000 miles from the nearest market.
At her oasis, Corey has 3000 bananas which are worth their weight in gold.
Unfortunately, Corey Camel can only carry 1000 bananas at once, and for
every mile Corey travels, she must eat 1 banana to survive. What is the
maximum number of bananas Corey can bring to the market?
]]--

oasis = 0
market = 1000

corey = {
    position = oasis,
    bananas = 0
}

trail = { }

-- populate the trail to the market with bananas
for m = oasis, market do
    if m == oasis then
        trail[m] = 3000
    else
        trail[m] = 0
    end
end

function printStatus()
    if corey.bananas < 0 then
        print("An error occurred while calculating!")
    end

    print("Corey position: " .. corey.position)
    print("Corey's bananas: " .. corey.bananas)
    print("Bananas taken to market: " .. trail[market])
end

function bananasRemain()
    local sum = 0

    for m = oasis, market do
        sum = sum + trail[m]
    end

    return sum + corey.bananas > 0
end

function moveTo(m)
    assert(corey.position ~= m)

    local distance = math.abs(corey.position - m)
    corey.bananas = corey.bananas - distance
    corey.position = m

    assert(corey.bananas >= 0)
    assert(corey.position == m)
end

function moveToNearestStash(searchEnd)
    local smallestDistance = 1001 -- literally every stash will beat this 
    local nearestStash = 0

    for m = corey.position, searchEnd do
        local distance = math.abs(corey.position - m)

        if trail[m] > 0 and distance < smallestDistance and distance > 0 then
            smallestDistance = distance
            nearestStash = m
        end
    end

    moveTo(nearestStash)
end

function drop(b)
    corey.bananas = corey.bananas - b
    trail[corey.position] = trail[corey.position] + b
end

function dropMax()
    drop(corey.bananas)
end

function take(b)
    corey.bananas = corey.bananas + b
    trail[corey.position] = trail[corey.position] - b
end

function takeMax()
    local capacity = 1000 - corey.bananas
    take(math.min(capacity, trail[corey.position]))
end
