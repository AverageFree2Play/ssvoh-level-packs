-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

diff = 1.5

function pKey(mDelayMult)
	delay = getPerfectDelay(THICKNESS) * 3
	startSide = getRandomSide();
	cWallEx(startSide, 56)
	w_wall(startSide + 1, THICKNESS * 18.67 * mDelayMult)
	w_wall(startSide - 9, THICKNESS * 18.67 * mDelayMult)
	w_wall(startSide, THICKNESS * 18.67 * mDelayMult)
	w_wall(startSide - 8, THICKNESS * 18.67 * mDelayMult)
	for i = 0, 4 do
		t_wait(delay * mDelayMult)
		if(math.random(0, 1) == 1) then cWallEx(startSide - 8, 4)
		else cWallEx(startSide - 4, 4) end
	end
	t_wait(delay * (mDelayMult) * 0.7 )
	cWallEx(startSide, 56)
	t_wait(delay*4)
end
-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey ==  0 then pKey(diff);
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0 }
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2)
    l_setSpeedInc(0.10)
    l_setRotationSpeed(0.21)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)
    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setSides(64)
	l_setSidesMin(64)
    l_setSidesMax(64)
    l_setIncTime(15)

	l_setPulseMin(70)
	l_setPulseMax(70)
    l_setPulseSpeed(5)
    l_setPulseSpeedR(10) 
    l_setPulseDelayMax(10)

    l_setFastSpin(200)

    l_setBeatPulseMax(20)
    l_setBeatPulseDelayMax(3600/135)

	--l_addTracked("tracker", "delay")

	--setStyleValueFloat("3D_pulse_speed", 0);
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
	l_setRotationSpeed((math.random()*0.8)-0.4)
	addPattern(keys[index])
	index = index + 1
	
	if index - 1 == table.getn(keys) then
		index = 1
	end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
	if(diff > 1) then
		diff = diff - 0.1
		e_messageAddImportant("Delay: "..(diff * 100/ 1.5).."%", 100)
        a_playSound("levelup.ogg")
        a_playSound("beep.ogg")
        a_playSound("increment.ogg")
	end
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

color = 90
-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	color = color + 0.1
	s_setHueMin(color)
	s_setHueMax(color + 10)
	l_setRotationSpeed(((color % 180) / 480))
end