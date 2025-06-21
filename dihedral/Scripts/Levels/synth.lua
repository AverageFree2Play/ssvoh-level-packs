-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "nextpatterns.lua")

THICKNESS = 200

function pMirrorWallStrip(mTimes, mExtra)
    local delay = getPerfectDelay(THICKNESS) * 1.35
    local startSide = getRandomSide()

    for i = 0, mTimes do
        rWallEx(startSide, mExtra)
        t_wait(delay)
    end
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	startSide = getRandomSide();
	delay = getPerfectDelay(THICKNESS)-- * 3.65
	if mKey ==  0 then 
		rWallEx(startSide, 8)
	elseif mKey ==  1 then 
		cWallEx(startSide, 4)
		cWallEx(startSide+11, 4)
		cWallEx(startSide+22, 4)
	elseif mKey ==  2 then 
		cWallEx(startSide, 23)
	elseif mKey == 3 then
		pMirrorWallStrip(1, 5)
	end
	t_wait(delay*2)
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = {0, 0, 1,1, 2, 3}
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(3)
    l_setSpeedInc(0.1)
    l_setRotationSpeed(0.21)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)
    l_setDelayMult(1.1)
    l_setDelayInc(-0.01)
    l_setFastSpin(100.0)
    l_setSides(32)
    l_setSidesMin(32)
    l_setSidesMax(32)
    l_setIncTime(15)

    l_setPulseMin(70)
    l_setPulseMax(90)
    l_setPulseSpeed(5)
    l_setPulseSpeedR(10)
    l_setPulseDelayMax(10)

    l_setBeatPulseMax(20)
    l_setBeatPulseDelayMax(3600/125)
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
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

color = 0
-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	color = (color + 1)%360
	l_setPulseMax((360/color)*20 + 70)
end