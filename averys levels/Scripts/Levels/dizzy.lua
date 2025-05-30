-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
    if mKey == 0 then pMirrorSpiralDouble(u_rndInt(1, 2), 4)
    elseif mKey == 1 then
        local ot = THICKNESS
        local rd = getRandomDir()
        THICKNESS = THICKNESS * 0.85
        pSpiral(l_getSides(), 8, rd)
        pSpiral(l_getSides(), 8, rd * -1)
        THICKNESS = ot
    end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = {1}
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    if u_getDifficultyMult() > 1.5 then
       -- s_setStyle("reallyDizzy")
        l_setSpeedMult(3.5)
    else
        l_setSpeedMult(2.5)
    end

    l_setSpeedInc(0.1)
    l_setSpeedMax(4.5)
    l_setRotationSpeed(0.95)
    l_setRotationSpeedMax(1.25)
    l_setRotationSpeedInc(0.05)
    l_setDelayMult(1.0)
    l_setDelayInc(0.0)
    l_setFastSpin(75.0)
    l_setSides(20)
    l_setSidesMin(20)
    l_setSidesMax(20)
    l_setIncTime(10)

    l_setPulseMin(66.82)
    l_setPulseMax(96.21)
    l_setPulseSpeed(1.631)
    l_setPulseSpeedR(3.146)
    l_setPulseDelayMax(71.95)

    l_setBeatPulseMax(17)
    l_setBeatPulseDelayMax(3600/165)

    l_setRadiusMin(40)
    --l_setWallSkewRight(-15)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
    addPattern(keys[index])
    index = index + 1

    if index - 1 == #keys then
        index = 1
        shuffle(keys)
    end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
hueIMin = 0.0
hueIMax = 15.0
hueIStep = 0.0065

function onUpdate(mFrameTime)
    if u_getDifficultyMult() > 1 then
        s_setHueInc(s_getHueInc() + hueIStep)
        if(s_getHueInc() > hueIMax) then hueIStep = hueIStep * -1 end
        if(s_getHueInc() < hueIMin) then hueIStep = hueIStep * -1 end
    end
end
