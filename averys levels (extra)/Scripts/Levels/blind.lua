-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "nextpatterns.lua")

delay = 3.4
count = 0

function wAckBar(mSide, mSpeed)
	for i = 0, l_getSides() - 2 do
		w_wallAdj(mSide + i, THICKNESS * mSpeed, mSpeed)
	end
end

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.65)
    l_setSpeedInc(0.10)
    l_setRotationSpeed(0)
    l_setRotationSpeedMax(0.75)
    l_setRotationSpeedInc(0.05)

    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setFastSpin(70)
    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)

    l_setIncTime(15)

    l_setPulseMin(80)
    l_setPulseMax(160)
    l_setPulseSpeed(2)
    l_setPulseSpeedR(10)
    l_setPulseDelayMax(30)

	l_setBeatPulseMax(20)
    l_setBeatPulseDelayMax(40)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	s_set3dSkew(0)
	s_set3dPulseSpeed(0)
	--execEvent("dimthelights")
	
	curSide = getRandomSide()
	
	wAckBar(curSide, 1)
	t_wait(delay * 10)
	-- wAckBar(curSide, 1.5)
	t_wait(delay * 9.8)
	-- wAckBar(curSide, 2)
	t_wait(delay * 9.6)
	-- wAckBar(curSide, 2.5)
	-- t_wait(delay * 9.4)
	-- wAckBar(curSide, 3)
	-- t_wait(delay * 9.2)
	-- wAckBar(curSide, 3.5)
	-- t_wait(delay * 9)
	-- wAckBar(curSide, 4)
	-- t_wait(delay * 8)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	dir =  math.random(0, 1) * 2 - 1
	curSide = curSide + dir
	if dir > 0 then
		a_playSound("difficultyMultUp.ogg")
	else
		a_playSound("difficultyMultDown.ogg")
	end
	t_wait(delay * 6)
	wAckBar(curSide, 10)
	t_wait(delay * 6)
	
	count = count + 1
	if count % 4 == 0 then
		if delay > 2 then
			delay = delay - 0.01
		end
		l_setRotationSpeed(-l_getRotationSpeed() * 1.01 + 0.01)
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