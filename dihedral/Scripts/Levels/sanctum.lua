-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "nextpatterns.lua")

function divider(mSide)
	w_wallAcc(mSide, THICKNESS * 30, 5, -0.32, 0, 5)
end

function capper(mSide)
	w_wallAcc(mSide, THICKNESS, 5, -0.32, 0, 5)
end

function pLanes()
	for i = 0, 35 do
		capper(i)
	end
	for i = 0, 5 do
		divider(i*6 + 4)
		divider(i*6 + 3)
		divider(i*6 + 2)
		divider(i*6 + 1)
	end
	t_wait(getPerfectDelay(THICKNESS) * 6)
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then pACBarrageDecelerate()
	elseif mKey == 1 then pACBarrageMulti()
	elseif mKey == 2 then pACSpiral()
	elseif mKey == 3 and u_getDifficultyMult() >= 1 then pACBarrageDeception()
	elseif mKey == 4 then pACAltBarrage(math.random(2, 3))
	elseif mKey == 5 then pACAltBarrageMulti()
	elseif mKey == 6 then pACAltBarrageReveal(math.random(3, 4))
	elseif mKey == 7 then pACInverseBarrage();
	elseif mKey == 8 then pACTunnelReveal(math.random(2, 4));
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3, 3, 4, 5, 6, 7, 7, 8}
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.4)
    l_setSpeedInc(0.1)
    l_setRotationSpeed(0.27)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)
    l_setDelayMult(1.1)
	l_setDelayInc(-0.01)
    l_setFastSpin(70.0)
    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)

    l_setIncTime(15)
	l_setIncEnabled(false)
	l_setRadiusMin(40)

    l_setPulseMin(70)
    l_setPulseMax(90)
    l_setPulseSpeed(1.03)
    l_setPulseSpeedR(0.57)
    l_setPulseDelayMax(9.1)

    l_setBeatPulseMax(17)
    l_setBeatPulseDelayMax(23.8)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	l_setSides(36)
	pLanes()
	l_setRotationSpeed(0.25)
	s_set3dSkew(0.2)
	-- s_set3dPulseSpeed(0)
	l_setPulseMin(80)
	l_setPulseMax(160)
	l_setPulseSpeed(2)
	l_setPulseSpeedR(10)
	l_setPulseDelayMax(30)
	l_setBeatPulseMax(20)
	l_setBeatPulseDelayMax(20)
	--execEvent("slowfastalt")
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	l_setSides(6)
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
function onUpdate(mFrameTime)
end