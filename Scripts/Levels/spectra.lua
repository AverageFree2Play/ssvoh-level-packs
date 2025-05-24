-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "evolutionpatterns.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "nextpatterns.lua")

preAdjustedThickness = 0

function adjustThicknessForLowDM(mult)
    preAdjustedThickness = THICKNESS

    if u_getDifficultyMult() < 1 then
        THICKNESS = THICKNESS * mult
    end
end

function restoreThicknessForLowDM()
    THICKNESS = preAdjustedThickness
end

--patterns used to block vision
function blockWall(mSide)
	w_wallAcc(mSide, THICKNESS * 10, 10, -0.06, 0, 2.5)
end

function pBlock(mSide, mTimes, mDelayMult)
	for i = 0, mTimes do
		blockWall(mSide + i)
		t_wait(getPerfectDelay(THICKNESS) * 3 * mDelayMult)
	end
end

function distWall(mSide)
	w_wallAcc(mSide, THICKNESS * 1.5, 10, -0.05, 0, 2.75)
end

function pDistract()
	for i = 0, l_getSides() - 1 do
		distWall(i)
		t_wait(getPerfectDelay(THICKNESS) * 1.5)
	end
	t_wait(getPerfectDelay(THICKNESS) * 5)
end

-- this function adds a pattern to the timeline based on a key
--[[function addPattern(mKey)    

    hmcSimpleBarrageSNeigh(getRandomSide(), l_getRotationSpeed()*20, 1) 
    t_wait(getPerfectDelay(THICKNESS) * 6)
end]]
function addPattern(mKey)
    if mKey == 0 then
        cWallEx(getRandomSide(), 0)
        t_wait(getPerfectDelay(THICKNESS) * 6)
    elseif mKey == 1 then
        rWallEx(getRandomSide(), 0)
        t_wait(getPerfectDelay(THICKNESS) * 6)
    elseif mKey == 2 then
        rWallEx(getRandomSide(), 1)
        t_wait(getPerfectDelay(THICKNESS) * 6)
    else
        cBarrage(getRandomSide())
        t_wait(getPerfectDelay(THICKNESS) * 6)
    end
end


-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = {0,0,0,1,1,2,2,3}--{ 0, 0, 1, 1, 2, 2, 3, 4, 5, 5, 6, 7, 7, 8 }
shuffle(keys)
index = 0
-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
	if u_getDifficultyMult() > 3 then
        l_setSpeedMult(1.65)
    else
        l_setSpeedMult(1.74)
    end
	l_setDelayMult(1.0)
    l_setDelayInc(0.0075)
    l_setDelayMax(1.165)

	l_setSides(6)
	l_setSidesMin(6)
	l_setSidesMax(6)
    l_setIncTime(1000000000)

	l_setSpeedInc(0.18)
    l_setSpeedMax(4)
    l_setRotationSpeed(0)
    l_setRotationSpeedMax(0.9)

	l_setPulseInitialDelay(24.489)
	l_setPulseMin(74.73)
    l_setPulseMax(91)
    l_setPulseSpeed(1)
    l_setPulseSpeedR(60/130)
    l_setPulseDelayMax(10)

    l_setFastSpin(200)

	l_setBeatPulseMax(20)
    l_setBeatPulseDelayMax(3600/130)
    l_setBeatPulseSpeedMult(1.35) -- Slows down the center going back to normal

    l_addTracked("rotSpeedIMax", "Rotation Speed")

	--setStyleValueFloat("3D_pulse_speed", 0);
    --l_setSwapEnabled(true)

    l_setSwapCooldownMult(0.6)
end
-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	pBlock(getRandomSide(), 5, 1.2)
	pDistract()
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	addPattern(keys[index])
	index = index + 1
	if index - 1 == table.getn(keys) then
		index = 1
	end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
	enableSwapIfSpeedGEThan(5);
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

function increment()
    a_playSound("levelUp.ogg")
    rotSpeedIMin = clamp(rotSpeedIMin - 0.05,-1,1)
    rotSpeedIMax = clamp(rotSpeedIMax + 0.05,-1,1)
    pACBarrageDeception()
end

-- onUpdate is an hardcoded function that is called every frame
rotSpeedIMin = -0.5
rotSpeedIMax = 0.5
rotSpeedIStep = 0.00025

function onUpdate(mFrameTime)
    if(l_getRotationSpeed() > rotSpeedIMax) then 
        rotSpeedIStep = rotSpeedIStep * -1
        increment()
    end
    if l_getRotationSpeed() == 0 then
        a_playSound("beep.ogg")
        a_playSound("increment.ogg")
    end
    if(l_getRotationSpeed() < rotSpeedIMin) then 
        rotSpeedIStep = rotSpeedIStep * -1
        increment()
    end

	l_setRotationSpeed(l_getRotationSpeed()+rotSpeedIStep)
end