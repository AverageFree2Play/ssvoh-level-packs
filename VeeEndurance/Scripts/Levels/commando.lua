-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
            
extra = 0
incrementTime = 5

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()	
	e_messageAddImportant("level: "..(extra + 1).." / time: "..incrementTime, 170)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	rWallEx(getRandomSide(), extra)
	t_wait(getPerfectDelay(THICKNESS) * 6)
end

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.24)
    l_setSpeedInc(0.0)
    l_setRotationSpeed(0.0)
    l_setRotationSpeedMax(0.0)
    l_setRotationSpeedInc(0.0)
    l_setDelayMult(1.0)
    l_setDelayInc(0.0)
    l_setFastSpin(0.0)
    l_setSides(4)
    l_setSidesMin(0)
    l_setSidesMax(0)
    l_setIncTime(5)

    l_setPulseMin(75)
    l_setPulseMax(91)
    l_setPulseSpeed(2)
    l_setPulseSpeedR(1)
    l_setPulseDelayMax(0.7)

	l_setWallSkewLeft(30)

    l_setBeatPulseMax(17)
    l_setBeatPulseDelayMax(3600/145) -- BPM is 145

    l_addTracked("level", "level")
    l_enableRndSideChanges(false)
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()	
	a_playSound("beep.ogg")
	a_playPackSound("VeeEndurance_test.ogg")
	
	extra = extra + 1
	incrementTime = incrementTime + 2
	
	l_setSides(l_getSides() + 2)
	l_setIncTime(incrementTime)
		
	e_messageAddImportant("level: "..(extra + 1).." / time: "..incrementTime, 170)
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
end