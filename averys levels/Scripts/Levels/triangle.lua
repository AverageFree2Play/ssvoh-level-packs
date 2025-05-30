-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then pBarrageSpiral(math.random(1, 2), 1, 1) 
	elseif mKey == 1 then pInverseBarrage(0)
	elseif mKey == 2 then pAltBarrage(math.random(1, 3), 2)
	elseif mKey == 3 then pRandomBarrage(math.random(1,4), 3)
	elseif mKey == 4 then pTunnel(math.random(2, 5))
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 2, 2, 3, 4 }
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(3)
    l_setSpeedInc(0.25)
    l_setRotationSpeed(0.2)
    l_setRotationSpeedMax(0.7)
    l_setRotationSpeedInc(0.05)

    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setFastSpin(100)
    l_setSides(3)
    l_setSidesMin(3)
    l_setSidesMax(3)

    l_setIncTime(15)

    l_setPulseMin(120)
    l_setPulseMax(140)
    l_setPulseSpeed(0.5)
    l_setPulseSpeedR(10)
    l_setPulseDelayMax(5)
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

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	l_setSides(3)
end
