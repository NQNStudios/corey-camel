require "problem"

local distance = 250

while bananasRemain() do
    takeMax()

    moveTo(corey.position + math.min(distance, corey.bananas))

    drop(corey.bananas - distance)

    moveToNearestStash(oasis)

    printStatus()
end
