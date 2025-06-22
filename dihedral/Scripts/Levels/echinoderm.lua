-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

function pRandomBarrageNoRepeats(mTimes, mDelayMult)
	side = getRandomSide()
	oldSide = 0
	
	for i = 0, mTimes do	
		cBarrage(side)
		oldSide = side
		while oldSide == side do
			side = getRandomSide()
		end
		t_wait(getPerfectDelay(THICKNESS) * (2 + (getSideDistance(side, oldSide)*mDelayMult)))
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 5.6)
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then pRandomBarrageNoRepeats(500, 2.5)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 7, 8, 9, 10, 10, 10, 11, 12, 13 }
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2)
    l_setSpeedInc(0.1)
    l_setRotationSpeed(0.1)
    l_setRotationSpeedMax(1)
    l_setRotationSpeedInc(0.2)
    l_setDelayMult(1.1)
	l_setDelayInc(-0.01)
    l_setFastSpin(100.0)
    l_setSides(5)
    l_setSidesMin(5)
    l_setSidesMax(5)
    l_setIncTime(18)
	l_setIncEnabled(false)

    l_setPulseMin(100)
    l_setPulseMax(130)
    l_setPulseSpeed(5)
    l_setPulseSpeedR(5)
    l_setPulseDelayMax(10)

    l_setBeatPulseMax(20)
    l_setBeatPulseDelayMax(20)

	l_setWallAngleLeft(100)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	s_set3dSkew(0)
	s_set3dPulseSpeed(0)
	s_setPulseInc(0)
	for i = 0, 4 do
		w_wallAcc(i, THICKNESS * 30, 5, -0.23, 0, 5)
	end
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	l_setWallAngleLeft(0)
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

isFlipped = 0
hue = math.random(0, 180)
-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	if s_get3dSkew() > 0 then
		s_setHueMin(hue)
		s_setHueMax(hue)
	else
		s_setHueMin(hue + 180)
		s_setHueMax(hue + 180)
	end
	hue = hue + 0.1
end