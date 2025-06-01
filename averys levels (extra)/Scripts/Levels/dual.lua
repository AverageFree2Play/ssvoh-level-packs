-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "nextpatterns.lua")

--dual action

function dBarrage(mHalf)
	openSide = math.random(0, 4)
	for i = 0, 4 do
		if i ~= openSide then
			w_wallAdj(i + 5 * mHalf, THICKNESS, 0.8)
		end
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 7.5)
end

function dTunnel(mTimes, mHalf)
	start = math.random(0, 1)
	for i = 0, mTimes do
		for j = 0, 3 do
			w_wallAdj(mHalf * 5 + start + j, THICKNESS, 0.8)
		end
		t_wait(getPerfectDelay(THICKNESS) * 7.5)
		for j = 0, 3 do
			w_wallAdj((1 - mHalf) * 5 + 1 - start + j, THICKNESS, 0.8)
		end
		t_wait(getPerfectDelay(THICKNESS) * 7.5)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 3)
end

function dAlt(mTimes, mHalf)
	for i = 0, mTimes do
		w_wallAdj(mHalf * 5, THICKNESS, 0.8)
		w_wallAdj(mHalf * 5 + 2, THICKNESS, 0.8)
		w_wallAdj(mHalf * 5 + 4, THICKNESS, 0.8)
		t_wait(getPerfectDelay(THICKNESS) * 5.5)
		w_wallAdj((1 - mHalf) * 5 + 1, THICKNESS, 0.8)
		w_wallAdj((1 - mHalf) * 5 + 3, THICKNESS, 0.8)
		t_wait(getPerfectDelay(THICKNESS) * 5.5)
	end
	t_wait(getPerfectDelay(THICKNESS) * 3)
end
-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey == 0 then dBarrage(half)
		elseif mKey == 1 then dTunnel(math.random(1, 2), math.random(0, 1))
		elseif mKey == 2 then dAlt(math.random(1, 2), math.random(0, 1))
	end
	t_wait(getPerfectDelay(THICKNESS) * 5)
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2}
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.15)
    l_setSpeedInc(0.10)
    l_setRotationSpeed(0.1)
    l_setRotationSpeedMax(0.75)
    l_setRotationSpeedInc(0.05)

    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setFastSpin(70)
    l_setSides(10)
    l_setSidesMin(10)
    l_setSidesMax(10)

    l_setIncTime(15000000000000000)

    l_setPulseMin(140)
    l_setPulseMax(160)
    l_setPulseSpeed(1)
    l_setPulseSpeedR(1)
    l_setPulseDelayMax(30)

	l_setBeatPulseMax(0)
    l_setBeatPulseDelayMax(0)
end

function doublearrows()
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	s_set3dSkew(0.2)
	s_set3dPulseSpeed(0)
	l_setSides(36)
	w_wallAcc(16, 2000, 24, -4, 0, 24)
	w_wallAcc(34, 2000, 24, -4, 0, 24)
	t_wait(10)
	--doublearrows()
	half = 0
	
	delayMult = 1.1
	count = 0
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	l_setSides(10)
	addPattern(keys[index])
	index = index + 1
	if index - 1 == table.getn(keys) then
		index = 1
	end
	half = 1 - half
	
	count = count + 1
	if count % 10 == 0 then
		if delayMult > 0.96 then
			delayMult = delayMult - 0.005
			l_setDelayMult(delayMult)
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
timer = 3
function onUpdate(mFrameTime)
	if timer <= 0 then
		timer = 3
	end
	timer = timer - 1

	if timer%3==0 then
		l_setBeatPulseMax(-175)
	else
		l_setBeatPulseMax(10)
	end
end