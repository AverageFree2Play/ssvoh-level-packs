-- include useful files
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "commonpatterns.lua")

function dipwall(mSide)
	w_wallAcc(mSide, THICKNESS * 2, 2, -0.0448, -10, 2)
end

function stretchbarrage()
    -- if count == 5 then 
    --     freeSides = 12
    --     e_messageAddImportant("Free sides: " .. freeSides, 50)
    -- elseif count == 10 then
    --     freeSides = 10
    --     e_messageAddImportant("Free sides: " .. freeSides, 50)
    -- elseif count > 14 and count < 27 then
    --     l_setSides(10 + count)
    --     e_messageAddImportant("Total sides: " .. 10 + count, 50)
    -- end

    local sides = {}
    for j = 0, l_getSides() - 1 do
        sides[j] = j
    end

    --shuffle function didn't work properly so i wrote a new one
    for k = 0, 50 do
        indexA = math.random(0, l_getSides() - 1)
        indexB = math.random(0, l_getSides() - 1)
        temp = sides[indexA]
        sides[indexA] = sides[indexB]
        sides[indexB] = temp
    end

    startSide = getRandomSide()
    for i = 0, l_getSides() - math.ceil(freeSides) do
        dipwall(sides[i])
        t_wait(getPerfectDelay(THICKNESS) / 2)
    end

    t_wait((freeSides - 1) * getPerfectDelay(THICKNESS) / 2)

    count = count + 1
    freeSides = math.max(freeSides - 0.5,5)
end

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
end

count = 0
freeSides = 16

-- onInit is an hardcoded function that is called when the level is first loaded
function onInit()
    l_setSpeedMult(2.65)
    l_setSpeedInc(0.1)
    l_setRotationSpeed(0.15)
    l_setRotationSpeedMax(0.4)
    l_setRotationSpeedInc(0.05)
    l_setDelayMult(1.1)
	l_setDelayInc(-0.01)
    l_setSides(24)
    l_setSidesMin(24)
    l_setSidesMax(24)
    l_setIncEnabled(false)

    l_setPulseMin(60)
    l_setPulseMax(80)
    l_setPulseSpeed(0)
    l_setPulseSpeedR(0)
    l_setPulseDelayMax(4)

    l_setBeatPulseMax(5)
    l_setBeatPulseDelayMax(30)

    l_addTracked("freeSides","free sides")
end

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	e_messageAddImportant("Free sides: "..freeSides, 50)
    e_waitS(0.285)
end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()
    e_eval("stretchbarrage()")
    e_waitS(3)
    e_eval("l_setPulseSpeed(5)")
    e_eval("l_setPulseSpeedR(5)")
    e_eval("l_setRotationSpeed(1)")
    e_waitS(0.25)
    e_eval("l_setPulseSpeed(0)")
    e_eval("l_setPulseSpeedR(0)")
    e_eval("l_setRotationSpeed(0.15)")
    e_waitS(0.23) -- sync with da beat
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