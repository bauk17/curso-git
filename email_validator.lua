local emailPattern = "^[^@]+@[^@]+$"-- require a non empty user and domain, with exactly one @

while true do
    print("Type an e-mail:")
    local userEmail = io.read()
    local normalizedEmail = string.lower(string.gsub(userEmail, "%s", ""))
    local result = string.find(normalizedEmail, "@")
    local isValid = string.match(normalizedEmail, emailPattern) ~= nil

    if normalizedEmail == "" then
        print("Please enter an e-mail")
    elseif not isValid then
        print("--------------------------------")
        print("Status: Invalid e-mail")
        print("Normalized E-mail: " .. normalizedEmail)
        print("--------------------------------")
    else
        print("--------------------------------")
        print("Status: Valid e-mail")
        print("User: " .. string.sub(normalizedEmail, 1, result - 1))
        print("Domain: " .. string.sub(normalizedEmail, result + 1, #normalizedEmail))
        print("Normalized E-mail: " .. normalizedEmail)
        print("--------------------------------")
    end
end
