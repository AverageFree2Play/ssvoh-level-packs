-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then pAltBarrage(math.random(2, 3), 2) 
	elseif mKey == 1 then pBarrageSpiral(3, 0.6, 1)
	elseif mKey == 2 then pInverseBarrage(0)
	elseif mKey == 3 then pTunnel(math.random(1, 3))
	elseif mKey == 4 then pMirrorWallStrip(1, 0)
	elseif mKey == 5 then pWallExVortex(0, math.random(1, 2), 1)
	elseif mKey == 6 then pRandomBarrage(math.random(2, 5), 2.25)
	elseif mKey == 7 then pMirrorSpiralDouble(math.random(4, 6), 0)
	elseif mKey == 8 then pMirrorSpiral(math.random(2, 4), 0)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 2, 2, 3, 4, 4, 5, 6, 6, 6, 7, 8, 8 }
shuffle(keys)
index = 0
rotation = 0.5
level = 1
speed = 2;
pattern = 0;
-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2)
    l_setSpeedInc(0.05)
    l_setRotationSpeed(0.2)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0)
    l_setDelayMult(1)
	l_setDelayInc(0)
    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)
    l_setIncTime(25000000000000000000)

    l_setPulseMin(60)
    l_setPulseMax(80)
    l_setPulseSpeed(1)
    l_setPulseSpeedR(1)
    l_setPulseDelayMax(0)

    l_setBeatPulseMax(0)
    l_setBeatPulseDelayMax(0)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	t_wait(10)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
	pattern = pattern + 1
	if pattern == 10 then
		pattern = 0;
		speed = speed * 1.05;
		level = level + 1;
		l_setSpeedMult(speed);
		a_playSound("increment.ogg")
		a_playSound("levelUp.ogg")
		e_messageAddImportant("Level: "..level.."\nSpeed:"..math.floor(speed * 100)/100, 120);
	end
	w_wallAcc(math.random(0,5), 1000, 15, -.5, -.3 - .05 * level, 17.04255162857 * l_getSpeedMult()^-1.0107359)
	addPattern(keys[math.random(1,#keys)])
	if index - 1 == table.getn(keys) then
		index = 1
	end
	t_wait(2)
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
	rotation = rotation + 0.1
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

dirChangeTime = 100
-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	dirChangeTime = dirChangeTime - mFrameTime;
	if dirChangeTime < 0 then
		-- do not change direction while fast spinning
		if u_isFastSpinning() == false then
			l_setRotationSpeed(l_getRotationSpeed() * -1);
			dirChangeTime = 300
		end
	end 
end