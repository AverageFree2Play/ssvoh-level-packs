-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execScript("hurdlePatterns.lua")

beatpulse = 10
acceleration = 0
makeSound = true

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey ==  0 then hurdle() t_wait(getPerfectDelay(THICKNESS) * 10)
	elseif mKey == 1 then altHurdle()
	elseif mKey == 2 then altDoubleHurdle()
	elseif mKey == 3 then singleHurdle()
	elseif mKey == 4 then doubleSingleHurdle()
	elseif mKey == 5 then doubleHurdle()
	elseif mKey == 6 then doubleDoubleHurdle()
	elseif mKey == 7 then backAndForthHurdle(math.random(1,3))
	elseif mKey == 8 then hurdleSpiral(math.random(4,8))
	elseif mKey == 9 then halfHurdle(math.random(1,3))
	elseif mKey == 10 then altHurdleBarrage(math.random(3,6))
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 0, 1, 1, 2, 3, 3, 4, 5, 5, 6, 7, 8, 9, 10}
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2)
    l_setSpeedInc(0.05)
    l_setRotationSpeed(0.1)
    l_setRotationSpeedMax(0.75)
    l_setRotationSpeedInc(0)

    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setFastSpin(70)
    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)

    l_setIncTime(60)

    l_setPulseMin(100)
    l_setPulseMax(120)
    l_setPulseSpeed(1)
    l_setPulseSpeedR(0)
    l_setPulseDelayMax(1)

    l_setBeatPulseMax(1)
    l_setBeatPulseDelayMax(0)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	s_setStyle("hurdle")
	s_set3dPulseSpeed(0)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	addPattern(keys[index])
	index = index + 1
	if index - 1 == table.getn(keys) then
		index = 1
	end
	l_setRotationSpeed(l_getRotationSpeed() + 0.005)
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
	l_setRotationSpeed(l_getRotationSpeed() + 0.15)
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	l_setBeatPulseMax(beatpulse)
	s_set3dSpacing(25 - beatpulse/4)
end

function onInput(mFrameTime, mMovement, mFocus, mSwap)
	if mSwap --[[spacebar]] then 
		beatpulse = 120
		if makeSound == true then
			a_playSound("swap.ogg")
			makeSound = false
		end
	elseif beatpulse - 12 > 1 then
		beatpulse = beatpulse - 12
		makeSound = true
	else
		beatpulse = 1
	end
end