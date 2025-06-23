-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execScript('arrayPatterns.lua')

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then
		AscendingCheckerboard(math.random(0,20), math.random(4,7));
	elseif mKey == 1 then
		twoHoleBarrage(math.random(0,20), 1);
	elseif mKey == 2 then
		repelBarrage(math.random(0,20), math.random(4,6));
	elseif mKey == 3 then
		obstructedBarrageSpiral(math.random(0,20), 2, math.random(3,5), getPerfectDelay(THICKNESS) * 5);
	elseif mKey == 4 then
		rhombusHollow(math.random(0,20), math.random(1,2), 1.5);
	elseif mKey == 5 then
		rhombusFilled(math.random(0,20), math.random(1,2), 1.5);
	elseif mKey == 6 then
		growingInverseBarrage(math.random(0,20), 2, .8);
	elseif mKey == 7 then
		spreadBarrage(math.random(0,19), 1, 4);
	elseif mKey == 8 then
		narrowBarrage(math.random(0,19), 1, 4);
	elseif mKey == 9 then
		tunnelTowardsCenter(math.random(0,19), 2);
	elseif mKey == 10 then
		spiralPingPongLength(math.random(0,19), math.random(6,10), 1, 4, 1);
	elseif mKey == 11 then
		spiralRandomLength(math.random(0,19), math.random(6,10), 1, 4)
	elseif mKey == 12 then
		eloquentSpiral(math.random(0,19), math.random(10,15), 3, 1)
	elseif mKey == 13 then
		altBarrageSpiral(math.random(0,19), math.random(10,15), math.random(2,5), 1);
	elseif mKey == 14 then
		attractBarrage(math.random(0,19), math.random(4,6));
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 5, 6, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 14, 14}
shuffle(keys)
index = 0
rotation = 0.5

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2)
    l_setSpeedInc(0.2)
    l_setRotationSpeed(0.05)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.1)
    l_setDelayMult(1.1)
	l_setDelayInc(-0.01)
	l_setFastSpin(70)
    l_setSides(20)
    l_setSidesMin(20)
    l_setSidesMax(20)
    l_setIncTime(20)

    l_setPulseMin(68)
    l_setPulseMax(80)
    l_setPulseSpeed(0)
    l_setPulseSpeedR(0)
    l_setPulseDelayMax(8)

    l_setBeatPulseMax(30)
    l_setBeatPulseDelayMax(3600/130)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	s_set3dSkew(0.15)
	s_set3dPulseSpeed(0)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	addPattern(keys[index])
	index = index + 1
	if index - 1 == table.getn(keys) then
		index = 1
	end
	--l_setPulseMax(1 - l_getPulseMax())
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
	rotation = rotation + 0.1
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

dirChangeTime = 100

time = 1;
direction = 1;
rate = math.random() + 0.5;
range = (math.random() * 0.5 + 0.5) * (1/5);
switch = math.random(2, 13);
pingPong = math.random(0,1);
linear = math.random(0,2);
local rotationkey = {0, 0, 0, 1, 2, 2};

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	dirChangeTime = dirChangeTime - mFrameTime;
	time = time + (mFrameTime/20);
	if linear == 2 then
		l_setRotationSpeed(direction * (range/1.2))
	elseif linear == 1 then
		l_setRotationSpeed(direction * (range/1.4) - math.sin(time * 3) * (range/3)) -- Rotation pulse
	else
		if pingPong == 0 then
			l_setRotationSpeed(direction * (math.abs(math.sin(time * rate) * range)));
		else
			l_setRotationSpeed(direction * (math.sin(time * rate) * range))
		end
	end
	if math.floor(time) % switch == 0 then
		switch = math.random(2,13);
		rate = math.random() * 0.8 + 0.2;
		range = (math.random() * 0.25 + 0.5) * rotation;
		pingPong = math.random(0,1);
		linear = rotationkey[math.random(1,#rotationkey)];
	end
	if dirChangeTime < 0 then
		-- do not change direction while fast spinning
		if u_isFastSpinning() == false then
			direction = direction * -1;
			dirChangeTime = 300
		end
	end
end