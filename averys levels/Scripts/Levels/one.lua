-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

sideAdd = 1
level = 1
index = 0
keys = { 0, 0, 1, 1, 2, 2, 3, 3, 4, 5, 5 }
shuffle(keys)

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
    if mKey == 1 then
        -- mirror spiral looks bad with 5 sides
        if l_getSides() <= 5 then mKey = 2 end
    elseif mKey == 5 then
        if l_getSides() <= 3 then mKey = 0 end
    elseif mKey == 4 then
        if l_getSides() <= 4 then mKey = 2 end
    end

    if mKey == 0 then 
         pAltBarrage(u_rndInt(3, 5), 2)
    elseif mKey == 1 then
        pMirrorSpiral(u_rndInt(2, 5), getHalfSides() - 3)
    elseif mKey == 2 then
        pBarrageSpiral(u_rndInt(0, 3), 1, 1)
    elseif mKey == 3 then
        pInverseBarrage(0)
    elseif mKey == 4 then
        pTunnel(u_rndInt(1, 3))
    elseif mKey == 5 then
        pSpiral(l_getSides() * u_rndInt(1, 2), 0)
        if l_getSpeedMult() >= 0 then
            t_wait(getPerfectDelayDM(THICKNESS) * 0.5)
        end
    end
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
-- function onStep()
--     cBarrage(getRandomSide())
--     t_wait(getPerfectDelay(THICKNESS) * 10)
-- end
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
    l_setSpeedMult(1.5)
    l_setSpeedMax(4)
    l_setSpeedInc(0.125)
    l_setRotationSpeed(0.0)
    l_setRotationSpeedMax(1.0)
    l_setRotationSpeedInc(0.04)
    l_setDelayMult(1.0)
    l_setDelayInc(0.0)
    l_setFastSpin(0.0)
    l_setSides(3)
    l_setSidesMin(3)
    l_setSidesMax(6)
    l_setIncTime(10)

    l_setPulseMin(75)
    l_setPulseMax(91)
    l_setPulseSpeed(1.2)
    l_setPulseSpeedR(1)
    l_setPulseDelayMax(23.9)

    -- l_setPulseMin(75)
    -- l_setPulseMax(91)
    -- l_setPulseSpeed(2)
    -- l_setPulseSpeedR(1)
    -- l_setPulseDelayMax(0.8275)

    l_setBeatPulseMax(18)
    l_setBeatPulseDelayMax(3600 / 105)

    l_setSwapEnabled(true)

    l_enableRndSideChanges(false)
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
    a_playSound("beep.ogg")

    level = level + 1

    l_setSides(l_getSides() + sideAdd)

    if l_getSides() >= 6 then
        sideAdd = -1
    elseif l_getSides() <= 3 then
        sideAdd = 1
    end

    if l_getSides() == 3 then 
        s_setStyle("one")
    elseif l_getSides() == 4 then 
        s_setStyle("one4")
    elseif l_getSides() == 5 then 
        s_setStyle("one5")
    elseif l_getSides() == 6 then 
        s_setStyle("one6")
    end

    if level == 4 then
        l_setIncTime(15)
    end

    -- e_messageAddImportant("level: "..(extra + 1).." / time: "..incrementTime, 170)
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
end
