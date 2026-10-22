local map = {
    {".", ".", "."},
    {".", ".", "."},
    {".", ".", "."},
}

local directions = {
    w = { x = 0, y = -1 },
    s = { x = 0, y = 1 },
    a = { x = -1, y = 0 },
    d = { x = 1, y = 0 }
}

local player = {
    name = "Bauk",
    positionX = 2,
    positionY = 2
}

local function renderMap()
    print("---- Map ----")
    for i = 1, #map do
        for j = 1, #map[i] do
            io.write(map[i][j])
        end
        print()
    end
    print("----------")
end

map[player.positionY][player.positionX] = "P"


while true do
    renderMap()
    io.write("Enter a direction (w/a/s/d): ")
    local input = io.read()

    local movement = directions[input]

    if movement then
        local newPositionX = player.positionX + movement.x
        local newPositionY = player.positionY + movement.y

        if newPositionX >= 1 and newPositionX <= #map[1]
            and newPositionY >= 1 and newPositionY <= #map then
                map[player.positionY][player.positionX] = "."
                player.positionX = newPositionX
                player.positionY = newPositionY
                map[player.positionY][player.positionX] = "P"
            else
                print("Invalid move! You can't go outside the map.")
            end
    else
        print("Invalid direction. Use w/a/s/d.")
    end
end
