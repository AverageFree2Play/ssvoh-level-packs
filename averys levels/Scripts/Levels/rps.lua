-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

function executeRPSKill(mSide)
	for i = 0,11 do
		cWall(mSide + i)
	end
	t_wait(120)
end

function establishRPSBoundaries()
	w_wallAcc(0, 1500, 9, -0.11, 0, 10)
	w_wallAcc(12, 1500, 9, -0.11, 0, 10)
	w_wallAcc(13, 1500, 9, -0.11, 0, 10)
	w_wallAcc(14, 1500, 9, -0.11, 0, 10)
	w_wallAcc(25, 1500, 9, -0.11, 0, 10)
	w_wallAcc(26, 1500, 9, -0.11, 0, 10)
	w_wallAcc(27, 1500, 9, -0.11, 0, 10)
	w_wallAcc(40, 1500, 9, -0.11, 0, 10)
	w_wallAcc(41, 1500, 9, -0.11, 0, 10)
end
-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	e_messageAddImportant("Rock", 30)
	e_messageAddImportant("Paper", 30)
	e_messageAddImportant("Scissors", 30)
	e_messageAddImportant("Shoot!", 30)
	t_wait(90)
	if mKey == 0 then
		executeRPSKill(1);
	elseif mKey == 1 then
		executeRPSKill(15);
	elseif mKey == 2 then
		executeRPSKill(28);
	end
end

function lerp(a, b, t)
    return a * (1-t) + (b*t)
end

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(1)
    l_setSpeedInc(0)
    l_setRotationSpeed(0.1)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.04)
    l_setDelayMult(1)
    l_setDelayInc(0)
    l_setSides(42)
	l_setSidesMin(42)
    l_setSidesMax(42)
    l_setIncTime(999999999)

	l_setPulseMin(64)
	l_setPulseMax(84)
    l_setPulseSpeed(0)
    l_setPulseSpeedR(0) 
    l_setPulseDelayMax(9)

	l_setSwapEnabled(true)
    l_setSwapCooldownMult(1)

    l_setBeatPulseMax(10)
    l_setBeatPulseDelayMax(0)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	establishRPSBoundaries();
	if (u_getDifficultyMult() > 1) then
		e_messageAddImportant("No Bullshit Difficulty Engaged!", 90);
		THICKNESS= 200;
		t_wait(90);
	else
		THICKNESS = 40;
	end
	t_wait(120);
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
	if (u_getDifficultyMult() > 1) then
		l_setSpeedMult(60);
	else
		l_setSpeedMult(12);
	end
	addPattern(u_rndInt(0,2))
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

THICKNESS= 200
dirChangeTime = 100;
startThing = 0;
-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	dirChangeTime = dirChangeTime - mFrameTime;
	startThing = startThing + mFrameTime;
	if startThing > 60 and startThing < 80 then
		l_setBeatPulseMax(lerp(l_getBeatPulseMax(), 10, 0.5 * mFrameTime));
	end
	if dirChangeTime < 0 then
		-- do not change direction while fast spinning
		if u_isFastSpinning() == false then
			l_setRotationSpeed(l_getRotationSpeed() * -1.0)
			dirChangeTime = 300
		end
	end
end