-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execScript("6rainbowpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then pAltBarrage(math.random(2, 4), 2) 
	elseif mKey == 1 then pSimpleSpiral(math.random(6, 24), 1)
	elseif mKey == 2 then pBarrageSpiral(math.random(0, 3), 1, 1)
	elseif mKey == 3 then pInverseBarrage(0)
	elseif mKey == 4 then pTunnel(math.random(1, 3))
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 2, 2, 3, 3, 4 }
shuffle(keys)
index = 0
rotation_speed = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2)
    l_setSpeedInc(0.10)
    l_setRotationSpeed(-237000)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)

    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setFastSpin(70)
    l_setSides(360)
    l_setSidesMin(360)
    l_setSidesMax(360)

    l_setIncTime(10)

    l_setPulseMin(70)
    l_setPulseMax(90)
    l_setPulseSpeed(1.03)
    l_setPulseSpeedR(.57)
    l_setPulseDelayMax(9.1)

    --[[l_setPulseMin(70)
    l_setPulseMax(90)
    l_setPulseSpeed(2)
    l_setPulseSpeedR(1)
    l_setPulseDelayMax(5)]]

    l_setBeatPulseMax(17)
    l_setBeatPulseDelayMax(23.8) -- BPM is 145
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	e_messageAdd("Don't touch the walls!",170)
	l_setRotationSpeed(0)
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
	if rotation_speed > 0 then
		rotation_speed = -rotation_speed - 0.1
	else
		rotation_speed = -rotation_speed + 0.1
	end
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
end

function onInput(mFrameTime, mMovement, mFocus, mSwap)
	if mMovement ~= 0 then
		if mMovement == 1 and mSwap then
			l_setRotationSpeed(0.945 + rotation_speed)
		elseif mMovement == -1 and mSwap then
			l_setRotationSpeed(-0.945 + rotation_speed)
		end
		s_setHueInc(-9.45 -10*rotation_speed)
	else
		l_setRotationSpeed(rotation_speed)
		s_setHueInc(-10*rotation_speed)
	end
end