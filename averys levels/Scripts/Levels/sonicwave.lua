-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

function rWallThick(mSide, THICKNESS)
	w_wall(mSide, THICKNESS)
	w_wall(mSide + getHalfSides(), THICKNESS)
end

function cWallExThick(mSide, mExtra, mThick)
	w_wall(mSide, mThick);
	loopDir = 1;
	
	if mExtra < 0 then loopDir = -1 end
	for i = 0, mExtra, loopDir do w_wall(mSide+i, mThick) end
end
--spawns the back and forth pattern from super hexagon
function pBackAndForth(mTimes, mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		 if i < mTimes then
		 	w_wall(startSide, myThickness + 8 * l_getSpeedMult() * delay)
		 	w_wall(startSide+(l_getSides()/2), myThickness + 8 * l_getSpeedMult() * delay)
		 end
		
		rWallThick(startSide+1, oldThickness*2)
		t_wait(delay*0.5*mDelayMult)
		rWallThick(startSide+2, oldThickness*2)
		t_wait(delay*0.5*mDelayMult)
		
	end
	
	THICKNESS = oldThickness
	t_wait(delay)
end

--it's the weird pattern from super hexagon where you turn 3 then turn 2 then turn 1
function pWrapAround(mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5 * mDelayMult
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	cWallEx(startSide, l_getSides() - 2)
	t_wait(delay)
	cWallEx(startSide + getHalfSides(), l_getSides() - 2)
	cWallExThick(startSide + getHalfSides() + 1, l_getSides() - 4, THICKNESS*2.5)
	w_wall(startSide - 1, myThickness + 8 * l_getSpeedMult() * delay)
	t_wait(delay)
	cWallEx(startSide  + 1, l_getSides() - 4)
	w_wall(startSide + 2, THICKNESS*2)
	t_wait(delay*0.7)
	cWallEx(startSide + getHalfSides() + 1, l_getSides() - 4)
	
	
	THICKNESS = oldThickness
	t_wait(delay)
end

--the fast tunnel pattern from hexagoner
function pTunnelShort(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 3.6
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			w_wall(startSide, myThickness + 10 * l_getSpeedMult() * delay)
		end
		
		cWallExThick(startSide + 3, l_getSides() - 4, oldThickness)
		t_wait(delay*0.65)
		cWallExThick(startSide - 5, l_getSides() - 4, oldThickness)
		t_wait(delay*0.65)
		
	end
	t_wait(delay*2)
	THICKNESS = oldThickness
end

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
keys = { 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 7, 8, 9, 10, 10, 10, 11, 12 }
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.25)
    l_setSpeedInc(0.10)
    l_setRotationSpeed(0.21)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)

    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setFastSpin(70)
    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)

    l_setIncTime(15)

    l_setPulseMin(50)
    l_setPulseMax(80)
    l_setPulseSpeed(1)
    l_setPulseSpeedR(10)
    l_setPulseDelayMax(10)

    --[[l_setPulseMin(70)
    l_setPulseMax(90)
    l_setPulseSpeed(2)
    l_setPulseSpeedR(1)
    l_setPulseDelayMax(5)]]

    l_setBeatPulseMax(20)
    l_setBeatPulseDelayMax(0) -- BPM is 145
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

incrTimes = 0
-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
	incrTimes = incrTimes + 1
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

n = 1200
dir = getRandomDir()
baseRot = 0

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	if n < 0 then
		n = 1200
		dir = dir * -1
	end
	s_setHueMin(n/10)
	s_setHueMax(n/10)
	l_setRotationSpeed((baseRot + 0.05*incrTimes + (1200-n)/1600)*dir)
	--l_setBeatPulseMax(((1200-n)/10) - 30)
	s_set3dPulseSpeed(((1200-n)/1000));
	s_set3dDepth(math.ceil((1200-n)/100));
	s_set3dSpacing(((1200-n)/20));
	s_set3dDarkenMult(600/(1200-n))
	n = n - 1
end