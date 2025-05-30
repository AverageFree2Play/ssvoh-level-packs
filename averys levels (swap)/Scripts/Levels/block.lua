-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

-- execScript("expatterns.lua")
-- execScript("expatterns4.lua")
-- execScript("expatterns3.lua")

delay = 60
half = 0
num = 0
consec = 0
dir = 0
side = math.random(4, l_getSides())
oldside = side
beatpulse = 10

function flipper(side, mHalf)
	for i = 1, l_getSides() - 4 do
		w_wallAcc(mHalf * 17 - 1 + side + i, THICKNESS * 0.6, 2, -0.06, 0.4, 2)
	end
	
	w_wallAcc(mHalf * 17 - 5 + side, THICKNESS * 2.25, 2, -0.06, 0.4, 2)
	w_wallAcc(mHalf * 17 + side, THICKNESS * 2.25, 2, -0.06, 0.4, 2)
	
end

function closedFlipper(side, mHalf)
	for i = 1, l_getSides() - 4 do
		w_wallAcc(mHalf * 17 - 1 + side + i, THICKNESS * 0.6, 2, -0.06, 0.4, 2)
	end
	
	w_wallAcc(mHalf * 17 - 5 + side, THICKNESS * 2.25, 2, -0.06, 0.4, 2)
	w_wallAcc(mHalf * 17 + side, THICKNESS * 2.25, 2, -0.06, 0.4, 2)
	
	for i = 1, 4 do
		w_wallAcc(mHalf * 17 - 5 + side + i, THICKNESS * 0.6, 2, -0.06, 0.344, 2)
	end
end

function addPattern(mKey)
	if mKey == 0 then flipper(side, half)
	elseif mKey == 1 then closedFlipper(side, half)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = {0, 0, 0, 0, 0, 1}
shuffle(keys)
index = 0


-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.5)
    l_setSpeedInc(0.10)
    l_setRotationSpeed(0.1 * getRandomDir())
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)
    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setSides(36)
	l_setSidesMin(36)
    l_setSidesMax(36)
    l_setIncTime(1500000000)

	l_setPulseMin(120)
	l_setPulseMax(120)
    l_setPulseSpeed(1)
    l_setPulseSpeedR(1) 
    l_setPulseDelayMax(30)

    l_setFastSpin(70)

    l_setBeatPulseMax(10)
    l_setBeatPulseDelayMax(0)

	--l_setWallSkewLeft(8)

	s_set3dSkew(0.0)
	s_set3dPulseSpeed(0)

	l_setSwapEnabled(true)
	l_setSwapCooldownMult(.35)

	side = math.random(4, l_getSides())
	--setStyleValueFloat("3D_pulse_speed", 0);
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	w_wallAcc(35, 2000, 24, -4, 0, 24)
	w_wallAcc(17, 2000, 24, -4, 0, 24)
	e_messageAdd("Remember to swap!", 120)
	s_setStyle('block')
	--execEvent("disableincr")
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
	while side == oldside do
		side = math.random(4, l_getSides())
	end
	--flipper(side, half)
	addPattern(keys[index])
	index = index + 1
	
	if index - 1 == table.getn(keys) then
		index = 1
	end
	oldside = side
	t_wait(delay)
	if math.random(0, 1) == 0 or consec > 1 then 
		half = 1 - half
		consec = 0
	else
		consec = consec + 1
	end
	
	if delay > 45 then
		delay = delay - 0.1
	end
	
	num = num + 1
	if num % 10 == 0 then
		l_setRotationSpeed(-1.025 * l_getRotationSpeed())
		if dir == 0 then
			--l_setWallSkewRight(l_getWallSkewLeft())
			--l_setWallSkewLeft(0)
			dir = 1
		else
			--l_setWallSkewLeft(l_getWallSkewRight())
			--l_setWallSkewRight(0)
			dir = 0
		end
	end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

swapped = false
function onCursorSwap()
	if swapped then
		swapped = false
		s_setStyle('block')
	else
		swapped = true
		s_setStyle('block2')
	end
	l_setBeatPulseMax(beatpulse)
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	--[[if isKeyPressed(57) then
		if isDown == false then
			if beatpulse == 10 then
				beatpulse = -160
				execEvent("blockstyle2")
			else
				beatpulse = 10
				execEvent("blockstyle1")
			end
			playSound("Exschwasion4_jump.ogg")
			setLevelValueFloat("beatpulse_max", beatpulse)
		end
		isDown = true
	else
		isDown = false
	end]]
end