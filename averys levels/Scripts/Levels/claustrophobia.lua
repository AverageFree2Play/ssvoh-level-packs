-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "nextpatterns.lua")

level = 0
levelTracked = 1
sides = 0
-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
    if u_getDifficultyMult() >= 2 then
        if mKey == 0 then cBarrage(getRandomSide())
        elseif mKey == 1 then pACBarrageDeception() 
        end
    elseif u_getDifficultyMult() > 1 then
        cBarrage(getRandomSide())
    elseif u_getDifficultyMult() == 1 then
        rWallEx(getRandomSide(), level + 6)
    else
        rWallEx(getRandomSide(), level + 7)
    end
    t_wait(getPerfectDelay(THICKNESS) * 16.55)
end
-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
    if u_getDifficultyMult() >= 2 then
        e_messageAdd("Difficulty = 2\n1 open side only, deception pattern enabled!", 130)
    elseif u_getDifficultyMult() == 1.5 then
        e_messageAdd("Difficulty = 1.5\n1 open side only!", 130)
    elseif u_getDifficultyMult() == 1 then
        e_messageAdd("2 open sides only!", 130)
    else
        e_messageAdd("Difficulty < 1\n4 open sides only!", 130)
    end
    e_messageAddImportant("level: "..(level + 1).." / sides: "..l_getSides(), 170)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
keys = {0,0,0,0,1}
shuffle(keys)
index = 0

function onStep()
    addPattern(keys[index])
    index = index + 1

    if index - 1 == #keys then
        index = 1
        shuffle(keys)
    end
end

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    if u_getDifficultyMult() > 1 then
        l_setSpeedMult(1)
    end
    l_setSpeedMult(2)
    l_setSpeedInc(0.0)
    l_setRotationSpeed(0.0)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)
    l_setDelayMult(1.0)
    l_setDelayInc(0.0)
    l_setFastSpin(0.0)
    if u_getDifficultyMult() >= 1 and u_getDifficultyMult() < 2 then
        l_setSides(16)
    else
        l_setSides(20)
    end
    sides = l_getSides()
    l_setSidesMin(0)
    l_setSidesMax(0)
    l_setIncTime(15)
    l_setFastSpin(71.0)

    l_setPulseMin(75)
    l_setPulseMax(91)
    l_setPulseSpeed(2)
    l_setPulseSpeedR(1) 
    l_setPulseDelayMax(0.8275)

    l_setBeatPulseMax(17)
    l_setBeatPulseDelayMax(3600 / 140) -- BPM is 145

    l_addTracked("levelTracked", "level")
    l_addTracked("sides", "sides")
    l_enableRndSideChanges(false)

   --l_setRadiusMin(40)

    enableSwapIfDMGreaterThan(1)
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
    a_playSound("beep.ogg")

    level = level + 1
    levelTracked = level + 1
    sides = l_getSides()

    l_setSides(clamp(l_getSides()+2,16,30))

    e_messageAddImportant("level: "..(level + 1).." / sides: "..l_getSides(), 170)
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
end
