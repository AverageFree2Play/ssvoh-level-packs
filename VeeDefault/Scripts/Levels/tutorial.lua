-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	if mKey == 0 then pBarrageSpiral(math.random(1, 2), 1, 1) 
	elseif mKey == 1 then pInverseBarrage(0)
	elseif mKey == 2 then pAltBarrage(math.random(1, 3), 2)
    elseif mKey == 3 then pSpiral(12, 0)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 1, 2 }
shuffle(keys)
index = 0

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(0.85)
    l_setSpeedInc(0.05)
    l_setRotationSpeed(0.04)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.03)
    l_setDelayMult(1)
    l_setDelayInc(0.0)
    l_setFastSpin(0.0)
    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)
    l_setIncTime(15)
    l_setTutorialMode(true)

    --l_setBeatPulseMax(14)
    --l_setBeatPulseDelayMax(21.95) -- BPM is 164, 3600/164 is 21.95
    --l_setBeatPulseSpeedMult(0.45) -- Slows down the center going back to normal
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	e_stopTime(300)
	e_messageAddImportant("welcome to open hexagon",170)
	e_messageAddImportant("use left/right to rotate",170)
	e_messageAddImportant("avoid the walls!",170)
	e_waitUntilS(12); e_eval("t_wait(300)")
	e_waitUntilS(14); e_eval("e_stopTime(300)")
	e_messageAddImportant("great job!",100)
	e_messageAddImportant("after a while, things get harder",200)
	e_waitUntilS(28); e_eval("t_wait(200)")
	e_waitUntilS(30); e_eval("e_stopTime(200)")
	e_messageAddImportant("get to 45 seconds to win!",200)
	e_waitUntilS(45)

	-- tutorial 2
	e_eval([[
		l_setSpeedMult(1)
		l_setSpeedInc(0.075)
		l_setRotationSpeed(0.05)
    	l_setRotationSpeedMax(0.4)
		l_setRotationSpeedInc(0.05)
		l_setDelayMult(1.00)
		l_setDelayInc(0.00)
		l_setFastSpin(0.00)
		l_setSides(6)
		l_setSidesMin(6)
		l_setSidesMax(6)
		l_setIncTime(15)
		l_setWallSkewLeft(15)
		l_setWallSkewRight(-15)

		s_setStyle("tutorial2")

		t_wait(250)
	]])
	e_stopTime(250)
	e_messageAddImportant("this is the second tutorial",170)
	e_messageAddImportant("things are slightly harder now",170)
	e_messageAddImportant("be careful!",170)
	e_waitUntilS(73); e_eval("t_wait(200)")
	e_waitUntilS(75); e_stopTime(200)
	e_messageAddImportant("get to 120 seconds to win!",210)
	e_waitUntilS(120); e_eval("t_wait(600)")
	e_stopTime(300)
	e_messageAddImportant("congratulations!",120)
	e_waitUntilS(121); e_kill()
	--[[// Events
	"events":
	[
		{ "time": 0, 	"type": "timeline_wait", 	"duration": 250 },
		{ "time": 0, 	"type": "time_stop", 		"duration": 250 },
		{ "time": 0, 	"type": "message_add", 		"duration": 170, 	"message":  },
		{ "time": 0, 	"type": "message_important_add", 		"duration": 170, 	"message":  },
		{ "time": 0, 	"type": "message_important_add", 		"duration": 120, 	"message":  },
		{ "time": 28, 	"type": "timeline_wait", 	"duration": 200 },
		{ "time": 30, 	"type": "time_stop", 		"duration": 200 },
		{ "time": 30, 	"type": "message_important_add", 		"duration": 210, 	"message": "get to 45 seconds to win!" },
		{ "time": 43, 	"type": "timeline_wait", 	"duration": 600 },
		{ "time": 45, 	"type": "time_stop",		"duration": 300 },		
		{ "time": 45,	"type": "message_important_add",		"duration": 120,	"message":  },
		{ "time": 46,	"type":	"menu"}
	]]

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
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
end
