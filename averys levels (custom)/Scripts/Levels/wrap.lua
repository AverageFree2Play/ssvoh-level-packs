-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

-- i'm not a wrapper

function catchBar(num, del)
	side = getRandomSide()
	for i = 1, num - 1 do
		w_wallAdj(side + l_getSides() * i/num, THICKNESS * 7, 0.6)
	end
	--wait(6 * del)
	w_wallAdj(side, THICKNESS * 5, 0.6)
	t_wait(getPerfectDelay(THICKNESS) * 45)
	w_wallAdj(side, THICKNESS * 2, 1.9)
	for i = 2, l_getSides() - 2 do
		w_wallAdj(side + i, THICKNESS * 2, 1.9)
	end
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey ==  0 then 
		catchBar(num, del)
	end
end

num = 2
levelDisp = num - 1
del = 1
incrementTime = 10

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = {0}
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.65)
    l_setSpeedInc(0)
    l_setRotationSpeed(0.3)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.035)
    l_setDelayMult(1.10)
    l_setDelayInc(0.01)
    l_setSides(36)
	l_setSidesMin(36)
    l_setSidesMax(36)
    l_setIncTime(150000000000000000000)

	l_setPulseMin(100)
	l_setPulseMax(140)
    l_setPulseSpeed(1)
    l_setPulseSpeedR(2) 
    l_setPulseDelayMax(30)

    l_setFastSpin(70)
	l_setSwapEnabled(true)

    l_setBeatPulseMax(30)
    l_setBeatPulseDelayMax(3600/120)

	l_addTracked('levelDisp','level')
	l_addTracked('incrementTime','time')

	--setStyleValueFloat("3D_pulse_speed", 0);
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	l_setRotationSpeed(0.3 * getRandomDir())
	s_set3dSkew(.15)
	s_set3dPulseSpeed(0)

	e_messageAddImportant("level: "..levelDisp.." / time: "..incrementTime, 170)

	for i = 1, l_getSides() do
		w_wallAcc(i, THICKNESS * 40, 3, -0.1475 - 0.0025 * ((i + 1) % 6) - 0.005 * (i % 3), 0, 5)
	end
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
timer = 0
function onUpdate(mFrameTime)
	timer = timer + mFrameTime

	if timer > 60*incrementTime then
		timer = 0
		num = num + 1
		levelDisp = num - 1
		incrementTime = incrementTime + 5
		a_playSound('levelUp.ogg')
		a_playSound('beep.ogg')
		a_playSound('increment.ogg')
		e_messageAddImportant("level: "..(num - 1).." / time: "..incrementTime, 170)

		l_setRotationSpeed(-l_getRotationSpeed() * 1.01)
	end
end