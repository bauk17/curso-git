local services = require("naval_battle_services")

services.setup()

while true do
  services.drawBoards()

  services.playerTurn()

  if services.countShipsRemaining(services.npc) == 0 then
    print("Congratulations! You won!")
    services.drawBoards(true)
    break
  end

  services.npcTurn()

  if services.countShipsRemaining(services.player) == 0 then
    print("Game over! The NPC won.")
    services.drawBoards(true)
    break
  end

end

