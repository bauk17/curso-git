math.randomseed(os.time()) -- ensure greater result variety in math.random

local config = {
  MAP_SIZE = 7,
  LETTERS_MAP = {
    [1] = "A", [2] = "B", [3] = "C", [4] = "D", [5] = "E",
    [6] = "F", [7] = "G", [8] = "H", [9] = "I", [10] = "J"
  },
  LETTERS_INDEX = {
    A = 1, B = 2, C = 3, D = 4, E = 5, F = 6, G = 7, H = 8, I = 9, J = 10
  }
}

local function createMap()
  local map = {}
  for i = 1, config.MAP_SIZE do
    local row = {}
    for _ = 1, config.MAP_SIZE do
      table.insert(row, ".")
    end
    table.insert(map, row)
  end
  return map
end

local player = createMap()
local npc = createMap()
local services = {}

local function drawLegend()
  print("-------------- LEGEND -------------------")
  print("A = Attacked Area")
  print("X = Hit a ship")
  print(". = Water")
  print("N = Ship")
end

local function drawMap(map, hideShips)
  io.write("   ")
  for i = 1, config.MAP_SIZE do
    io.write(config.LETTERS_MAP[i] .. " ")
  end
  print()

  for index, line in ipairs(map) do
    io.write(string.format("%2d ", index))
    for _, column in ipairs(line) do
      if hideShips and column == "N" then
        io.write(". ")
      else
        io.write(column .. " ")
      end
    end
    print()
  end
end



local function parseCoordinate(coordinate)
  if not coordinate then
    return nil
  end
  local column = string.upper(string.sub(coordinate, 1, 1))
  local row = tonumber(string.sub(coordinate, 2, 2))
  if #coordinate ~= 2 or row == nil or row > config.MAP_SIZE or config.LETTERS_INDEX[column] == nil or row < 1 or config.LETTERS_INDEX[column] > config.MAP_SIZE then
    return nil
  end
  return row, config.LETTERS_INDEX[column]
end

local function attack(targetMap, row, column)
  local cell = targetMap[row][column]

  if cell == "A" or cell == "X" then
    return "already_attacked"
  elseif cell == "N" then
    targetMap[row][column] = "X"
    return "hit"
  elseif cell == "." then
    targetMap[row][column] = "A"
    return "miss"
  end
end

local function placeShip(targetMap, row, column)
  if targetMap[row][column] == "." then
    targetMap[row][column] = "N"
    return true
  end
  return false
end

local function generateRandomCoordinate()
  return math.random(1, config.MAP_SIZE), math.random(1, config.MAP_SIZE)
end

local function setupPlayerFleet(targetMap)
  local shipsLeft = 5
  while shipsLeft > 0 do
    print("-------------- PLAYER MAP -------------------")
    drawMap(player, false)
    print("You gotta choose a position to put your ships. Example: (B3). Positions left: " .. shipsLeft)
    local coordinate = io.read()
    local row, column = parseCoordinate(coordinate)
    if row ~= nil and column ~= nil then
      if placeShip(targetMap, row, column) then
        shipsLeft = shipsLeft - 1
      else
        print("This position is already occupied. Choose another one.")
      end
    else
      print("Invalid coordinate, please try again.")
    end
  end
end

local function setupNpcFleet(targetMap)
  local shipsLeft = 5
  while shipsLeft > 0 do
    local row, column = generateRandomCoordinate()
    if placeShip(targetMap, row, column) then
      shipsLeft = shipsLeft - 1
    end
  end
end

local function drawMove(actor, row, column, result)
  local description = {
    hit = "hit a ship",
    miss = "hit water",
    already_attacked = "coordinate already attacked"
  }
  print("-------------- MOVE -------------------")
  print(actor .. " attacked " .. config.LETTERS_MAP[column] .. row .. ": " .. description[result])
end

local function playerTurn()
  print("    ")
  print("YOUR TURN")
  local attackState = nil
  while attackState ~= "hit" and attackState ~= "miss" do
    io.write("Type a coordinate (ex: B3): ")
    local coordinate = io.read()
    local row, column = parseCoordinate(coordinate)
    if row ~= nil and column ~= nil then
      local result = attack(npc, row, column)
      drawMove("Player", row, column, result)
      attackState = result
    else
      print("Invalid coordinate, please try again.")
    end
  end
end

local function npcTurn()
  print("    ")
  print("NPC TURN")
  local attackState = nil
  while attackState ~= "hit" and attackState ~= "miss" do
    local row, column = generateRandomCoordinate()
    local result = attack(player, row, column)
    if result ~= "already_attacked" then
      drawMove("NPC", row, column, result)
    end
    attackState = result
  end
end

local function countShipsRemaining(map)
  local shipsRemaining = 0
  for _, row in ipairs(map) do
    for _, cell in ipairs(row) do
      if cell == "N" then
        shipsRemaining = shipsRemaining + 1
      end
    end
  end
  return shipsRemaining
end

local function drawBoards(isFinalResult)

  if isFinalResult then
    print("------------------------------ Final Result ------------------------------")
  end


  drawLegend()
  print("-------------- PLAYER MAP | SHIPS REMAINING: " .. countShipsRemaining(player) .. " -------------------")
  drawMap(player, false)

  print("-------------- NPC MAP | SHIPS REMAINING: " .. countShipsRemaining(npc) .. " -------------------")
  drawMap(npc, not isFinalResult)
end

local function setup()
  drawLegend()
  setupPlayerFleet(player)
  setupNpcFleet(npc)
end

services.player = player
services.npc = npc
services.playerTurn = playerTurn
services.npcTurn = npcTurn
services.countShipsRemaining = countShipsRemaining
services.drawBoards = drawBoards
services.drawLegend = drawLegend
services.drawMap = drawMap
services.setup = setup

return services
