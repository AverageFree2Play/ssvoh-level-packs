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
direction = 1;
zoom = 0;
rotation = 0.3;
debounce = false;

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
	if u_getDifficultyMult() > 2.4 then
		l_setSpeedInc(0);
	else
		l_setFastSpin(100)
		l_setSpeedInc(0.05);
	end

    l_setSpeedMult(1.5)
    l_setRotationSpeed(0.2)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0)
    l_setDelayMult(1)
    l_setDelayInc(0)
    l_setSides(6)
	l_setSidesMin(6)
    l_setSidesMax(6)
    l_setIncTime(20)

	l_setPulseMin(60)
	l_setPulseMax(1000)
    l_setPulseSpeed(0)
    l_setPulseSpeedR(0) 
    l_setPulseDelayMax(0)

    l_setBeatPulseMax(0)
    l_setBeatPulseDelayMax(11111)

    l_addTracked("level", "Intensity")

	disableSpeedIncIfDMGreaterThan(2.4)
	enableSwapIfDMGreaterThan(2.5)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
	pattern = pattern + 1
	addPattern(keys[index])
	index = index + 1;
	--[[if pattern == 15 then
		pattern = 0;
		level = level + 1;
		rotSpeed = rotSpeed * 1.3;
		messageImportantAdd("Level: "..level.."\nRotation Speed:"..rotSpeed, 120);
	end]]
	if index - 1 == table.getn(keys) then
		index = 1
	end
	
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
	zoom = 50
	level = level + 1;
	if level < 12 then
		e_messageAddImportant("Intensity: "..level, 90)
	else
		e_messageAddImportant("Intensity: Max", 90)
	end
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

local dirChangeTime = 200;
something = 0;
hueIMin = 0.0
hueIMax = 22.0
hueIStep = 0.0065

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	dirChangeTime = dirChangeTime - mFrameTime;
	something = something + mFrameTime/(15 - math.min(12, level));
	zoom = math.sin(something) * 50 + 60; 
	rotation = .1 * level;
	l_setPulseMin(zoom) 
	-- Thanks to some long ago advice from Alpha | Promethium, instead of using beatpulse, we use radius_min and we get a perfect result!
	--hexagonsize = -.00000283*(math.pow(getLevelValueFloat("pulse_min"),4))+.0012347883*(math.pow(getLevelValueFloat("pulse_min"),3))-.201486*(math.pow(getLevelValueFloat("pulse_min"),2))+14.9919*getLevelValueFloat("pulse_min")-401.876;
	--hexagonsize = -.22678571 * (getLevelValueFloat("pulse_min") * getLevelValueFloat("pulse_min")) + 21.675 * getLevelValueFloat("pulse_min") - 503;
	l_setRadiusMin(zoom)
	--l_setRadiusMax(10000)
	if dirChangeTime < 0 then
		-- do not change direction while fast spinning
		if u_isFastSpinning() == false then
			direction = direction * -1;
			dirChangeTime = math.random(120,400);
		end
	end 
	l_setRotationSpeed(rotation * direction);

	if u_getDifficultyMult() > 2.4 then
		s_setHueInc(s_getHueInc() + hueIStep)
		if(s_getHueInc() > hueIMax) then hueIStep = hueIStep * -1 end
		if(s_getHueInc() < hueIMin) then hueIStep = hueIStep * -1 end
	end
end