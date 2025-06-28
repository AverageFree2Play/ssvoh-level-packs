-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")


-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
		if mKey ==  0 then pAltBarrage(math.random(2, 4), 2) 
	elseif mKey ==  1 then pMirrorSpiral(math.random(3, 6), 0)
	elseif mKey ==  2 then pBarrageSpiral(math.random(0, 3), 1, 1)
	elseif mKey ==  3 then pBarrageSpiral(math.random(0, 2), 1.2, 2)
	elseif mKey ==  4 then pBarrageSpiral(2, 0.7, 1)
	elseif mKey ==  5 then pInverseBarrage(0)
	elseif mKey ==  6 then pTunnel(math.random(1, 3))
	elseif mKey ==  7 then pMirrorWallStrip(1, 0)
	elseif mKey ==  8 then pWallExVortex(0, 1, 1)
	elseif mKey ==  9 then pDMBarrageSpiral(math.random(4, 7), 0.38, 1) t_wait(10)
	elseif mKey == 10 then pRandomBarrage(math.random(2, 4), 2.25)
	end
end

function getSensitivity()
	return baseSens + 0.05*rSens
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 7, 8, 9, 10, 10, 10 }
shuffle(keys)
index = 0
rSens = 0
baseSens = 0.5
mult = 1
sensitivity = getSensitivity()

specialKeys = {} -- For specials.
specials = {"inverse", "frozen"}
shuffle(specials)
currSpecial = 1
special = "none"
specialIndex = 1

frozen = false

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
	l_setSpeedMult(1.7)
    l_setSpeedInc(0.1)
    l_setRotationSpeed(0)
    l_setRotationSpeedMax(2)
    l_setRotationSpeedInc(0)
    l_setDelayMult(1.10)
    l_setDelayInc(-0.01)
    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)
    l_setIncTime(10)

    -- l_setPulseMin(50)
    -- l_setPulseMax(120)
    -- l_setPulseSpeed(3)
    -- l_setPulseSpeedR(2.5)
    -- l_setPulseDelayMax(1)
    l_setPulseMin(75)
    l_setPulseMax(100)
    l_setPulseSpeed(1.2)
    l_setPulseSpeedR(1)
    l_setPulseDelayMax(23.9)

	l_addTracked("sensitivity","sensitivity")
    l_addTracked("special", "special")
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	e_messageAddImportant("rotation sensitivity: ".. sensitivity, 170)
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
	rSens = rSens + 1
	sensitivity = getSensitivity()

	if special == "none" then
        special = specials[currSpecial]
        e_messageAddImportant("Special: "..special, 120)
        currSpecial = currSpecial + 1
        if (currSpecial - 1 == #specials) then
            currSpecial = 1
            shuffle(specials)
        end
        specialIndex = 1
        if (special == "inverse") then
            mult = -1
        elseif (special == "frozen") then
			mult = -1
			frozen = true
        end
    else
        special = "none"
		frozen = false
		mult = 1
    end
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
end

function onInput(mFrameTime, mMovement, mFocus, mSwap)
    local speed = (frozen and .945 or -sensitivity * mult)
    if mFocus then
        speed = speed/2
    end

	if mMovement ~= 0 then
		l_setRotationSpeed(speed * mMovement)
	else 
		l_setRotationSpeed(0)
	end
end