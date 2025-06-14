-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "nextpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "evolutionpatterns.lua")

local side = 0
local sideSpawn = 0;

function warningWall(mSide)
	w_wallAcc(mSide, THICKNESS, 100, -1.3, -5, 13)
end

function fastWall(mSide)
	w_wallAcc(mSide, THICKNESS , 2, 1, 0, 10)
end

function cFastBarrageN(mSide, mNeighbors)
	for i = mNeighbors, l_getSides() - 2 - mNeighbors, 1 do
		fastWall(mSide + i + 1)
	end
end

function cWarnAltBarrage(mSide, mStep)
	for i = 0, l_getSides() / mStep, 1 do
		warningWall(mSide + i * mStep)
	end
end

function cFastBarrage(mSide) 
	cFastBarrageN(mSide, 0) 
end

function cFastAltBarrage(mSide, mStep)
	for i = 0, l_getSides() / mStep, 1 do
		fastWall(mSide + i * mStep)
	end
end

function pShootAlt(delayMult)
	delayMult = delayMult + 0.075
	side = getRandomSide()
	j = math.random(2, 3)
	for i = 0, j do
		cWarnAltBarrage(side + i, 2)
		t_wait(getPerfectDelay(THICKNESS) * 2.5 * delayMult)
	end
	t_wait(getPerfectDelay(THICKNESS) * 8 * delayMult)
	for i = 0, j do
		cFastAltBarrage(side + i + 1, 2)
		t_wait(getPerfectDelay(THICKNESS) * 3.2 * delayMult)
	end
	t_wait(getPerfectDelay(THICKNESS) * 7 * delayMult)
end

function pRandomBarrageShoot(mDelayMult)
	delay = getPerfectDelay(THICKNESS)
	a = getRandomSide()
	b = getRandomSide()
	while b == a do
		b = getRandomSide()
	end
	c = getRandomSide()
	while c == b do
		c = getRandomSide()
	end
	d = getRandomSide()
	while d == c do
		d = getRandomSide()
	end
	warningWall(a)
	t_wait(delay * (2 + (getSideDistance(a, b)* mDelayMult)))
	warningWall(b)
	t_wait(delay * (2 + (getSideDistance(a, b)* mDelayMult)))
	warningWall(c)
	t_wait(delay * (2 + (getSideDistance(a, b)* mDelayMult)))
	warningWall(d)
	t_wait(delay * 8 * mDelayMult)
	cFastBarrage(a)
	t_wait(delay * (1.5 + 2.3*(getSideDistance(a, b)* mDelayMult)))
	cFastBarrage(b)
	t_wait(delay * (1.5 + 2.3*(getSideDistance(b, c)* mDelayMult)))
	cFastBarrage(c)
	t_wait(delay * (1.5 + 2.3*(getSideDistance(c, d)* mDelayMult)))
	cFastBarrage(d)
	t_wait(delay * 7 * delayMult)
end

delayMult = 1

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then pShootAlt(delayMult)
	elseif mKey == 1 then pRandomBarrageShoot(delayMult)
	end
end


-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 1, 1 }
shuffle(keys)
index = 1

count = 0
sides = 4
nextincr = 10

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.05)
    l_setSpeedInc(0.1)
    l_setRotationSpeed(.21)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)
    l_setDelayMult(1.1)
    l_setDelayInc(-0.01)
    l_setFastSpin(200.0)
    l_setSides(4)
    l_setSidesMin(6)
    l_setSidesMax(6)
    l_setIncTime(99999999)

    s_set3dPulseSpeed(0)

    l_setPulseMin(60)
    l_setPulseMax(100)
    l_setPulseSpeed(1)
    l_setPulseSpeedR(10)
    l_setPulseDelayMax(10)

    l_setBeatPulseMax(20)
    l_setBeatPulseDelayMax(28.346)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
    count = count + 1
	if count == nextincr then
		if delayMult > 0.8 then
			delayMult = delayMult - 0.025
			e_messageAddImportant("Delay: "..(delayMult * 100).."%", 100)
			a_playSound("increment.ogg")
			nextincr = nextincr + 2
		end
		if sides < 8 then
			sides = sides + 2
			l_setSides(sides)
		end
		count = 0
	end
	addPattern(keys[index])
	index = index + 1
	if index - 1 == table.getn(keys) then
		index = 1
	end
	s_setHueMin(0)
	s_setHueMax(360*(count / nextincr))
	s_setHueInc(10*(count / nextincr))
	s_set3dSkew((count / nextincr) * 0.5)
	s_set3dSpacing(20*(count / nextincr))
	s_set3dDepth(10*(count / nextincr))
	l_setRotationSpeed(0.35 * (count / nextincr) * getRandomDir())

end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
    level = level + 1;
    special = "none";
    l_setIncTime(20);
    -- Disable the speed and rotation increment
    l_setSpeedInc(0)
    l_setRotationSpeedInc(0)
end

-- continuous direction change (even if not on level increment)
dirChangeTime = 120

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
end
