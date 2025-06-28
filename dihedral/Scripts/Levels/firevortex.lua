-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

function pAltBarrageSpiral(mTimes, mStep, mDelayMult)
	delay = getPerfectDelay(THICKNESS)* 5.6 * mDelayMult
	
	for i = 0, mTimes do
		cAltBarrage(i, mStep)
		t_wait(delay)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 6.1)
end

function pMirrorSpiralThin(mTimes, mExtra, mDelayMult)
	delay = getPerfectDelay(THICKNESS) * 5.6 * mDelayMult
	startSide = getRandomSide()
	loopDir = getRandomDir()
	j = 0
	
	for i = 0, mTimes do
		rWallEx(startSide + j, mExtra)
		j = j + loopDir
		t_wait(delay)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 6.5)
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then pBarrageSpiral(math.random(5, 9), 0.41, 1)
	elseif mKey == 1 then pAltBarrageSpiral(math.random(5, 9), 2, ((4-(l_getSides()/2))*0.1)+0.37)
	elseif mKey == 2 then pMirrorSpiralThin(math.random(5,9), (l_getSides()/2)-2, ((4-(l_getSides()/2))*0.1)+0.37)
	end
	t_wait(getPerfectDelay(THICKNESS)*15)
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = {0, 0, 0, 1, 2}
shuffle(keys)
index = 0
level = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(3)
    l_setSpeedInc(0)
    l_setRotationSpeed(0)
    l_setRotationSpeedMax(2)
    l_setRotationSpeedInc(0)
    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setFastSpin(20.0)
    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)
    l_setIncTime(10)

    l_setPulseMin(90)
    l_setPulseMax(100)
    l_setPulseSpeed(4)
    l_setPulseSpeedR(6.85)
    l_setPulseDelayMax(20)

    l_setBeatPulseMax(17)
    l_setBeatPulseDelayMax(3600/180)

    --l_setWallSkewRight(-15)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	e_messageAddImportant("vortex speed: "..(level+1), 170)	
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()

	if l_getRotationSpeed() == 0 then
		l_setRotationSpeed(0.4+level*0.05)
	else
		l_setRotationSpeed(level*0.05)
	end
	
	l_setSides(math.random(2, 4)*2)	

	addPattern(keys[index])
	index = index + 1

	if index - 1 == table.getn(keys) then
		index = 1
	end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
	level = level + 1
	e_messageAddImportant("vortex speed: "..(level+1), 170)	
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
end