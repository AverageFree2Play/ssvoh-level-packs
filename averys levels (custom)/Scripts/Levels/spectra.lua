-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "evolutionpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "nextpatterns.lua")

--patterns used to block vision
function blockWall(mSide)
	w_wallAcc(mSide, THICKNESS * 3, 2.75, -0.06, 0, 2)
end

function pBlock(mSide, mTimes, mDelayMult)
	for i = 0, mTimes do
		blockWall(mSide + i)
		t_wait(getPerfectDelay(THICKNESS) * 3 * mDelayMult)
	end
end

function blockWall2(mSide)
	w_wallAcc(mSide, THICKNESS * 10, 1.65, -0.06, 0, 2.5)
end

function pBlock2(mSide, mTimes, mDelayMult)
	for i = 0, mTimes do
		blockWall2(mSide + i)
		t_wait(getPerfectDelay(THICKNESS) * 3 * mDelayMult)
	end
end

function distWall(mSide)
	w_wallAcc(mSide, THICKNESS * 1.5, 1.7, -0.05, 0, 2)
end

function pDistract()
	for i = 0, l_getSides() - 1 do
		distWall(i)
		t_wait(getPerfectDelay(THICKNESS) * 1.5)
	end
	t_wait(getPerfectDelay(THICKNESS) * 5)
end

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
--[[function addPattern(mKey)    

    hmcSimpleBarrageSNeigh(getRandomSide(), l_getRotationSpeed()*20, 1) 
    t_wait(getPerfectDelay(THICKNESS) * 6)
end]]
function addPattern(mKey)
	if mKey == 1 then pBackAndForth(math.random(1,2), 0.85)
	elseif mKey == 2 then pWrapAround(0.8)
	elseif mKey == 3 then pTunnelShort(math.random(2,4))
	end
end


-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = {1, 2, 2, 3, 3}
shuffle(keys)
index = 0
-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.65)
	l_setDelayMult(1.1)
    l_setDelayInc(-0.01)

	l_setSides(6)
	l_setSidesMin(6)
	l_setSidesMax(6)
    l_setIncTime(1000000000)

	l_setSpeedInc(0.1)
    l_setSpeedMax(4)
    l_setRotationSpeed(0)
    l_setRotationSpeedMax(0.9)

	l_setPulseMin(70)
    l_setPulseMax(90)
    l_setPulseSpeed(1.03)
    l_setPulseSpeedR(0.57)
    l_setPulseDelayMax(9.1)

	l_setBeatPulseMax(20)
    l_setBeatPulseDelayMax(3600/130)
    l_setBeatPulseSpeedMult(1.35) -- Slows down the center going back to normal

    l_addTracked("rotSpeedIMax", "Rotation Speed")

	--setStyleValueFloat("3D_pulse_speed", 0);
    --l_setSwapEnabled(true)

    l_setSwapCooldownMult(0.6)
end
-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	pBlock(getRandomSide(), 5, 1.2)
	pBlock2(getRandomSide(), 5, 1.2)
	--pDistract()
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
	enableSwapIfSpeedGEThan(5);
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

function increment()
    a_playSound("levelUp.ogg")
    rotSpeedIMin = clamp(rotSpeedIMin - 0.05,-1,1)
    rotSpeedIMax = clamp(rotSpeedIMax + 0.05,-1,1)
    pACBarrageDeception()
end

-- onUpdate is an hardcoded function that is called every frame
rotSpeedIMin = -0.5
rotSpeedIMax = 0.5
rotSpeedIStep = 0.00025

function onUpdate(mFrameTime)
    if(l_getRotationSpeed() > rotSpeedIMax) then 
        rotSpeedIStep = rotSpeedIStep * -1
        increment()
    end
    if l_getRotationSpeed() == 0 then
        a_playSound("beep.ogg")
        a_playSound("increment.ogg")
    end
    if(l_getRotationSpeed() < rotSpeedIMin) then 
        rotSpeedIStep = rotSpeedIStep * -1
        increment()
    end

	l_setRotationSpeed(l_getRotationSpeed()+rotSpeedIStep)
end