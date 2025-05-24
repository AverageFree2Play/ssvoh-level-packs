-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "nextpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
    -- Polyhedrug patterns
    if mKey == 0 then pTrapBarrage(u_rndInt(0, l_getSides()))
    elseif mKey == 1 then pTrapBarrageDouble(u_rndInt(0, l_getSides()))
    elseif mKey == 2 then pTrapBarrageInverse(u_rndInt(0, l_getSides()))
    elseif mKey == 3 then pTrapBarrageAlt(u_rndInt(0, l_getSides()))
    -- Incongruence patterns
    elseif mKey == 4 then pBarrage()
    elseif mKey == 5 then pRCBarrageDouble()
    elseif mKey == 6 then pBarrageSpiral(math.random(1, 2), 0.8)
    elseif mKey == 7 then
        if (l_getSides() > 8) then pAltBarrage(math.random(2, 3), 3, 0.75)
        else pAltBarrage(math.random(2, 3), 2, 0.75)
        end
    -- "Dynamic" Patterns
    elseif mKey == 8 then pRCAscendBarrageRandom(lowerBound, upperBound)
    elseif mKey == 9 then pRCAscendBarrage(getRandomSide(), lowerBound, upperBound)
    elseif mKey == 10 then pRCDynamicAltBarrage(2, math.random(3, 4), lowerBound, upperBound)
    end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 6, 7}
shuffle(keys)
index = 0
lowerBound = 4
upperBound = 5
level = 1
extra = 0
incrementTime = 10
last = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2)
    l_setSpeedInc(0.0)
    l_setRotationSpeed(0.27)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)
    l_setDelayMult(1.1)
    l_setDelayInc(0)
    l_setFastSpin(71.0)
    l_setSides(4)
    l_setSidesMin(0)
    l_setSidesMax(0)
    l_setIncTime(incrementTime)

    l_setPulseMin(64)
    l_setPulseMax(84)
    l_setPulseSpeed(1.05)
    l_setPulseSpeedR(1.34)
    l_setPulseDelayMax(1.74)

    l_setBeatPulseMax(15)
    l_setBeatPulseDelayMax(getBPMToBeatPulseDelay(170))

    l_addTracked("lowerBound", "min")
    l_addTracked("upperBound", "max")
    l_addTracked("level", "level")
    l_addTracked("incrementTime", "Time")

    l_enableRndSideChanges(false)
    l_setSwapEnabled(true)

    l_setSwapCooldownMult(1 / u_getDifficultyMult())
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
    if (u_getDifficultyMult() >= 1) then
        keys[#keys + 1] = 8
        keys[#keys + 1] = 8
        if (u_getDifficultyMult() > 1) then
            s_setStyle("hyperpolygruence")
            e_messageAdd("Hyper mode enabled\n\"Dynamic\" patterns enabled!", 130)
            keys[#keys + 1] = 9
            keys[#keys + 1] = 10
        end
        shuffle(keys)
    end
    e_messageAddImportant("Sides: "..lowerBound.." - "..upperBound.."\nlevel: "..(extra + 1).." / time: "..incrementTime, 170)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
    local mKey = keys[index]
    l_setSides(u_rndInt(lowerBound, upperBound))
    if last == 1 and mKey < 4 then
       t_wait(getPerfectDelay(THICKNESS)*8)
    end

    addPattern(mKey)
    index = index + 1

    if index - 1 == #keys then
        index = 1
        shuffle(keys)
    end


    if mKey > 3 then
        last = 1
    else
        last = 0
    end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
    extra = extra + 1
    level = level + 1
    incrementTime = incrementTime + 5
    lowerBound = math.floor(u_rndInt(4, 6))
    upperBound = math.floor(lowerBound + u_rndInt(1, 4))
    l_setIncTime(incrementTime)
    t_clear()
    if level == 4 then
        l_setIncTime(15)
    end
    if level == 6 then
        s_setStyle("hyperpolygruence")
    end
    e_messageAddImportant("Sides: "..lowerBound.." - "..upperBound.."\n level: "..(extra + 1).." / time: "..incrementTime, 170)
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- continuous direction change (even if not on level increment)
dirChangeTime = 400
hueIMin = 0.0
hueIMax = 22.0
hueIStep = 0.0065

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
    dirChangeTime = dirChangeTime - mFrameTime;
    if dirChangeTime < 0 then
        -- do not change direction while fast spinning
        if u_isFastSpinning() == false then
            l_setRotationSpeed(l_getRotationSpeed() * -1.0)
            dirChangeTime = 400
        end
    end

    s_setHueInc(s_getHueInc() + hueIStep)
    if(s_getHueInc() > hueIMax) then hueIStep = hueIStep * -1 end
    if(s_getHueInc() < hueIMin) then hueIStep = hueIStep * -1 end
end
