-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
end

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.6)
    l_setSpeedInc(0.1)
    l_setRotationSpeed(0.21)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)
    l_setDelayMult(1.1)
	l_setDelayInc(-0.01)
    l_setFastSpin(90.0)
    l_setSides(4)
    l_setSidesMin(4)
    l_setSidesMax(4)
    l_setIncTime(18)
	l_setIncEnabled(false)

    l_setPulseMin(80)
    l_setPulseMax(120)
    l_setPulseSpeed(10)
    l_setPulseSpeedR(10)
    l_setPulseDelayMax(30)

    l_setBeatPulseMax(20)
    l_setBeatPulseDelayMax(30)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	l_setRotationSpeed(0.2 * getRandomDir())
	for i = 0, 50 do
		for j = 0, 3 do
			w_wallAcc(j, THICKNESS/5, 5, -0.32 - i * 0.04, 0, 5)
		end
	end
	for j = 0, 3 do
		w_wallAcc(j, THICKNESS * 5, 5, -1.5, 0, 5)
	end
end

side = getRandomSide()
oldSide = 0
toggle = 0
count = 0
-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
	THICKNESS = 100
	cBarrage(side)
	oldSide = side
	while oldSide == side do
		side = getRandomSide()
	end
	if toggle == 0 then
		l_setRotationSpeed((count / 200) * 1.0 * getRandomDir())
		l_setPulseSpeed(10)
		l_setPulseSpeedR(10)
		toggle = 1
	else
		l_setRotationSpeed(0)
		l_setPulseSpeed(0)
		l_setPulseSpeedR(0)
		toggle = 0
	end
	for j = 0, 3 do
		w_wallAcc(j, THICKNESS * count/1000, 5, -0.32, -1, 5)
	end
	if count + 1 <= 200 then
		count = count + 1
	end
	t_wait(getPerfectDelay(THICKNESS) * (2 + (getSideDistance(side, oldSide)* 1)))
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