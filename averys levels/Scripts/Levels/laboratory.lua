-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

extra = 0
level = 1
incrementTime = 5

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
    e_messageAddImportant("level: "..level.." / time: "..incrementTime, 170)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
    if math.random(1,2) == 1 then
        if l_getSides()==3 then
            cWall(getRandomSide())
        elseif l_getSides()%2 ~= 0 then
            rWallEx(getRandomSide(), extra-1)
        else
            rWallEx(getRandomSide(), extra)
        end
        t_wait(getPerfectDelay(THICKNESS) * 6)
    else
        cBarrage(getRandomSide())
        t_wait(getPerfectDelay(THICKNESS) * 6.55)
    end
end

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2)
    l_setSpeedInc(0.0)
    l_setRotationSpeed(0.0)
    l_setRotationSpeedMax(0.0)
    l_setRotationSpeedInc(0.0)
    l_setDelayMult(1.0)
    l_setDelayInc(0.0)
    l_setFastSpin(0.0)
    l_setSides(3)
    l_setSidesMin(0)
    l_setSidesMax(0)
    l_setIncTime(incrementTime)

    l_setPulseMin(75)
    l_setPulseMax(91)
    l_setPulseSpeed(2)
    l_setPulseSpeedR(1)
    l_setPulseDelayMax(0.8275)

    l_setBeatPulseMax(17)
    l_setBeatPulseDelayMax(24.8275) -- BPM is 145

    l_setRadiusMin(50)
	l_setWallSkewLeft(30)

    l_addTracked("level", "level")
    l_enableRndSideChanges(false)
    enableSwapIfDMGreaterThan(1)
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
    a_playSound("beep.ogg")
    if l_getSides()%2== 0 then
        extra = extra + 1
    end
    level = level + 1
    incrementTime = incrementTime + 2

    l_setSides(l_getSides() + 1)
    l_setIncTime(incrementTime)

    e_messageAddImportant("level: "..level.." / time: "..incrementTime, 170)
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
end
