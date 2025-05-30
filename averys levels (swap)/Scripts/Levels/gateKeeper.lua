-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

beatpulse = 10
isDown = false
partition = math.random(1, 3)
oldPartition = math.random(1, 3)
delay = 16
num = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.65)
    l_setSpeedInc(0.10)
    l_setRotationSpeed(0.1)
    l_setRotationSpeedMax(0.75)
    l_setRotationSpeedInc(0.05)
    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setSides(15)
	l_setSidesMin(15)
    l_setSidesMax(15)
    l_setIncTime(15000000000000)

	l_setPulseMin(140)
	l_setPulseMax(140)
    l_setPulseSpeed(.5)
    l_setPulseSpeedR(.5) 
    l_setPulseDelayMax(30)

    l_setFastSpin(70)

    l_setBeatPulseMax(10)
    l_setBeatPulseDelayMax(0)

	--l_setWallSkewLeft(8)

	s_set3dPulseSpeed(0)

	l_setSwapEnabled(true)
	l_setSwapCooldownMult(.35)

	side = math.random(4, l_getSides())
	--setStyleValueFloat("3D_pulse_speed", 0);
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	w_wallAcc(2, 2000, 3, -0.095, 0, 3)
	w_wallAcc(7, 2000, 3, -0.095, 0, 3)
	w_wallAcc(12, 2000, 3, -0.095, 0, 3)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
	while partition == oldPartition do
		partition = math.random(1, 3)
	end
	wall = partition * 5 - 3 + math.random(1, 4)
	for i = 1, l_getSides() - 1 do
		w_wallAcc(wall + i, THICKNESS * 0.7, 0.5, -0.0003 * (delay - 11), 0, 1)
	end
	oldPartition = partition
	t_wait(getPerfectDelay(THICKNESS) * delay)
	num = num + 1
	
	if num % 5 == 0 and delay > 12 then
		delay = delay - 0.1
		l_setRotationSpeed(l_getRotationSpeed() * -1.01)
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