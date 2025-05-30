-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then
		side = math.random(0,6)
		for i = side * 5, (side * 5) + 24, 1 do
			cWall(i)
		end
		t_wait(80)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0 }
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(1.25)
    l_setSpeedInc(0.2)
    l_setRotationSpeed(0.05)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.1)
    l_setDelayMult(1)
    l_setDelayInc(0)
    l_setSides(30)
	l_setSidesMin(30)
    l_setSidesMax(30)
    l_setIncTime(20)

	l_setPulseMin(68)
	l_setPulseMax(80)
    l_setPulseSpeed(0)
    l_setPulseSpeedR(0) 
    l_setPulseDelayMax(8)
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	THICKNESS = 20
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
	addPattern(keys[index]);
	index = index + 1
	if index - 1 == #keys then
		index = 1
	end
	
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

local arrowPosition = 60;

----------------------------------------------------------------------------------------------------------------- Credit to Spyro Oshisaure for the frame limit code
CurFrame = 0
CurFPS = 200

local frame = 0; -- Will be used to reduce the refresh rate of the styles and prevent lag from occurring (Courtesy of Update 2)
local debounce = false; -- Assists in reducing style refresh rate
local prevPosition = 0; -- Will keep the smoothness of motion when the player moves to a different panel


-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	frame = frame + mFrameTime;
	prevPosition = arrowPosition;
--[[if u_isKeyPressed(71) and not u_isKeyPressed(72) then -- The not portion is supposed to stop overlapping input from breaking the tracking process.
		if u_isKeyPressed(38) then -- see if the player is focusing or not
			arrowPosition = arrowPosition - 46.25 * mFrameTime;
		else
			arrowPosition = arrowPosition - 94.54627 * mFrameTime;
		end
	end
	if u_isKeyPressed(72) then
		if u_isKeyPressed(38) then
			arrowPosition = arrowPosition + 46.25 * mFrameTime;
		else
			arrowPosition = arrowPosition + 94.54627 * mFrameTime;
		end
	end]]

	--[[
	if math.floor(arrowPosition / 120) % 30 == 0 then
	execEvent("flash1")
	elseif math.floor(arrowPosition / 120) % 30 == 1 then
	execEvent("flash2")
	elseif math.floor(arrowPosition / 120) % 30 == 2 then
	execEvent("flash3")
	elseif math.floor(arrowPosition / 120) % 30 == 3 then
	execEvent("flash4")
	elseif math.floor(arrowPosition / 120) % 30 == 4 then
	execEvent("flash5")
	elseif math.floor(arrowPosition / 120) % 30 == 5 then
	execEvent("flash6")
	elseif math.floor(arrowPosition / 120) % 30 == 6 then
	execEvent("flash7")
	elseif math.floor(arrowPosition / 120) % 30 == 7 then
	execEvent("flash8")
	elseif math.floor(arrowPosition / 120) % 30 == 8 then
	execEvent("flash9")
	elseif math.floor(arrowPosition / 120) % 30 == 9 then
	execEvent("flash10")
	elseif math.floor(arrowPosition / 120) % 30 == 10 then
	execEvent("flash11")
	elseif math.floor(arrowPosition / 120) % 30 == 11 then
	execEvent("flash12")
	elseif math.floor(arrowPosition / 120) % 30 == 12 then
	execEvent("flash13")
	elseif math.floor(arrowPosition / 120) % 30 == 13 then
	execEvent("flash14")
	elseif math.floor(arrowPosition / 120) % 30 == 14 then
	execEvent("flash15")
	elseif math.floor(arrowPosition / 120) % 30 == 15 then
	execEvent("flash16")
	elseif math.floor(arrowPosition / 120) % 30 == 16 then
	execEvent("flash17")
	elseif math.floor(arrowPosition / 120) % 30 == 17 then
	execEvent("flash18")
	elseif math.floor(arrowPosition / 120) % 30 == 18 then
	execEvent("flash19")
	elseif math.floor(arrowPosition / 120) % 30 == 19 then
	execEvent("flash20")
	elseif math.floor(arrowPosition / 120) % 30 == 20 then
	execEvent("flash21")
	elseif math.floor(arrowPosition / 120) % 30 == 21 then
	execEvent("flash22")
	elseif math.floor(arrowPosition / 120) % 30 == 22 then
	execEvent("flash23")
	elseif math.floor(arrowPosition / 120) % 30 == 23 then
	execEvent("flash24")
	elseif math.floor(arrowPosition / 120) % 30 == 24 then
	execEvent("flash25")
	elseif math.floor(arrowPosition / 120) % 30 == 25 then
	execEvent("flash26")
	elseif math.floor(arrowPosition / 120) % 30 == 26 then
	execEvent("flash27")
	elseif math.floor(arrowPosition / 120) % 30 == 27 then
	execEvent("flash28")
	elseif math.floor(arrowPosition / 120) % 30 == 28 then
	execEvent("flash29")
	elseif math.floor(arrowPosition / 120) % 30 == 29 then
	execEvent("flash30")
	end]]
	--log(arrowPosition)
end

function onInput(mFrameTime, mMovement, mFocus, mSwap)
	if mMovement == -1 then -- The not portion is supposed to stop overlapping input from breaking the tracking process.
		if mFocus then -- see if the player is focusing or not
			arrowPosition = arrowPosition - 46.25 * mFrameTime;
		else
			arrowPosition = arrowPosition - 94.54627 * mFrameTime;
		end
	end
	if mMovement == 1 then
		if mFocus then
			arrowPosition = arrowPosition + 46.25 * mFrameTime;
		else
			arrowPosition = arrowPosition + 94.54627 * mFrameTime;
		end
	end
		if (math.floor(frame) % 40 == 0) or (math.floor(prevPosition/120)%30 + 1) ~= (math.floor(arrowPosition/120)%30 + 1) then -- If the time passes or the panel position changes
		if not debounce then
			s_setStyle("flashlight"..(math.floor(arrowPosition/120)%30 + 1));
		end
	end
end