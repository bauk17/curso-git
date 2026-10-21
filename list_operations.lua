local list = {1, 9, 35, 410, 700}

print("First value of the list:", list[1])
print("Last value of the list:", list[#list])

list[2] = 1000
list[4] = 2400

table.insert(list, 4000)

print("-----------------------------")
print("All list values")
for key, value in ipairs(list) do
    print(key .. " - " .. value)
end
print("-----------------------------")

local number = 10000

table.insert(list, number)

number = 20000

print("Variable number value:", number)
print("Number's value stored in the list:", list[#list])
