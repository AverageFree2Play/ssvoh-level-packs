-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

--"gravity" variations of normal patterns
function gravWall(mSide)
	w_wallAcc(mSide, THICKNESS, 2, -0.047, -1, 2)
end

function gravWallEx(mSide, mExtra)
	for i = 0, mExtra do
		gravWall(mSide + i)
	end
end

function rGravWall(mSide)
	gravWall(mSide)
	gravWall(mSide + l_getSides()/2)
end

function rGravWallEx(mSide, mExtra)
	gravWallEx(mSide, mExtra)
	gravWallEx(mSide + l_getSides()/2, mExtra)
end

function cGravBarrageN(mSide, mNeighbors)
	for i = mNeighbors, l_getSides() - 2 - mNeighbors, 1 do
		gravWall(mSide + i + 1)
	end
end

function cGravBarrage(mSide) 
	cGravBarrageN(mSide, 0) 
end

function cGravAltBarrage(mSide, mStep)
	for i = 0, l_getSides() / mStep, 1 do
		gravWall(mSide + i * mStep)
	end
	t_wait(getPerfectDelay(THICKNESS) * 15)
end

function pGravityAltBarrage(mTimes, mStep)
	delay = getPerfectDelay(THICKNESS) * 1.5
	
	for i = 0, mTimes do
		cGravAltBarrage(i, mStep)
		t_wait(delay)
	end
	
	t_wait(delay * 2)
end

function pGravityVortex(mTimes, mStep)
	delay = getPerfectDelay(THICKNESS) * 12.5 
	startSide = getRandomSide()
	loopDir = getRandomDir()
	currentSide = startSide
	
	for j = 0, mTimes do
		for i = 0, mStep do
			currentSide = currentSide + loopDir
			rGravWallEx(currentSide, (l_getSides()/2) - 2)
			t_wait(delay)
		end
		
		loopDir = loopDir * -1
		
		for i = 0, mStep + 1 do
			currentSide = currentSide + loopDir;
			rGravWallEx(currentSide, (l_getSides()/2) - 2)
			t_wait(delay)
		end
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 15.0)
end

function pGravityTunnel(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 7
	startSide = getRandomSide()
	loopDir = getRandomDir()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			w_wallAcc(startSide, myThickness + 5 * getSpeedMult() * delay, 2, -0.047, -1, 2)
		end
		
		cGravBarrage(startSide + loopDir)
		t_wait(delay)
		
		loopDir = loopDir * -1
	end
	
	t_wait(delay * 1.5)
	THICKNESS = oldThickness
end

-- function pGravityInverseBarrage(mTimes)
-- 	delay = getPerfectDelay(THICKNESS) * 17
-- 	startSide = getRandomSide()
	
-- 	for i = 0, mTimes do
-- 		cGravBarrage(startSide)
-- 		t_wait(delay)
-- 		if(l_getSides() < 6) then t_wait(delay * 0.8) end
-- 		cGravBarrage(startSide + getHalfSides())
-- 		t_wait(delay)
-- 	end
	
-- 	t_wait(getPerfectDelay(THICKNESS) * 15)
-- end

function pGravityRandomBarrage(mTimes, mDelayMult)
	side = getRandomSide()
	oldSide = 0
	
	for i = 0, mTimes do	
		cGravBarrage(side)
		oldSide = side
		side = getRandomSide()
		t_wait(3.2 * getPerfectDelay(THICKNESS) * (2 + (getSideDistance(side, oldSide)*mDelayMult)))
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 15)
end

function pGravityBarrageSpiral(mTimes, mDelayMult, mStep)
	delay = getPerfectDelay(THICKNESS) * 10 * mDelayMult
	startSide = getRandomSide()
	loopDir = mStep * getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		cGravBarrage(startSide + j)
		j = j + loopDir
		t_wait(delay)
		if(l_getSides() < 6) then t_wait(delay * 0.6) end
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 15)
end

function pGravityMirrorSpiral(mTimes, mExtra)
	oldThickness = THICKNESS
	THICKNESS = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(THICKNESS) * 3
	startSide = getRandomSide()
	loopDir = getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		rGravWallEx(startSide + j, mExtra)
		j = j + loopDir
		t_wait(delay)
	end
	
	THICKNESS = oldThickness
	
	t_wait(getPerfectDelay(THICKNESS) * 15)
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey ==  0 then pGravityAltBarrage(math.random(2, 4), 2) 
		elseif mKey ==  1 then pGravityRandomBarrage(math.random(2, 4), 1)
		elseif mKey ==  2 then pGravityVortex(math.random(0, 1), 1)
		--elseif mKey ==  4 then pGravityInverseBarrage(math.random(1, 3))
		elseif mKey ==  5 then pGravityBarrageSpiral(math.random(1, 3), 1.3, 1)
		elseif mKey ==  6 then pGravityMirrorSpiral(math.random(3, 6), 1)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 1, 2, 2, 4, 4, 5, 5, 6 }
shuffle(keys)
index = 0
-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.65)
    l_setSpeedInc(0.10)
    l_setRotationSpeed(0.21)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)
    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setSides(8)
	l_setSidesMin(8)
    l_setSidesMax(8)
    l_setIncTime(999999999)

	l_setPulseMin(60)
	l_setPulseMax(100)
    l_setPulseSpeed(1)
    l_setPulseSpeedR(10) 
    l_setPulseDelayMax(10)

    l_setFastSpin(200)

    l_setBeatPulseMax(20)
    l_setBeatPulseDelayMax(30)
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
	--stabilization for mashup
	l_setPulseMin(60)
	l_setPulseMax(100)
    l_setPulseSpeed(1)
    l_setPulseSpeedR(10) 
    l_setPulseDelayMax(10)
    l_setFastSpin(200)
    l_setBeatPulseMax(20)
    l_setBeatPulseDelayMax(30)
end