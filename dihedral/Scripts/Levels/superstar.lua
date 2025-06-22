-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "nextpatterns.lua")

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
	elseif mKey == 9 then pRandomBarrage(math.random(2, 4), 2.25)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 2, 2, 3, 4, 4, 5, 6, 7, 7, 7, 8, 9, 9 }
shuffle(keys)
index = 0;
pattern = 0;
level = 1;
rotSpeed = 0.2;

curvature = 666;
curve = curvature;
speed = 7;
-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.1)
    l_setSpeedInc(0.05)
    l_setRotationSpeed(0.2)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0)
    l_setDelayMult(1.1)
	l_setDelayInc(0)
    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)
    l_setIncTime(25000000000000000000)

    l_setPulseMin(60)
    l_setPulseMax(80)
    l_setPulseSpeed(1)
    l_setPulseSpeedR(1)
    l_setPulseDelayMax(0)

	l_addTracked("level","level")

    l_setBeatPulseMax(0)
    l_setBeatPulseDelayMax(0)
	l_setRotation(0)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	--[[for r = 1,120 do
		for i = 1,getSides(),2 do
			wallSAcc(i  + ((200-r) * r * getSides() * dir), 10, -0.0666 - (r * (0.001 * (r/50))), 0, maxSpeed);
			--wallSAcc(i  + ((200-r) * r * getSides()) , 10, -0.067 - (r * (0.001 * (r/100))), 0, 3);
		end
	end]]
	for r = 1,150 do
		for i = 1, l_getSides() do
			w_wallAcc(i+(r*curvature), 1, speed, -0.39, 0, 25)
		end
		speed = speed - .02
		if r%5 == 0 then
			t_wait(1)
		end
	end
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
	-- l_setWallAngleLeft(5)
	-- l_setWallAngleRight(6)
	l_setWallSkewLeft(30)

	pattern = pattern + 1;
	addPattern(keys[index])
	index = index + 1;
	if pattern == 10 then
		pattern = 0;
		level = level + 1;
		rotSpeed = rotSpeed * 1.2;
		l_setRotationSpeed(rotSpeed);
		a_playSound("increment.ogg")
		a_playSound("levelUp.ogg")
		e_messageAddImportant("Level: "..level.."\nRotation Speed:"..math.floor(rotSpeed * 100)/100, 120);
	end
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

local arrowPosition = 0;
dirChangeTime = 100;
-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	dirChangeTime = dirChangeTime - mFrameTime;
	if dirChangeTime < 0 then
		-- do not change direction while fast spinning
		if u_isFastSpinning() == false then
			l_setRotationSpeed(l_getRotationSpeed() * -1.0)
			dirChangeTime = 300
		end
	end 
end