-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then pAltBarrage(math.random(2, 4), 2) 
	elseif mKey == 1 then pMirrorSpiral(math.random(2, 5), getHalfSides() - 3)
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

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(1.55)
    l_setSpeedInc(0.125)
    l_setSpeedMax(4.75)
    l_setRotationSpeed(0.07)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.04)
    l_setDelayMult(1.0)
    l_setDelayInc(-0.01)
    l_setFastSpin(0.0)
    l_setSides(6)
    l_setSidesMin(5)
    l_setSidesMax(6)
    l_setIncTime(15)

    l_setPulseMin(75)
    l_setPulseMax(91)
    l_setPulseSpeed(1.2)
    l_setPulseSpeedR(1)
    l_setPulseDelayMax(23.9)

    l_setBeatPulseMax(17)
    l_setBeatPulseDelayMax(26.67) -- BPM is 135, 3600/135 is 26.67
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	if u_getDifficultyMult() == 1 then
        e_messageAdd("tutorials are over", 130)
        e_messageAdd("good luck getting high scores!", 130)
    end
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

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
end