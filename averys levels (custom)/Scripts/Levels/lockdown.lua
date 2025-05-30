-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

--Gates for the gate level, designed for 32 sides
function pCircGate()
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 3.65
	THICKNESS = oldThickness/2;
	startSide = getRandomSide();
	rWallEx(startSide, 8)
	w_wallAcc(startSide, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+8, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+16, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+24, THICKNESS*10, 0, 0.006, 1, 1.5)
	t_wait(delay*2)
	THICKNESS = oldThickness
end

function pCircGate2()
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 3.65
	THICKNESS = oldThickness/2;
	startSide = getRandomSide();
	cWallEx(startSide, 4)
	cWallEx(startSide+11, 4)
	cWallEx(startSide+22, 4)
	w_wallAcc(startSide, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+4, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+11, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+15, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+22, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+26, THICKNESS*10, 0, 0.006, 1, 1.5)
	t_wait(delay*2)
	THICKNESS = oldThickness
end

function pCircGate3()
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 3.65
	THICKNESS = oldThickness/2;
	startSide = getRandomSide();
	t_wait(delay * 0.6)
	cWallEx(startSide, 23)
	w_wallAcc(startSide, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+23, THICKNESS*10, 0, 0.006, 1, 1.5)
	t_wait(delay*2)
	THICKNESS = oldThickness
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey ==  0 then pCircGate();
	elseif mKey ==  1 then pCircGate2();
	elseif mKey ==  2 then pCircGate3();
	end
	t_wait(getPerfectDelay(THICKNESS))
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 2 }
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.65)
    l_setSpeedInc(0.10)
    l_setRotationSpeed(0.21)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)
    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setSides(32)
	l_setSidesMin(32)
    l_setSidesMax(32)
    l_setIncTime(15)

	l_setPulseMin(70)
	l_setPulseMax(90)
    l_setPulseSpeed(5)
    l_setPulseSpeedR(10) 
    l_setPulseDelayMax(10)

    l_setFastSpin(200)

    l_setBeatPulseMax(17)
    l_setBeatPulseDelayMax(23.8)
	
	--setStyleValueFloat("3D_pulse_speed", 0);
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
	--((math.random()*0.8)-0.4)
	addPattern(keys[index])
	index = index + 1
	
	if index - 1 == #keys then
        index = 1
        shuffle(keys)
    end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

style = 0
timer = 600
color = 0
-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	color = (color + 1)%360
	s_setHueMin(color)
	s_setHueMax(color)	
	if timer == 1 then
		l_setRotationSpeed(25)
		if style == 0 then
			s_setStyle("invertstuff1")
			style = 1
		elseif style == 1 then
			s_setStyle("invertstuff2")
			style = 0
		end
		color = (color + 180)%360
	elseif timer == 0 then
		l_setRotationSpeed(math.random()*getRandomDir()/2)
		l_setPulseMin(math.random(60, 80))
		l_setPulseMax(math.random(80, 100))
		timer = 200
	end
	timer = timer - 1
end