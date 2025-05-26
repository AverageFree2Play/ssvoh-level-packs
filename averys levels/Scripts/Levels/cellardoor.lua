-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

function warningWall(mSide)
	w_wallAcc(mSide, THICKNESS, 10, -1.3, -5, 10)
end

function fastWall(mSide)
	w_wallAcc(mSide, THICKNESS , 2, 1, 0, 10)
end

function pShootBarrage(delayMult)
	side = getRandomSide()
	warningWall(side)
	t_wait(getPerfectDelay(THICKNESS) * 8 * delayMult)
	for i = 0, l_getSides() - 2 do
		fastWall(side + i + 1)
	end
	t_wait(getPerfectDelay(THICKNESS) * 4.5 * delayMult)
	--fastWall(side)
	t_wait(getPerfectDelay(THICKNESS) * 7 * delayMult)
end

function pShootBarrageR(delayMult)
	side = getRandomSide()
	warningWall(side)
	warningWall(side + l_getSides()/2)
	t_wait(getPerfectDelay(THICKNESS) * 8 * delayMult)
	for i = 0, (l_getSides()/2) - 2 do
		fastWall(side + i + 1)
		fastWall(side + l_getSides() / 2 + i + 1)
	end
	t_wait(getPerfectDelay(THICKNESS) * 4.5 * delayMult)
	--fastWall(side)
	--fastWall(side + l_getSides()/2)
	t_wait(getPerfectDelay(THICKNESS) * 7 * delayMult)
end

function pShootBarrageReturn(delayMult)
	side = getRandomSide()
	warningWall(side)
	t_wait(getPerfectDelay(THICKNESS) * 8 * delayMult)
	for i = 0, l_getSides() - 2 do
		fastWall(side + i + 1)
	end
	t_wait(getPerfectDelay(THICKNESS) * 4.5 * delayMult)
	fastWall(side)
	t_wait(getPerfectDelay(THICKNESS) * 7 * delayMult)
end

function pShootBarrageRReturn(delayMult)
	side = getRandomSide()
	warningWall(side)
	warningWall(side + l_getSides()/2)
	t_wait(getPerfectDelay(THICKNESS) * 8 * delayMult)
	for i = 0, (l_getSides()/2) - 2 do
		fastWall(side + i + 1)
		fastWall(side + l_getSides() / 2 + i + 1)
	end
	t_wait(getPerfectDelay(THICKNESS) * 4.5 * delayMult)
	fastWall(side)
	fastWall(side + l_getSides()/2)
	t_wait(getPerfectDelay(THICKNESS) * 7 * delayMult)
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then 
		s_setStyle("cellarDoor")
		pShootBarrage(delayMult)
	elseif mKey == 1 then 
		s_setStyle("cellarDoor")
		pShootBarrageR(delayMult)
	elseif mKey == 2 then
		s_setStyle("cellarDoorBlack")
		pShootBarrageReturn(delayMult)
	elseif mKey == 3 then 
		s_setStyle("cellarDoorBlack")
		pShootBarrageRReturn(delayMult)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = {0,0,0,1,1,2,3}
shuffle(keys)
index = 0

delayMult = 1
count = 0
sides = 4
nextincr = 10
tracker = delayMult*100

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.65)
    l_setSpeedInc(0.10)
    l_setRotationSpeed(0.21)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.045)
    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setSides(4)
	l_setSidesMin(4)
    l_setSidesMax(4)
    l_setIncTime(999999999)

	l_setPulseMin(60)
	l_setPulseMax(100)
    l_setPulseSpeed(1)
    l_setPulseSpeedR(10) 
    l_setPulseDelayMax(10)

    l_setFastSpin(200)

    l_setBeatPulseMax(20)
    l_setBeatPulseDelayMax(3600/145)

	--l_addTracked("tracker", "delay")

	--setStyleValueFloat("3D_pulse_speed", 0);
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
			--delayMult = delayMult - 0.025
			tracker = delayMult*100
			--e_messageAddImportant("Delay: "..tracker.."%", 100)
        	a_playSound("levelup.ogg")
        	a_playSound("beep.ogg")
        	a_playSound("increment.ogg")
			nextincr = nextincr + 2
		end
		if sides < 10 then
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
	s_setHueMin(360*(count / nextincr))
	s_setHueMax(360*(count / nextincr))
	--s_set3DSkew((count / nextincr) * 0.5)
	--s_set3DSpacing(20*(count / nextincr))
	--s_set3DDepth(10*(count / nextincr))
	l_setRotationSpeed(0.35 * (count / nextincr) * getRandomDir())
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

timer = 0
-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	s_setHueMax(s_getHueMax() + 0.02)
	s_setHueMin(s_getHueMin() + 0.02)
	timer = (timer + 1)%360
	--s_set3DSkew((count / nextincr) * 0.25 + s_get3DSkew()*(timer/180))
	--s_setPulseIncrement(math.random())
end