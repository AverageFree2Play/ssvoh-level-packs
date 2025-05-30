-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

--2-sided patterns
function simpleAlt(mTimes)
	startSide = math.random(0,1) * 2
	for i = 0, mTimes do
		w_wall(startSide, THICKNESS)
		w_wall(startSide + 1, THICKNESS)
		w_wallAcc(2 - startSide, THICKNESS, 3, -0.135, -1, 3)
		w_wallAcc(3 - startSide, THICKNESS, 3, -0.135, -1, 3)
		t_wait(getPerfectDelay(THICKNESS) * 4)
		w_wall(2 - startSide, THICKNESS)
		w_wall(3 - startSide, THICKNESS)
		w_wallAcc(startSide, THICKNESS, 3, -0.135, -1, 3)
		w_wallAcc(startSide + 1, THICKNESS, 3, -0.135, -1, 3)
		t_wait(getPerfectDelay(THICKNESS) * 4)
	end
	t_wait(getPerfectDelay(THICKNESS) * 7)
end

function trickyTrick(mTimes)
	for i = 0, mTimes do
		side = math.random(0,1) * 2
		w_wallAcc(side, THICKNESS, 3, -0.16, 1, 3)
		w_wallAcc(side + 1, THICKNESS, 3, -0.16, 1, 3)
		w_wallAcc(2 - side, THICKNESS, 3, -0.16, 0.85, 3)
		w_wallAcc(3 - side, THICKNESS, 3, -0.16, 0.85, 3)
		w_wallAcc(side, THICKNESS, 3, -0.135, -1, 3)
		w_wallAcc(side + 1, THICKNESS, 3, -0.135, -1, 3)
		w_wallAcc(2 - side, THICKNESS, 3, -0.135, -1, 3)
		w_wallAcc(3 - side, THICKNESS, 3, -0.135, -1, 3)
		t_wait(getPerfectDelay(THICKNESS) * 7)
	end
	t_wait(getPerfectDelay(THICKNESS) * 7)
end

function trickyTricky(mTimes)
	for i = 0, mTimes do
		side = math.random(0,1) * 2
		w_wallAcc(side, THICKNESS, 0.85, 0.14, 0.5, 1)
		w_wallAcc(side + 1, THICKNESS, 0.85, 0.14, 0.5, 1)
		w_wallAcc(3 - side, THICKNESS, 3, -0.135, -1, 3)
		w_wallAcc(2 - side, THICKNESS, 3, -0.135, -1, 3)
		w_wallAcc(3 - side, THICKNESS, 0.85, 0.14, 0.5, 1.2)
		w_wallAcc(2 - side, THICKNESS, 0.85, 0.14, 0.5, 1.2)
		w_wallAcc(side + 1, THICKNESS, 3, -0.135, -1, 3)
		w_wallAcc(side, THICKNESS, 3, -0.135, -1, 3)
		t_wait(getPerfectDelay(THICKNESS) * 9)
	end
	t_wait(getPerfectDelay(THICKNESS) * 7)
end

function trickyTrickyTricky(mTimes)
	for i = 0, mTimes do
		side = math.random(0,1) * 2
		w_wallAcc(side, THICKNESS, 2, -0.07, 0.75, 2)
		w_wallAcc(side + 1, THICKNESS, 2, -0.07, 0.75, 2)
		w_wallAcc(2 - side, THICKNESS, 3, -0.135, -1, 3)
		w_wallAcc(3 - side, THICKNESS, 3, -0.135, -1, 3)
		w_wallAcc(3 - side, THICKNESS, 2, -0.07, 1, 2)
		w_wallAcc(2 - side, THICKNESS, 2, -0.07, 1, 2)
		w_wallAcc(side + 1, THICKNESS, 3, -0.135, -1, 3)
		w_wallAcc(side, THICKNESS, 3, -0.135, -1, 3)
		t_wait(getPerfectDelay(THICKNESS) * 9)
	end
	t_wait(getPerfectDelay(THICKNESS) * 7)
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey ==  0 then simpleAlt(math.random(1, 3))
		elseif mKey == 1 then trickyTrick(math.random(1,3))
		elseif mKey == 2 then trickyTricky(math.random(1,3))
		elseif mKey == 3 then trickyTrickyTricky(math.random(1,3))
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 1, 2, 3 }
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2)
    l_setSpeedInc(0.10)
    l_setRotationSpeed(0.15)
    l_setRotationSpeedMax(0.75)
    l_setRotationSpeedInc(0.05)
    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setSides(4)
	l_setSidesMin(4)
    l_setSidesMax(4)
    l_setIncTime(1500000000)

	l_setPulseMin(140)
	l_setPulseMax(140)
    l_setPulseSpeed(1)
    l_setPulseSpeedR(0) 
    l_setPulseDelayMax(30)

    l_setFastSpin(70)

    l_setBeatPulseMax(10)
    l_setBeatPulseDelayMax(0)

	--l_setWallSkewLeft(8)

	s_set3dSkew(0.3)
	s_set3dPulseSpeed(0.02)

	l_setSwapEnabled(true)
	l_setSwapCooldownMult(0.35)

	--setStyleValueFloat("3D_pulse_speed", 0);
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	w_wallAcc(1, 2000, 3, -0.075, 0, 3)
	w_wallAcc(3, 2000, 3, -0.075, 0, 3)
    e_messageAdd("Remember to swap!", 120)

	isDown = false
	beatpulse = 10
	count = 0
	smult = 2.3
	l_setSpeedMult(smult)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	addPattern(keys[index])
	index = index + 1
	if index - 1 == table.getn(keys) then
		index = 1
	end
	
	count = count + 1
	if count % 4 == 0 then
		l_setRotationSpeed(getRandomDir() * l_getRotationSpeed() * ((count/4)%2 * 1.5 + 0.5))
		if smult < 2.65 then
			smult = smult + 0.01
		end
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