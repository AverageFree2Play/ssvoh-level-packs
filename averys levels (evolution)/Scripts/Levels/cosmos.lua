-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "nextpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "evolutionpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
    hmcSimpleBarrageSNeigh(getRandomSide(), 0, mKey) 
    t_wait(getPerfectDelay(THICKNESS) * 6)
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 2, 2, 2, 1, 1, 1, 0}
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(3.0)
    l_setSpeedInc(0.0)
    l_setRotationSpeed(0.22)
    l_setRotationSpeedMax(0.75)
    l_setRotationSpeedInc(0.03)
    l_setDelayMult(1.5)
    l_setDelayInc(0.0)
    l_setFastSpin(71.0)
    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)
    l_setIncTime(15)

    l_setPulseMin(60.98)
    l_setPulseMax(80.06)
    l_setPulseSpeed(3.597)
    l_setPulseSpeedR(.9)
    l_setPulseDelayMax(7.23)

    l_setBeatPulseMax(19)
    l_setBeatPulseDelayMax(3600/175)

    l_setSwapEnabled(true)
    l_setSwapCooldownMult(0.7/u_getDifficultyMult())
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
    syncCurveWithRotationSpeed(0, 0)
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
function onUpdate(mFrameTime)
end
