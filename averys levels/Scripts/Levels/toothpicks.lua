-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

--"toothpick" variations of common patterns
function pToothpicks(mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 1.5 * mDelayMult
	startSide = getRandomSide()
	THICKNESS = myThickness/10
	
	cWallEx(startSide, l_getSides()-3);
	
	THICKNESS = oldThickness
	t_wait(delay*2)
end

function pAltBarrageT(mTimes, mStep)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(THICKNESS) * 4
	THICKNESS = myThickness/10
	
	for i = 0, mTimes do
		cAltBarrage(i, mStep)
		t_wait(delay)
	end
	t_wait(delay)
	THICKNESS = oldThickness
end

function pMirrorSpiralT(mTimes, mExtra)
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS)
	THICKNESS = oldThickness/10
	startSide = getRandomSide()
	loopDir = getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		rWallEx(startSide + j, mExtra)
		j = j + loopDir
		t_wait(delay)
	end
	
	THICKNESS = oldThickness
	
	t_wait(getPerfectDelay(THICKNESS) * 6.5)
end

function pRandomBarrageT(mTimes, mDelayMult)
	oldThickness = THICKNESS
	THICKNESS = oldThickness/10
	oldSide = 0
	startSide = getRandomSide()
	for i = 0, mTimes do	
		cBarrage(startSide)
		oldSide = startSide
		startSide = getRandomSide()
		t_wait(getPerfectDelay(oldThickness) * (2 + (getSideDistance(startSide, oldSide)*mDelayMult)))
	end
	THICKNESS = oldThickness
	t_wait(getPerfectDelay(oldThickness) * 5.6)
end

function pBarrageSpiralT(mTimes, mDelayMult, mStep)
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 5.6 * mDelayMult
	THICKNESS = oldThickness/10
	startSide = getRandomSide()
	loopDir = mStep * getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		cBarrage(startSide + j)
		j = j + loopDir
		t_wait(delay)
		if(l_getSides() < 6) then t_wait(delay * 0.6) end
	end
	
	t_wait(delay)
	THICKNESS = oldThickness
end

function pWallExVortexT(mTimes, mStep, mExtraMult)
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 5.0 
	startSide = getRandomSide()
	THICKNESS = oldThickness/10
	loopDir = getRandomDir()
	currentSide = startSide
	
	for j = 0, mTimes do
		for i = 0, mStep do
			currentSide = currentSide + loopDir
			rWallEx(currentSide, loopDir * mExtraMult)
			t_wait(delay)
		end
		
		loopDir = loopDir * -1
		
		for i = 0, mStep + 1 do
			currentSide = currentSide + loopDir;
			rWallEx(currentSide, loopDir * mExtraMult)
			t_wait(delay)
		end
	end
	
	t_wait(delay)
	THICKNESS = oldThickness
end

function pInverseBarrageT(mTimes)
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 6.5
	THICKNESS = oldThickness/10
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		cBarrage(startSide)
		t_wait(delay)
		if(l_getSides() < 6) then t_wait(delay * 0.8) end
		cBarrage(startSide + getHalfSides())
		t_wait(delay)
	end
	
	THICKNESS = oldThickness
	t_wait(getPerfectDelay(THICKNESS) * 2.5)
end

function pMirrorWallStripT(mTimes, mExtra)
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 3.65
	THICKNESS = oldThickness/10
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		rWallEx(startSide, mExtra)
		t_wait(delay)
	end
	
	THICKNESS = oldThickness
	t_wait(getPerfectDelay(THICKNESS) * 5.00)
end

function pDMBarrageSpiralT(mTimes, mDelayMult, mStep)
	oldThickness = THICKNESS
	delay = (getPerfectDelayDM(THICKNESS) * 5.42) * (mDelayMult / (u_getDifficultyMult() ^ 0.24)) * (l_getSpeedMult() ^ 0.16)
	THICKNESS = oldThickness/10;
	startSide = getRandomSide()
	loopDir = mStep * getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		cBarrage(startSide + j)
		j = j + loopDir
		t_wait(delay)
		if(l_getSides() < 6) then t_wait(delay * 0.49) end
	end
	THICKNESS = oldThickness
	t_wait(getPerfectDelay(THICKNESS) * (6.7 * (u_getDifficultyMult() ^ 0.50)))
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey ==  0 then pAltBarrageT(math.random(2, 4), 2)
	elseif mKey ==  1 then pBarrageSpiralT(math.random(0, 3), 1, 1)
	elseif mKey ==  2 then pBarrageSpiralT(math.random(0, 2), 1.2, 2)
	elseif mKey ==  3 then pBarrageSpiralT(2, 0.7, 1)
	elseif mKey ==  4 then pInverseBarrageT(0)
	elseif mKey ==  5 then pMirrorWallStripT(1, 0)
	elseif mKey ==  6 then pWallExVortexT(0, 1, 1)
	elseif mKey ==  7 then pDMBarrageSpiralT(math.random(4, 7), 0.4, 1)
	elseif mKey ==  8 then pRandomBarrageT(math.random(2, 4), 2.25)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 8, 8 }
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2)
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

    l_setPulseMin(75)
    l_setPulseMax(91)
    l_setPulseSpeed(2)
    l_setPulseSpeedR(1)
    l_setPulseDelayMax(0.8275)

    --[[l_setPulseMin(70)
    l_setPulseMax(90)
    l_setPulseSpeed(2)
    l_setPulseSpeedR(1)
    l_setPulseDelayMax(5)]]

    l_setBeatPulseMax(17)
    l_setBeatPulseDelayMax(3600/145) -- BPM is 145
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
	skew = math.random(0, 1) * 0.5 - 0.25
	mult = math.random() + 0.5;
	l_setWallSkewLeft(skew * mult)
	l_setWallSkewRight(skew * mult * -1)
	l_setWallSkewLeft(skew * mult)
	l_setWallSkewRight(skew * mult * -1)
end