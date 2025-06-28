execScript("common.lua")


function divider(mSide)
	wallAcc(mSide, THICKNESS * 30, 5, -0.32, 0, 5)
end

function capper(mSide)
	wallAcc(mSide, THICKNESS, 5, -0.32, 0, 5)
end

function pLanes()
	for i = 0, 35 do
		capper(i)
	end
	for i = 0, 5 do
		divider(i*6 + 4)
		divider(i*6 + 3)
		divider(i*6 + 2)
		divider(i*6 + 1)
	end
	wait(getPerfectDelay(THICKNESS) * 6)
end

function slowdrift(mSide)
	wallAcc(mSide, THICKNESS, 2, -0.05, 0.7, 2)
end

function slowbar(mSide)
	wallAcc(mSide, THICKNESS, 2, -0.05, 0.4, 2)
end

function pDriftBarrage()
	startSide = getRandomSide()
	for i = 0, 29 do
		slowbar(startSide + i)
	end
	for i = 30, 35 do
		slowdrift(startSide + i)
	end
	wait(getPerfectDelay(THICKNESS)*11)
end

function pDoubleDriftBarrage()
	startSide = getRandomSide()
	for i = 0, 11 do
		slowbar(startSide + i)
		slowbar(startSide + i + 18)
	end
	for i = 12, 17 do
		slowdrift(startSide + i)
		slowdrift(startSide + i + 18)
	end
	wait(getPerfectDelay(THICKNESS)*11)
end

function pAltDriftBarrage()
	startSide = getRandomSide()
	for i = 0, 5 do
		slowbar(startSide + i)
		slowbar(startSide + i + 12)
		slowbar(startSide + i + 24)
	end
	for i = 6, 11 do
		slowdrift(startSide + i)
		slowdrift(startSide + i + 12)
		slowdrift(startSide + i + 24)
	end
	wait(getPerfectDelay(THICKNESS)*11)
end

function dipwall(mSide)
	wallAcc(mSide, THICKNESS * 2, 2, -0.0448, -10, 2)
end

function pAltBarrageTriple(mTimes)
	delay = getPerfectDelay(THICKNESS) * 4
	startSide = getRandomSide()
	for i = 0, mTimes do
		for j = 0, 2 do
			cWallEx(startSide + j * 3 + i, 1)
		end
		wait(delay)
	end
	
	wait(delay)
end

function pTripleSpiral(mTimes)
	oldThickness = THICKNESS
	THICKNESS = getPerfectThickness(THICKNESS) / 1.5
	delay = getPerfectDelay(THICKNESS)
	startSide = getRandomSide()
	loopDir = getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		cWallEx(startSide + j, 0)
		cWallEx(startSide + 3 + j, 0)
		cWallEx(startSide + 6 + j, 0)
		j = j + loopDir
		wait(delay)
	end
	
	THICKNESS = oldThickness
	
	wait(getPerfectDelay(THICKNESS) * 6.5)
end

function pBackAndForthTriple(mTimes, mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			wall(startSide, myThickness + 6 * getSpeedMult() * delay)
			wall(startSide + 3, myThickness + 6 * getSpeedMult() * delay)
			wall(startSide + 6, myThickness + 6 * getSpeedMult() * delay)
		end
		
		wall(startSide + 1, oldThickness*2)
		wall(startSide + 4, oldThickness*2)
		wall(startSide + 7, oldThickness*2)
		wait(delay*0.5*mDelayMult)
		wall(startSide + 2, oldThickness*2)
		wall(startSide + 5, oldThickness*2)
		wall(startSide + 8, oldThickness*2)
		wait(delay*0.5*mDelayMult)
		
	end
	
	THICKNESS = oldThickness
	wait(delay)
end

function pTunnelDelay(mTimes, mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5 * mDelayMult
	startSide = getRandomSide()
	loopDir = getRandomDir()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			wall(startSide, myThickness + 5 * getSpeedMult() * delay)
		end
		
		cBarrage(startSide + loopDir)
		wait(delay)
		
		loopDir = loopDir * -1
	end
	
	THICKNESS = oldThickness
end

function pVortexTriple(mTimes)
	delay = getPerfectDelay(THICKNESS) * 4
	loopDir = getRandomDir()
	currentSide = getRandomSide()
	
	for i = 0, 2 do
		currentSide = currentSide + loopDir
		for j = 0, 2 do
			cWallEx(currentSide + j * 3, 1)
		end
		wait(delay)
	end

	loopDir = loopDir * -1
	currentSide = currentSide + loopDir
	for j = 0, 2 do
		cWallEx(currentSide + j * 3, 1)
	end
	wait(delay)
	currentSide = currentSide - loopDir
	for j = 0, 2 do
		cWallEx(currentSide + j * 3, 1)
	end
	wait(delay)
	
	wait(delay)
end

function pWrapAroundOdd(mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5 * mDelayMult
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	cWallEx(startSide, getSides() - 2)
	wait(delay)
	cWallEx(startSide + getHalfSides(), getSides() - 3)
	cWallExThick(startSide + getHalfSides() + 1, getSides() - 5, THICKNESS*2.5)
	wall(startSide - 1, myThickness + 8 * getSpeedMult() * delay)
	wait(delay)
	cWallEx(startSide + 1, getSides() - 4)
	--wall(startSide + 2, THICKNESS*2)
	wait(delay*0.7)
	cWallEx(startSide + getHalfSides(), getSides() - 3)
	
	
	THICKNESS = oldThickness
	wait(delay)
end

function pTunnelShortNine(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 3.2
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			wall(startSide, myThickness + 10 * getSpeedMult() * delay)
		end
		
		cWallExThick(startSide + 1, getSides() - 5, oldThickness)
		wait(delay*0.65)
		cWallExThick(startSide + 4, getSides() - 5, oldThickness)
		wait(delay*0.65)
		
	end
	wait(delay*2)
	THICKNESS = oldThickness
end

function pTripleAround(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 3.6
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			wall(startSide, myThickness + 10 * getSpeedMult() * delay)
			wall(startSide + 1, myThickness + 10 * getSpeedMult() * delay)
			wall(startSide + 2, myThickness + 10 * getSpeedMult() * delay)
		end
		
		cWallExThick(startSide + 8, getSides() - 2, oldThickness)
		wait(delay*0.65)
		cWallExThick(startSide + 5, getSides() - 2, oldThickness)
		wait(delay*0.65)
		
	end
	wait(delay*2)
	THICKNESS = oldThickness
end

function pInverseBarrageOdd(mTimes)
	delay = getPerfectDelay(THICKNESS) * 8.2
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		cWallEx(startSide + 2, getSides() - 3)
		wait(delay)
		cBarrage(startSide + getHalfSides())
		wait(delay)
	end
	
	wait(getPerfectDelay(THICKNESS) * 2.5)
end

function pTripleWallStrip(mTimes)
	delay = getPerfectDelay(THICKNESS) * 2
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		cWall(startSide)
		cWall(startSide + 3)
		cWall(startSide + 6)
		wait(delay)
	end
	
	wait(getPerfectDelay(THICKNESS) * 3.5)
end

function pHalfAltBarrageTriple(mTimes)
	delay = getPerfectDelay(THICKNESS) * 4
	startSide = getRandomSide()
	for i = 0, mTimes do
		cWallEx(startSide + 2, getSides() - 6)
		cWall(startSide)
		cWall(startSide - 2)
		wait(delay)
		cWallEx(startSide + 1, getSides() - 4)
		cWall(startSide - 1)
		wait(delay)
	end
	
	wait(delay)
end

function decelWall(mSide)
	wallAcc(mSide, THICKNESS, 20, -5.3, 0.5, 20)
end

function decelWallThick(mSide, mThickness)
	wallAcc(mSide, mThickness, 20, -5.3, 0.5, 20)
end

function decelWallEx(mSide, mExtra)
	for i = 0, mExtra do
		decelWall(mSide + i)
	end
end

function decelWallExThick(mSide, mExtra, mThickness)
	for i = 0, mExtra do
		wallAcc(mSide, mThickness, 20, -5.3, 0.5, 20)
	end
end

function rDecelWall(mSide)
	decelWall(mSide)
	decelWall(mSide + getSides()/2)
end

function rDecelWallEx(mSide, mExtra)
	decelWallEx(mSide, mExtra)
	decelWallEx(mSide + getSides()/2, mExtra)
end

function cDecelBarrageN(mSide, mNeighbors)
	for i = mNeighbors, getSides() - 2 - mNeighbors, 1 do
		decelWall(mSide + i + 1)
	end
end

function cDecelBarrage(mSide) 
	cDecelBarrageN(mSide, 0) 
end

function cDecelAltBarrage(mSide, mStep)
	for i = 0, getSides() / mStep, 1 do
		decelWall(mSide + i * mStep)
	end
	wait(getPerfectDelay(THICKNESS) * 4)
end

function pDecelAltBarrage(mTimes, mStep)
	delay = getPerfectDelay(THICKNESS) * 1.5
	
	for i = 0, mTimes do
		cDecelAltBarrage(i, mStep)
		wait(delay)
	end
	
	wait(delay * 4)
end

function pDecelMirrorSpiral(mTimes, mExtra)
	oldThickness = THICKNESS
	THICKNESS = getPerfectThickness(THICKNESS) / 1.5
	delay = getPerfectDelay(THICKNESS)
	startSide = getRandomSide()
	loopDir = getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		rDecelWallEx(startSide + j, mExtra)
		j = j + loopDir
		wait(delay)
	end
	
	THICKNESS = oldThickness
	
	wait(getPerfectDelay(THICKNESS) * 8)
end

function pDecelBarrageSpiral(mTimes, mDelayMult, mStep)
	delay = getPerfectDelay(THICKNESS) * 5.6 * mDelayMult
	startSide = getRandomSide()
	loopDir = mStep * getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		cDecelBarrage(startSide + j)
		j = j + loopDir
		wait(delay)
		if(getSides() < 6) then wait(delay * 0.6) end
	end
	
	wait(getPerfectDelay(THICKNESS) * 6.1)
end

function pDecelVortex(mTimes, mStep, mExtra)
	delay = getPerfectDelay(THICKNESS) * 5.0 
	startSide = getRandomSide()
	loopDir = getRandomDir()
	currentSide = startSide
	
	for j = 0, mTimes do
		for i = 0, mStep do
			currentSide = currentSide + loopDir
			rDecelWallEx(currentSide, mExtra)
			wait(delay)
		end
		
		loopDir = loopDir * -1
		
		for i = 0, mStep + 1 do
			currentSide = currentSide + loopDir;
			rDecelWallEx(currentSide, mExtra)
			wait(delay)
		end
	end
	
	wait(getPerfectDelay(THICKNESS) * 5.5)
end

function pDecelInverseBarrage(mTimes)
	delay = getPerfectDelay(THICKNESS) * 10
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		cDecelBarrage(startSide)
		wait(delay)
		if(getSides() < 6) then wait(delay * 0.8) end
		cDecelBarrage(startSide + getHalfSides())
		wait(delay)
	end
	
	wait(getPerfectDelay(THICKNESS) * 5)
end

function pDecelRandomBarrage(mTimes, mDelayMult)
	side = getRandomSide()
	oldSide = 0
	
	for i = 0, mTimes do	
		cDecelBarrage(side)
		oldSide = side
		side = getRandomSide()
		wait(getPerfectDelay(THICKNESS) * (2 + (getSideDistance(side, oldSide) * mDelayMult)))
	end
	
	wait(getPerfectDelay(THICKNESS) * 7)
end

function pDecelMirrorWallStrip(mTimes, mExtra)
	delay = getPerfectDelay(THICKNESS) * 3.65
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		rDecelWallEx(startSide, mExtra)
		wait(delay)
	end
	
	wait(getPerfectDelay(THICKNESS) * 6.00)
end

function pDecelTunnel(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 6
	startSide = getRandomSide()
	loopDir = getRandomDir()
	
	THICKNESS = myThickness
	for i = 0, mTimes do
		if i < mTimes then
			wallAcc(startSide, myThickness + 3 * getSpeedMult() * delay, 20, -5.1, 0.5, 20)
		end
		
		cDecelBarrage(startSide + loopDir)
		wait(delay)
		
		loopDir = loopDir * -1
	end
	
	THICKNESS = oldThickness
end

function pDecelBackAndForth(mTimes, mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			wallAcc(startSide, myThickness + 3 * getSpeedMult() * delay, 20, -5.1, 0.5, 20)
			wallAcc(startSide+(getSides()/2), myThickness + 3 * getSpeedMult() * delay, 20, -5.1, 0.5, 20)
		end
		
		wallAcc(startSide+1, oldThickness*1.2, 20, -5.1, 0.5, 20)
		wallAcc(startSide+1+getHalfSides(), oldThickness*1.2, 20, -5.1, 0.5, 20)
		wait(3)
		wallAcc(startSide+2, oldThickness*1.2, 20, -5.1, 0.5, 20)
		wallAcc(startSide+2+getHalfSides(), oldThickness*1.2, 20, -5.1, 0.5, 20)
		wait(delay*0.5*mDelayMult)
		wallAcc(startSide+3, oldThickness*1.2, 20, -5.1, 0.5, 20)
		wallAcc(startSide+3+getHalfSides(), oldThickness*1.2, 20, -5.1, 0.5, 20)
		wait(3)
		wallAcc(startSide+2, oldThickness*1.2, 20, -5.1, 0.5, 20)
		wallAcc(startSide+2+getHalfSides(), oldThickness*1.2, 20, -5.1, 0.5, 20)
		wait(delay*0.5*mDelayMult)
	end
	THICKNESS = oldThickness
	wait(delay / 1.5)
end

function pDecelTunnelShort(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS) / 3
	delay = getPerfectDelay(myThickness) * 14
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			decelWallThick(startSide, myThickness + 5 * getSpeedMult() * delay)
		end
		
		decelWallEx(startSide + 3, getSides() - 4)
		wait(delay*0.7)
		decelWallEx(startSide + 1, getSides() - 4)
		wait(delay*0.7)
		
	end
	wait(delay/1.2)
	THICKNESS = oldThickness
end

function pTunnelShortSeven(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 4
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			wall(startSide, myThickness + 10 * getSpeedMult() * delay)
		end
		
		cWallExThick(startSide + 0, getSides() - 3, oldThickness)
		wait(delay*0.65)
		cWallExThick(startSide + 3, getSides() - 3, oldThickness)
		wait(delay*0.65)
		
	end
	wait(delay)
	THICKNESS = oldThickness
end

function pTunnelRandomBarrage(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 4
	startSide = getRandomSide()
	addSide = math.random(1, getSides() - 1)
	
	for i = 0, mTimes do	
		if i < mTimes then
			wall(startSide, myThickness + 15 * delay)
		end
		cBarrage(startSide + addSide)
		addSideOld = addSide
		while addSide == addSideOld do
			addSide = math.random(1, getSides() - 1)
		end
		wait(getPerfectDelay(THICKNESS) * (2 + math.abs(addSide - addSideOld) * 2))
	end
	
	wait(getPerfectDelay(THICKNESS) * 13.5)
end

function pTunnelAltSeven(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 2
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			wall(startSide, myThickness + 8 * getSpeedMult() * delay)
			wall(startSide + 1, myThickness + 8 * getSpeedMult() * delay)
		end
		
		cWallExThick(startSide + 2, 0, oldThickness)
		cWallExThick(startSide + 4, 0, oldThickness)
		cWallExThick(startSide + 6, 0, oldThickness)
		wait(delay*0.7)
		cWallExThick(startSide + 3, 0, oldThickness)
		cWallExThick(startSide + 5, 0, oldThickness)
		wait(delay*0.7)
		
	end
	wait(delay*1.5)
	THICKNESS = oldThickness
end

function pTunnelSpiral()
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 2
	startSide = getRandomSide()
	loopDir = getRandomDir()
	if loopDir == 1 then
		currentSide = startSide + 2
		for i = 0, getSides() - 2 do
			if i < getSides() - 2 then
				wall(startSide, myThickness + 6 * getSpeedMult() * delay)
			end
			cWallExThick(currentSide, getSides() - 2, oldThickness)
			currentSide = currentSide + 1
			wait(delay*0.65)
		end
	else
		currentSide = startSide
		for i = 0, getSides() - 2 do
			if i < getSides() - 2 then
				wall(startSide, myThickness + 6 * getSpeedMult() * delay)
			end
			cWallExThick(currentSide, getSides() - 2, oldThickness)
			currentSide = currentSide - 1
			wait(delay*0.65)
		end
	end
	
	THICKNESS = myThickness
	wait(delay*2)
	THICKNESS = oldThickness
end

function pTunnelNotsurewhattonamethis(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 2.8
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			wall(startSide, myThickness + 9 * getSpeedMult() * delay)
			wall(startSide + 1, myThickness + 9 * getSpeedMult() * delay)
		end
		
		cWallExThick(startSide + 4, getSides() - 2, oldThickness)
		wait(delay*0.65)
		cWallExThick(startSide + 6, getSides() - 2, oldThickness)
		wait(delay*0.65)
		
	end
	wait(delay)
	THICKNESS = oldThickness
end

function pBackAndForthSeven(mTimes, mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			wall(startSide, myThickness + 7 * getSpeedMult() * delay * mDelayMult)
			wall(startSide + 1, myThickness + 7 * getSpeedMult() * delay * mDelayMult)
			wall(startSide + 4, myThickness + 7 * getSpeedMult() * delay * mDelayMult)
		end
		
		wall(startSide + 2, oldThickness*2)
		wall(startSide + 5, oldThickness*2)
		wait(delay*0.5*mDelayMult)
		wall(startSide + 3, oldThickness*2)
		wall(startSide + 6, oldThickness*2)
		wait(delay*0.5*mDelayMult)
		
	end
	
	THICKNESS = oldThickness
	wait(delay * 0.5)
end

function pTunnelEdgeToMiddle(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 2.8
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			wall(startSide, myThickness + 9 * getSpeedMult() * delay)
			wall(startSide + 1, myThickness + 9 * getSpeedMult() * delay)
		end
		
		cWallExThick(startSide - 2, getSides() - 2, oldThickness)
		wait(delay*0.65)
		cWallExThick(startSide + 3, getSides() - 5, oldThickness)
		wait(delay*0.65)
		
	end
	wait(delay)
	THICKNESS = oldThickness
end

function slowTri(mSide)
	wallAcc(mSide, THICKNESS, 3, -0.2, 0.8, 3)
end

function medTri(mSide)
	wallAcc(mSide, THICKNESS, 3, -0.2, 1.2, 3)
end

function fastTri(mSide)
	wallAcc(mSide, THICKNESS, 3, -0.2, 1.6, 3)
end

function pTrifold()
	startSide = getRandomSide()
	loopDir = getRandomDir()
	slowTri(startSide)
	slowTri(startSide + loopDir)
	medTri(startSide + loopDir)
	medTri(startSide + 2 * loopDir)
	fastTri(startSide + 2 * loopDir)
	fastTri(startSide)
	wait(getPerfectDelay(THICKNESS) * 18)
end

function pTrifold2()
	startSide = getRandomSide()
	loopDir = getRandomDir()
	slowTri(startSide)
	slowTri(startSide + loopDir)
	medTri(startSide + loopDir)
	medTri(startSide + 2 * loopDir)
	fastTri(startSide)
	fastTri(startSide + loopDir)
	wait(getPerfectDelay(THICKNESS) * 18)
end

function pTrifold3()
	startSide = getRandomSide()
	loopDir = getRandomDir()
	slowTri(startSide)
	slowTri(startSide + loopDir)
	medTri(startSide)
	medTri(startSide + loopDir)
	fastTri(startSide + loopDir)
	fastTri(startSide + 2 * loopDir)
	wait(getPerfectDelay(THICKNESS) * 18)
end

function pTrifold4()
	startSide = getRandomSide()
	loopDir = getRandomDir()
	slowTri(startSide + loopDir)
	slowTri(startSide + 2 * loopDir)
	medTri(startSide)
	medTri(startSide + loopDir)
	fastTri(startSide)
	fastTri(startSide + loopDir)
	wait(getPerfectDelay(THICKNESS) * 18)
end

function singularity()
	for i = 0, 599 * 2 + 1 do
		wallAcc(i, THICKNESS * 30, 5, -0.39, 0, 5)
	end
end

function singWall(mSide)
	for i = 0, 99 do
		wallAdj(mSide * 100 + i, THICKNESS * 4, 0.4)
	end
end

function singularityBarrage()
	startSide = math.random(1, 6)
	for i = 0, 4 do
		singWall(startSide + i)
	end
	wait(getPerfectDelay(THICKNESS) * 22)
end

function singAltBarrage(mTimes)
	delay = getPerfectDelay(THICKNESS) * 20
	startSide = math.random(1, 6)
	for i = 0, mTimes do
		for j = 0, 2 do
			singWall(startSide + i + 2*j)
		end
		wait(delay * (22/20))
	end
end

function pRandomBarrageNoRepeats(mTimes, mDelayMult)
	side = getRandomSide()
	oldSide = 0
	
	for i = 0, mTimes do	
		cBarrage(side)
		oldSide = side
		while oldSide == side do
			side = getRandomSide()
		end
		wait(getPerfectDelay(THICKNESS) * (2 + (getSideDistance(side, oldSide)*mDelayMult)))
	end
	
	wait(getPerfectDelay(THICKNESS) * 5.6)
end

function pDriftBarrageDarkroom()
	startSide = getRandomSide()
	for i = 1, 500 do
		slowbar(startSide + i)
	end
	for i = 501, 600 do
		slowdrift(startSide + i)
	end
	wait(getPerfectDelay(THICKNESS)*11)
end

function pDoubleDriftBarrageDarkroom()
	startSide = getRandomSide()
	for i = 1, 200 do
		slowbar(startSide + i)
		slowbar(startSide + i + 300)
	end
	for i = 201, 300 do
		slowdrift(startSide + i)
		slowdrift(startSide + i + 300)
	end
	wait(getPerfectDelay(THICKNESS)*11)
end

function pAltDriftBarrageDarkroom()
	startSide = getRandomSide()
	for i = 1, 100 do
		slowbar(startSide + i)
		slowbar(startSide + i + 200)
		slowbar(startSide + i + 400)
	end
	for i = 100, 199 do
		slowdrift(startSide + i)
		slowdrift(startSide + i + 200)
		slowdrift(startSide + i + 400)
	end
	wait(getPerfectDelay(THICKNESS)*11)
end