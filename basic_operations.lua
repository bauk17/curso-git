local life = 100
local defense = 15
local isDead = false


for attackCount = 1, 5 do
    local attack = math.random(10, 30)
    local damage = math.max(0, attack - defense)

    print("Attack:", attack)

    if attack > 20 then
        print("Critical Hit!")
    end

    print("Damage received:", damage)

    life = life - damage

    print("Remaining life:", life)

    if life <= 0 then
        isDead = true
        print("The player has died.")
        break
    end

    print("--------------------")
end

if isDead then
    print("Result: The Player has died.")
else
    print("Result: The Player survived.")
end

