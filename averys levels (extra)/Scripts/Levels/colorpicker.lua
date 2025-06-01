-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "nextpatterns.lua")

num = 1
count = 0
side = 0
oldSide = 0

function randcolor()
	while side == oldSide do
		side = math.random(0, 5)
	end
	hue = math.random(0, 360)
	colDiff =  1--math.random(0, 1) -- 0: lighter, 1: darker, 2: hueshift forward, 3: hueshift back

	--some combinations are basically impossible to tell apart
	if colDiff == 0 then
		hue = math.random(200,277)
		--while hue > 200 and hue < 277 do
		--	hue = math.random(0, 360)
		--end
	end

	if colDiff == 2 then
		hue = math.random(105,137)
		--while hue > 105 and hue < 137 do
		--	hue = math.random(0, 360)
		--end
	end

	if colDiff == 3 then
		hue = math.random(113,130)
		--while hue > 113 and hue < 130 do
		--	hue = math.random(0, 360)
		--end
	end

	if colDiff == 3 then
		hue = 5
		--while hue < 5 do
		--	hue = math.random(5, 360)
		--end
	end
end

function randomcolorstyle()
	if side == 0 then
		if colDiff == 0 then s_setStyle("c00")
		elseif colDiff == 1 then s_setStyle("c01")
		elseif colDiff == 2 then s_setStyle("c02")
		else s_setStyle("c03")
		end
	elseif side == 1 then
		if colDiff == 0 then s_setStyle("c10")
		elseif colDiff == 1 then s_setStyle("c11")
		elseif colDiff == 2 then s_setStyle("c12")
		else s_setStyle("c13")
		end
	elseif side == 2 then
		if colDiff == 0 then s_setStyle("c20")
		elseif colDiff == 1 then s_setStyle("c21")
		elseif colDiff == 2 then s_setStyle("c22")
		else s_setStyle("c23")
		end
	elseif side == 3 then
		if colDiff == 0 then s_setStyle("c30")
		elseif colDiff == 1 then s_setStyle("c31")
		elseif colDiff == 2 then s_setStyle("c32")
		else s_setStyle("c33")
		end
	elseif side == 4 then
		if colDiff == 0 then s_setStyle("c40")
		elseif colDiff == 1 then s_setStyle("c41")
		elseif colDiff == 2 then s_setStyle("c42")
		else s_setStyle("c43")
		end
	else
		if colDiff == 0 then s_setStyle("c50")
		elseif colDiff == 1 then s_setStyle("c51")
		elseif colDiff == 2 then s_setStyle("c52")
		else s_setStyle("c53")
		end
	end

	s_setHueMin(hue)
	s_setHueMax(hue)
end

function addPattern()
	randcolor()
	randomcolorstyle()
	t_wait(0.6)
	randomcolorstyle()
	t_wait(.3)
	e_messageAddImportant("3",50/3)
	e_messageAddImportant("2",50/3)
	e_messageAddImportant("1",50/3)
	t_wait(50)
	colorBarrage()
end

function colorBarrage()
	a_playSound("beep.ogg")
	for i = 1, l_getSides() - 1 do
		w_wallAdj(side + i, THICKNESS * 30, 30)
	end
	count = count + 1
	if count % 10 == 0 then
		num = num + 1
		a_playSound("increment.ogg")
		a_playSound("levelUp.ogg")
		l_setRotationSpeed(l_getRotationSpeed() * -1.15)
	end

	oldSide = side
end

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.65)
    l_setSpeedInc(0.10)
    l_setRotationSpeed(0.25)
    l_setRotationSpeedMax(0.75)
    l_setRotationSpeedInc(0.03)

    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setFastSpin(70)
    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)

    l_setIncTime(15000000)

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
	s_set3dPulseSpeed(0.02)

	t_wait(0.8)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	addPattern()
	t_wait(20)
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