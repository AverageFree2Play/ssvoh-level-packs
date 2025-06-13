-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

function wallSAcc(mSide, mAdj, mAcc, mMinSpd, mMaxSpd) w_wallAcc(mSide, THICKNESS, mAdj, mAcc * (u_getDifficultyMult()), mMinSpd, mMaxSpd) end

function pACBarrage()
	currentSides = l_getSides()
	delay = getPerfectDelay(THICKNESS) * 3.7
	startSide = math.random(0, 10)
	for i = 0, currentSides - 2 do
		currentSide = startSide + i
		wallSAcc(currentSide, 9 + math.random(0, 1), -1.1, 1, 12)
	end
	t_wait(delay * 2.5)
end

function pACBarrageMultiAltDir()
	currentSides = l_getSides()
	delay = getPerfectDelayDM(THICKNESS) * 4
	mdiff = 1 + math.abs(1 - u_getDifficultyMult())
	startSide = math.random(0, 10)
	loopDir = getRandomDir()
	for i = 0, currentSides + getHalfSides() do
		currentSide = startSide + i * loopDir
		wallSAcc(currentSide, 10, -1.095, 0.40, 10)
		t_wait((delay / 2.21) * (mdiff * 1.29))
		wallSAcc(currentSide + (getHalfSides() * loopDir), 0, 0.128, 0, 1.4)
	end
	t_wait(delay * 8)
end

function pACBarrageMulti()
	currentSides = l_getSides()
	delay = getPerfectDelay(THICKNESS) * 3.7
	startSide = math.random(0, 10)
	for i = 0, currentSides - 2 do
		currentSide = startSide + i
		wallSAcc(currentSide, 10, -1.09, 0.31, 10)
		wallSAcc(currentSide, 0, 0.05, 0, 4.0)
		wallSAcc(currentSide, 0, 0.09, 0, 4.0)
		wallSAcc(currentSide, 0, 0.12, 0, 4.0)
	end
	t_wait(delay * 8)
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then pACBarrage()
	elseif mKey == 1 then pACBarrageMulti()
	elseif mKey == 2 then pACBarrageMultiAltDir()
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 2, 2, 0, 0, 0, 0, 0 }
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.26)
    l_setSpeedInc(0.045)
    l_setRotationSpeed(0.27)
    l_setRotationSpeedMax(0.38)
    l_setRotationSpeedInc(0.045)
    l_setDelayMult(1.095)
	l_setDelayInc(-0.015)
    l_setFastSpin(71.0)
    l_setSides(6)
    l_setSidesMin(5)
    l_setSidesMax(7)
    l_setIncTime(15)

    l_setPulseMin(64)
    l_setPulseMax(84)
    l_setPulseSpeed(1.05)
    l_setPulseSpeedR(1.34)
    l_setPulseDelayMax(7.1)

	l_setWallSkewLeft(18)

    l_setBeatPulseMax(15)
    l_setBeatPulseDelayMax(21.8)
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

-- continuous direction change (even if not on level increment)
dirChangeTime = 400
hueIMin = 0.0
hueIMax = 22.0
hueIStep = 0.0065

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	dirChangeTime = dirChangeTime - mFrameTime;
	if dirChangeTime < 0 then
		-- do not change direction while fast spinning
		if u_isFastSpinning() == false then
			l_setRotationSpeed(l_getRotationSpeed() * -1)
			dirChangeTime = 400
		end
	end 

	s_setHueInc(s_getHueInc() + hueIStep)
    if(s_getHueInc() > hueIMax) then hueIStep = hueIStep * -1 end
    if(s_getHueInc() < hueIMin) then hueIStep = hueIStep * -1 end
end