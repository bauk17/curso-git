local users = {
}

local function validateUser(name, age)
    if #name < 4 then
        return false, "Name must contain at least 4 characters."
    elseif age < 18 then
        return false, "User must be at least 18 years old"
    else
        return true
    end
end

local function newUser(name, age)
    local isValid, validateError = validateUser(name, age)
    if not isValid then
        print("Invalid User: " .. validateError)
        return
    end
    table.insert(users, {
            name = name,
            age = age
    })
    print("Status: New user created")
end

local function deleteUser(index)
    if users[index] == nil then
        print("Insert a valid index to delete a User")
        return
    end
    table.remove(users, index)
end

local function getAllUsers()
    for index, value in ipairs(users) do
        print(index .. " - Name: " .. value.name .. " - Age: " .. value.age)
    end
end

newUser("Ana Maria", 18)
newUser("Joao", 18)


newUser("Ana", 20)
newUser("Maria", 17)

print("\nUsers before removal:")
getAllUsers()

deleteUser(2)

print("\nUsers after removal:")
getAllUsers()

