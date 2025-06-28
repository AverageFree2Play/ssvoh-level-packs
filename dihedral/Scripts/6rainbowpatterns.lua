u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")

function getRandomSide() return math.random(0, 5) end

-- pAltBarrage: spawns a series of cAltBarrage
function pAltBarrage(mTimes, mStep)
	delay = getPerfectDelay(THICKNESS) * 5.6
	
	for i = 0, mTimes do
		-- cAltBarrage(i, mStep)
		for k = 0, 6 / mStep, 1 do
			sides = l_getSides()/6
			for j = 1, sides do
				cWall((k * mStep + i) * sides + j)
			end
		end
		
		t_wait(delay)
	end
	
	t_wait(delay)
end

-- pMirrorSpiral: spawns a spiral of rWallEx
function pSimpleSpiral(mTimes, mExtra)
	oldThickness = THICKNESS
	THICKNESS = getPerfectThickness(THICKNESS) * 1.1
	delay = getPerfectDelay(THICKNESS)
	startSide = getRandomSide()
	loopDir = getRandomDir()
	j = 0
	
	for i = 0, mTimes do
		-- rWallEx((startSide + j)*l_getSides()*6/7, (mExtra+1)*l_getSides()/7)
		
		cWallEx((startSide + i*loopDir)*l_getSides()*5/6, (mExtra+1)*l_getSides()/6)
		
		j = j + loopDir
		t_wait(delay)
	end
	
	THICKNESS = oldThickness
	
	t_wait(getPerfectDelay(THICKNESS) * 6.5)
end

-- pBarrageSpiral: spawns a spiral of cBarrage
function pBarrageSpiral(mTimes, mDelayMult, mStep)
	delay = getPerfectDelay(THICKNESS) * 5.6 * mDelayMult
	startSide = getRandomSide()
	loopDir = mStep * getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		-- cBarrage(startSide + j)
		for k = 0, l_getSides()*5/6, 1 do
			cWall((startSide + j)*l_getSides()*5/6 + k + 1)
		end
		
		j = j + loopDir
		t_wait(delay)
		-- if(l_getSides() < 6) then t_wait(delay * 0.6) end
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 6.1)
end

-- pInverseBarrage: spawns two barrages who force you to turn 180 degrees
function pInverseBarrage(mTimes)
	delay = getPerfectDelay(THICKNESS) * 9.9
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		-- cBarrage(startSide)
		for k = 0, l_getSides()*5/6, 1 do
			cWall((startSide)*6 + k + 1)
		end
		t_wait(delay)
		if(l_getSides() < 6) then t_wait(delay * 0.8) end
		-- cBarrage(startSide + getHalfSides())
		for k = 0, l_getSides()*5/6, 1 do
			cWall((startSide + 3)*l_getSides()*5/6 + k + 1)
		end
		t_wait(delay)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 2.5)
end

-- pTunnel: forces you to circle around a very thick wall
function pTunnel(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5
	startSide = getRandomSide()
	loopDir = getRandomDir()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			for k = -1, l_getSides()/6 +1 do
				w_wall(startSide*l_getSides()*5/6 - k, myThickness + 5 * l_getSpeedMult() * delay)
			end
		end
		
		-- cBarrage(startSide + loopDir)
		for k = 0, l_getSides()*5/6, 1 do
			cWall((startSide + loopDir)*l_getSides()*5/6 + k + 1)
		end
		t_wait(delay)
		
		loopDir = loopDir * -1
	end
	
	THICKNESS = oldThickness
end