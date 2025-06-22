-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

function singularity()
	for i = 0, 599 * 2 + 1 do
		w_wallAcc(i, THICKNESS * 30, 5, -0.39, 0, 5)
	end
end

function singWall(mSide)
	for i = 0, 99 do
		w_wallAdj(mSide * 100 + i, THICKNESS * 4, 0.4)
	end
end

function singularityBarrage()
	startSide = math.random(1, 6)
	for i = 0, 4 do
		singWall(startSide + i)
	end
	t_wait(getPerfectDelay(THICKNESS) * 22)
end

function singAltBarrage(mTimes)
	delay = getPerfectDelay(THICKNESS) * 20
	startSide = math.random(1, 6)
	for i = 0, mTimes do
		for j = 0, 2 do
			singWall(startSide + i + 2*j)
		end
		t_wait(delay * (22/20))
	end
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey ==  0 then singularityBarrage() 
		elseif mKey == 1 then singAltBarrage(math.random(2, 4))
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 0, 0, 1 }
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.65)
    l_setSpeedInc(0.1)
    l_setRotationSpeed(0.01)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)
    l_setDelayMult(1.1)
	l_setDelayInc(-0.01)
    l_setFastSpin(90.0)
    l_setSides(600)
    l_setSidesMin(600)
    l_setSidesMax(600)
    l_setIncTime(18)
	l_setIncEnabled(false)

    l_setPulseMin(80)
    l_setPulseMax(100)
    l_setPulseSpeed(0)
    l_setPulseSpeedR(0)
    l_setPulseDelayMax(0)

    l_setBeatPulseMax(0)
    l_setBeatPulseDelayMax(0)

	l_setWallSkewLeft(-1360)
	--l_setWallAngleLeft(2)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	s_setStyle("singularity")
	singularity()
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	l_setWallSkewLeft(100)
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
end