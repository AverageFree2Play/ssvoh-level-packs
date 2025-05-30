-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

THICKNESS = 800

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then cWallEx(getRandomSide(), 0) t_wait(getPerfectDelay(THICKNESS)*0.2)
	elseif mKey == 1 then rWallEx(getRandomSide(), 0) t_wait(getPerfectDelay(THICKNESS)*0.3)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 0, 1 }
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(4)
    l_setSpeedInc(0.25)
    l_setRotationSpeed(0.15)
    l_setRotationSpeedMax(0.6)
    l_setRotationSpeedInc(0.05)
    l_setDelayMult(.8)
    l_setDelayInc(-0.01)
    l_setSides(36)
	l_setSidesMin(24)
    l_setSidesMax(36)
    l_setIncTime(15)

	l_setPulseMin(90)
	l_setPulseMax(170)
    l_setPulseSpeed(2)
    l_setPulseSpeedR(6.85) 
    l_setPulseDelayMax(10)

    l_setFastSpin(30)

    l_setBeatPulseMax(20)
    l_setBeatPulseDelayMax(3600/145)

	--l_addTracked("tracker", "delay")

	--setStyleValueFloat("3D_pulse_speed", 0);
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	addPattern(keys[index])
	index = index + 1
	if index - 1 == table.getn(keys) then
		index = 1
	end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- continuous direction change (even if not on level increment)
dirChangeTime = 150

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	dirChangeTime = dirChangeTime - mFrameTime;
	if dirChangeTime < 0 then
		-- do not change direction while fast spinning
		if u_isFastSpinning() == false then
			l_setRotationSpeed(l_getRotationSpeed() * -1)
			dirChangeTime = 100
		end
	end 
	
	--setLevelValueInt("sides", 36)
end