-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then pAltBarrage(math.random(2, 3), 2) 
	elseif mKey == 1 then pBarrageSpiral(3, 0.6, 1)
	elseif mKey == 2 then pInverseBarrage(0)
	elseif mKey == 3 then pTunnel(math.random(1, 3));
	elseif mKey == 4 then pMirrorWallStrip(1, 0)
	elseif mKey == 5 then pWallExVortex(0, math.random(1, 2), 1)
	elseif mKey == 6 then pDMBarrageSpiral(math.random(4, 7), 0.4, 1)
	elseif mKey == 7 then pRandomBarrage(math.random(2, 5), 2.25)
	elseif mKey == 8 then pMirrorSpiralDouble(math.random(4, 6), 0)
	elseif mKey == 9 then pMirrorSpiral(math.random(2, 4), 0)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 2, 2, 3, 4, 4, 5, 6, 7, 7, 7, 8, 9, 9 }
shuffle(keys)
index = 0
times = 0
direction = 1

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(1.5)
    l_setSpeedInc(0.3)
    l_setRotationSpeed(0.27)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.1)
    l_setDelayMult(1)
	l_setDelayInc(0)
    l_setSides(6)
    l_setSidesMin(5)
    l_setSidesMax(7)
    l_setIncTime(150000000000000000000000000)

    l_setPulseMin(50)
    l_setPulseMax(50)
    l_setPulseSpeed(0)
    l_setPulseSpeedR(0)
    l_setPulseDelayMax(8)

    l_setBeatPulseMax(-66)
    l_setBeatPulseDelayMax(0)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
t_wait(1);
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
	addPattern(keys[math.random(1,#keys)])
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

local dirChangeTime = 100;

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	dirChangeTime = dirChangeTime - mFrameTime;
	times = times + (mFrameTime/120);
	if times < 100 then
		l_setBeatPulseMax(0 - times)
	end
	l_setRotationSpeed(times * direction/150)
	l_setSpeedMult(1.5 + times/120)
	if dirChangeTime < 0 then
		direction = direction * -1
		dirChangeTime = math.random(100,200)
	end 
end