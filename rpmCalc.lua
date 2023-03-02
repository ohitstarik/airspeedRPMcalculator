--[[
    This is supposed to calculate the top speed of an "aircraft" based on "inputs" and other "massively guessed" things
    Not at all accurate. Only use as a back of the napkin calculator
    Initially based on one single test on a cheap irotor 350kv motor spinning an apc 15x7 that is a clone of an rctimer 350kv motor. 
    Flown on an extremely draggy R.i. Wings Sequoia, on 6S. 


    Declare some constants. These were taken from iRotor 350kV flying 6s at top speed 16m/s with a 15x7e propeller:
        Motor efficiency: 90%. This, multiplied with the kV is what the motor will actually spin at in the real world.
        prop efficiency: 75%. This, multiplied with the prop pitch, is how far the propeller will actually move forward in one revolution in the real world.
    Take in what the user wants to calculate FOR
        required motor kv
        airspeed
        prop pitch
    Ask for inputs
    Convert units
    Calculate:
        If calculating for motor KV required
            RPM = 60 * ( Airspeed / (Prop pitch (Conv to Meters) * PropEfficiency) )
            KV = (RPM / Nominal Batt Voltage ) / MotorEfficiency
        Calculating for output airspeed
            Airspeed = ((MotorKV * Nominal Batt Voltage) / 60) * (Prop Pitch (Converted to Meters) * PropEfficiency)
        Calculating for Required Prop Pitch
            Prop Pitch = Airspeed in M.s / ( MotorKV * Nominal Batt Voltage / 60 )

    THIS THIRD ONE IS SO SO SO SO STUPID MORE THAN THE OTHER ONES I JUST DID IT SO I COULD GET THE EXERCISE

    End
--]]

MotorEfficiency = .9
PropEfficiency = .75
BatteryCells = 6

function InchToMeters(ToConvert)
    InMeters = ToConvert / 39.37
    return InMeters
end

function MetersToInch(ToConvert)
    InInches = ToConvert * 39.37
    return InInches
end

print("What would you like to calculate for?")
print("\nRequired kV:       Output Airspeed:         Required Prop Pitch:")
print("      1                    2                          3       \n")
CalculateFor = io.read()

if CalculateFor == "1" then
    print("\n####   Calculating for Required Motor kV   ####\n\nEnter desired Airspeed in m/s")
    local Airspeed = io.read()
    print ("\nEnter Propeller Pitch:")
    PropPitch = io.read() * PropEfficiency
    InchToMeters(PropPitch)
    local RPM = 60 * (Airspeed / InMeters)
    local KV = (RPM / (BatteryCells * 3.7)) / MotorEfficiency
    print("\n\nThe propeller will be spinning at " .. RPM .. " RPMs at " .. Airspeed .. " m/s.\n\nOn a " .. BatteryCells .. "s System, you will need a " .. KV .. " kV motor\n\n")

elseif CalculateFor == "2" then
    print("\n####   Calculating for Output Airspeed   ####\n\nEnter motor kV")
    local KV = io.read() * MotorEfficiency
    print ("\nEnter Propeller Pitch:")
    local PropPitch = io.read() * PropEfficiency
    InchToMeters(PropPitch)
    local Airspeed = ((KV * (BatteryCells * 3.7)) / 60 ) * InMeters
    print ("\n\nYour output airspeed is " .. Airspeed .. "")

elseif CalculateFor == "3" then
    print("\n####   Calculating for required propeller pitch   ####\n\nEnter motor kV")
    local KV = io.read() * MotorEfficiency
    print ("\nEnter Desired Airspeed:")
    local Airspeed = io.read()

    local PropPitch = MetersToInch((Airspeed / ( ( KV * ( BatteryCells * 3.7 ) ) / 60 ) ) / PropEfficiency)
    print ("\n\nYour Required Prop Pitch is " .. PropPitch .. "")

else
    print("\nInput a proper number")
    print(CalculateFor)
    return 0
end

