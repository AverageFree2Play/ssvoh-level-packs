-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

level = 0
incrementTime = 3

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()	
	e_messageAddImportant("level: "..(level + 1).." / time: "..incrementTime, 170)
end

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.24)
    l_setSpeedInc(0.0)
    l_setRotationSpeed(0.0)
    l_setRotationSpeedMax(0.7)
    l_setRotationSpeedInc(0.0)
    l_setDelayMult(1.0)
    l_setDelayInc(0.0)
    l_setFastSpin(0.0)
    l_setSides(3)
    l_setSidesMin(0)
    l_setSidesMax(0)
    l_setIncTime(5)

    l_setPulseMin(54)
    l_setPulseMax(94)
    l_setPulseSpeed(2.25)
    l_setPulseSpeedR(.54)
    l_setPulseDelayMax(0.7)

    l_setBeatPulseMax(17)
    l_setBeatPulseDelayMax(3600/145) -- BPM is 145

    l_setRadiusMin(40)
    l_addTracked("levelTracked", "level")
    l_enableRndSideChanges(false)

    --enableSwapIfDMGreaterThan(1)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	cBarrage(getRandomSide())
	t_wait(getPerfectDelay(THICKNESS) * 6.55)
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()	
	a_playSound("beep.ogg")
	a_playPackSound("VeeEndurance_test.ogg")
	
	level = level + 1
	incrementTime = incrementTime + 2
	
	l_setSides("sides", l_getSides() + 1)
	l_setIncTime(incrementTime)
	--if level < 6 then setLevelValueFloat("rotation_speed", getLevelValueFloat("rotation_speed") + 0.1) end
		
	e_messageAddImportant("level: "..(level + 1).." / time: "..incrementTime, 170)
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
end