-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")

THICKNESS = 400

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
end

--0,42857142857142857142857142857143
-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(1)
    l_setSpeedInc(0.005)
    l_setRotationSpeed(0.1)
    l_setRotationSpeedMax(400)
    l_setRotationSpeedInc(0.75)
    l_setDelayMult(1)
	l_setDelayInc(-0.01)
    l_setFastSpin(100.0)
    l_setSides(64)
    l_setSidesMin(64)
    l_setSidesMax(64)
    l_setIncTime(18)
	l_setIncEnabled(false)

    -- l_setPulseMin(80)
    -- l_setPulseMax(120)
    -- l_setPulseSpeed(10)
    -- l_setPulseSpeedR(10)
    -- l_setPulseDelayMax(30)

    l_setBeatPulseMax(-10)
    l_setBeatPulseDelayMax(25.714285714285714285714285714286)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	speed_multiplier = l_getSpeedMult()
	speed_increment = l_getSpeedInc()
	for i = 1, 50 do
		for j = 0, l_getSides() do
			w_wallAcc(j, 5, 14/speed_multiplier, -0.30 - (i*50)^0.5 * 0.006, 0, 14/speed_multiplier)
			-- val for 1: 0.3353
		end
	end
	for j = 0, l_getSides() do
		w_wallAcc(j, 500000, 14/speed_multiplier, -0.60, 0, 14/speed_multiplier)
	end
end

side = getRandomSide()
spb = 0.42857142857142857142857142857143
spb60 = 60*spb

function getThicknessOfPerfectDelay(delay)
	return delay*5.02*l_getSpeedMult()
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
	speed_multiplier = math.max(speed_multiplier - speed_increment, 0.2)
	l_getSpeedMult(speed_multiplier)	
	l_setSides(16)
	cWall(side)
	oldSide = side
	while oldSide == side do
		side = getRandomSide()
	end
	THICKNESS = getThicknessOfPerfectDelay(spb60*2)
	t_wait(spb60/2)
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

totaltime = 0
dir = getRandomDir()
count = 0
-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	totaltime = totaltime + mFrameTime
	while totaltime >= 2*spb60 do
	-- if count + 1 <= 200 then
		count = count + 1
	-- end
		-- for j = 0, l_getSides() do
		-- 	w_wallAcc(j, count/25, 14/speed_multiplier, -0.32, -200000/speed_multiplier, 14/speed_multiplier)
		-- end
		
		if math.abs(l_getRotationSpeed()) >= 1.0 then
		l_setRotationSpeed((math.abs(l_getRotationSpeed())+0.02)*dir)
		else
		l_setRotationSpeed(math.abs(l_getRotationSpeed())*1.02*dir)
		end
		dir = -dir
		totaltime = totaltime - 2*spb60
	end
end