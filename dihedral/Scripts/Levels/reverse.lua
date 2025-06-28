-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execScript("expatterns.lua")
u_execScript("expatterns2.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey ==  0 then pAltBarrage(math.random(2, 4), 2) 
	elseif mKey ==  1 then pMirrorSpiral(math.random(3, 6), 0)
	elseif mKey ==  2 then pBarrageSpiral(math.random(0, 3), 1, 1)
	elseif mKey ==  3 then pBarrageSpiral(math.random(0, 2), 1.2, 2)
	elseif mKey ==  4 then pBarrageSpiral(2, 0.7, 1)
	elseif mKey ==  5 then pInverseBarrage(0)
	elseif mKey ==  6 then pTunnel(math.random(1, 3))
	elseif mKey ==  7 then pMirrorWallStrip(1, 0)
	elseif mKey ==  8 then pWallExVortex(0, 1, 1)
	elseif mKey ==  9 then pDMBarrageSpiral(math.random(4, 7), 0.4, 1)
	elseif mKey == 10 then pRandomBarrage(math.random(2, 4), 2.25)
	elseif mKey == 11 then pBackAndForth(math.random(1,2), 0.85)
	elseif mKey == 12 then pWrapAround(0.8)
	elseif mKey == 13 then pTunnelShort(math.random(2,4))
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 7, 8, 9, 10, 10, 10, 11, 12, 13 }
shuffle(keys)
index = 0
reversal = false

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2)
    l_setSpeedInc(0.1)
    l_setRotationSpeed(0.21)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)

    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setFastSpin(70)
    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)

    l_setIncTime(10)

    l_setPulseMin(80)
    l_setPulseMax(90)
    l_setPulseSpeed(1)
    l_setPulseSpeedR(3)
    l_setPulseDelayMax(10)

    l_setBeatPulseMax(20)
    l_setBeatPulseDelayMax(20)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	s_set3dSkew(0.5)
	s_set3dPulseSpeed(0)
	s_setHueMin(150)
	s_setHueMax(150)
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
	reversal = not reversal
	if reversal then
		s_set3dSkew(-2.25)
		s_setHueMin(300)
		s_setHueMax(300)
	else
		s_setHueMin(150)
		s_setHueMax(150)
		s_set3dSkew(0.4)
	end
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
end