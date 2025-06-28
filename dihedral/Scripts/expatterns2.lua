u_execScript("common.lua")

--"maze" patterns for Barrage
function pMaze(mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 1.7 * mDelayMult
	startSide = getRandomSide()
	
	THICKNESS = myThickness/3
	
	rWallEx(startSide, (l_getSides()/2)-2)
	t_wait(delay)
	rWall(startSide-1)
	t_wait(delay)
	rWallEx(startSide, (l_getSides()/2)-2)
	t_wait(delay)
	rWallEx(startSide+1, (l_getSides()/2)-2)
	t_wait(delay)
	rWall(startSide)
	t_wait(delay)
	rWallEx(startSide+1, (l_getSides()/2)-2)
	
	THICKNESS = oldThickness
	t_wait(delay*2)
end

function pMaze2(mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 2 * mDelayMult
	startSide = getRandomSide()
	
	THICKNESS = myThickness/3
	
	cWallEx(startSide, l_getSides()-2)
	t_wait(delay)
	w_wall(startSide-2, THICKNESS*3.5)
	w_wall(startSide-4, THICKNESS*3.5)
	w_wall(startSide, THICKNESS*3.5)
	t_wait(delay*0.37)
	cWall(startSide - 3);
	cWall(startSide - 1);
	t_wait(delay)
	cWallEx(startSide + 1, l_getSides()-2);
	t_wait(delay)
	w_wall(startSide-3, THICKNESS*3.5)
	w_wall(startSide-5, THICKNESS*3.5)
	w_wall(startSide-1, THICKNESS*3.5)
	t_wait(delay*0.37)
	cWall(startSide);
	cWall(startSide - 2);
	
	THICKNESS = oldThickness
	t_wait(delay*2)
end

function pMaze3(mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 1.7 * mDelayMult
	startSide = getRandomSide()
	
	THICKNESS = myThickness/3
	
	cWallEx(startSide, l_getSides()-2)
	t_wait(delay)
	rWallEx(startSide+1, (l_getSides()/2)-2)
	t_wait(delay*1.3)
	cWallEx(startSide-1, l_getSides()-2)
	t_wait(delay)
	rWallEx(startSide+3, (l_getSides()/2)-2)
	t_wait(delay*1.3)
	cWallEx(startSide-4, l_getSides()-2)
	t_wait(delay)
	rWallEx(startSide+1, (l_getSides()/2)-2)
	THICKNESS = oldThickness
	t_wait(delay*2)
end

function pMaze4(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 1.5
	startSide = getRandomSide()
	THICKNESS = myThickness/3
	
	rWallEx(startSide, (l_getSides()/2)-2)
	t_wait(delay)
	rWallEx(startSide+1, (l_getSides()/2)-2)
	t_wait(delay)
	rWallEx(startSide, (l_getSides()/2)-2)
	t_wait(delay)
	cWallEx(startSide-4, l_getSides()-3)
	t_wait(delay)
	cWallEx(startSide-3, l_getSides()-2)
	t_wait(delay)
	cWallEx(startSide-4, l_getSides()-2)
	THICKNESS = oldThickness
	t_wait(delay*2)
	
end

function pMaze5()
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 1.5
	startSide = getRandomSide()
	THICKNESS = myThickness/3
	
	cWallEx(startSide+2, l_getSides()-2)
	w_wall(startSide, THICKNESS*6)
	w_wall(startSide+2, THICKNESS*6)
	w_wall(startSide+4, THICKNESS*6)
	t_wait(delay*2)
	w_wall(startSide, THICKNESS*3)
	w_wall(startSide+2, THICKNESS*3)
	t_wait(delay*0.5)
	cWallEx(startSide-1, l_getSides()-2)
	t_wait(delay*0.9)
	w_wall(startSide-2, THICKNESS)
	w_wall(startSide-4, THICKNESS)
	w_wall(startSide-6, THICKNESS)
	t_wait(delay*0.9)
	w_wall(startSide-1, THICKNESS)
	w_wall(startSide-3, THICKNESS)
	w_wall(startSide-5, THICKNESS)
	THICKNESS = oldThickness
	t_wait(delay*2)
	
end

function pMaze6()
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 0.6
	startSide = getRandomSide()
	THICKNESS = myThickness/3
	
	rWallEx(startSide, 0)
	t_wait(delay)
	rWallEx(startSide+1, 0)
	t_wait(delay)
	rWallEx(startSide, 0)
	t_wait(delay)
	rWallEx(startSide+2, 0)
	t_wait(delay)
	rWallEx(startSide-2, 0)
	t_wait(delay*2.3)
	rWallEx(startSide-1, 1)
	t_wait(delay*2.3)
	rWallEx(startSide, 1)
	t_wait(delay*2.3)
	rWallEx(startSide-1, 1)
	THICKNESS = oldThickness
	t_wait(delay*5)
	
end

function pMaze7()
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 1.5
	startSide = getRandomSide()
	THICKNESS = myThickness/3
	
	rWallEx(startSide, 1)
	t_wait(delay)
	rWallThick(startSide - 1, THICKNESS*2)
	t_wait(delay*0.25)
	rWallThick(startSide + 1, THICKNESS*2)
	t_wait(delay*0.7)
	rWall(startSide)
	t_wait(delay*1.25)
	rWallEx(startSide - 1, 1)
	t_wait(delay*1.5)
	cWallEx(startSide - 4, 4)
	t_wait(delay*2)
	
	THICKNESS = oldThickness
	
end

function pMaze8()
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 1.5
	startSide = getRandomSide()
	THICKNESS = myThickness/3
	
	cWallEx(startSide, 2)
	cWall(startSide - 2)
	t_wait(delay)
	cWallEx(startSide + 3, 2)
	cWall(startSide + 1)
	t_wait(delay)
	rWallEx(startSide + 5, 1)
	t_wait(delay)
	cWall(startSide + 1)
	cWall(startSide + 3)
	cWall(startSide + 5)
	t_wait(delay)
	cWall(startSide + 2)
	cWall(startSide + 4)
	cWall(startSide)
	t_wait(delay)
	rWallEx(startSide, 1)
	t_wait(delay)
	rWallEx(startSide + 1, 1)
	
	t_wait(delay*2)
	THICKNESS = oldThickness
	
end

function pMaze9()
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 1.5
	startSide = getRandomSide()
	THICKNESS = myThickness/3
	
	cWallEx(startSide, 2)
	cWall(startSide - 2)
	t_wait(delay * 0.7)
	w_wall(startSide - 1, THICKNESS * 2)
	w_wall(startSide - 3, THICKNESS * 2)
	t_wait(delay)
	cWallEx(startSide + 2, 2)
	cWall(startSide)
	t_wait(delay * 0.7)
	w_wall(startSide - 1, THICKNESS * 2)
	w_wall(startSide + 1, THICKNESS * 2)
	t_wait(delay)
	rWallEx(startSide - 2, 1)
	t_wait(delay * 0.7)
	rWallThick(startSide - 3, THICKNESS * 2)
	t_wait(delay*2)
	THICKNESS = oldThickness
	
end

--"toothpick" variations of common patterns
function pToothpicks(mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 1.5 * mDelayMult
	startSide = getRandomSide()
	THICKNESS = myThickness/25
	
	cWallEx(startSide, l_getSides()-3);
	
	THICKNESS = oldThickness
	t_wait(delay*2)
end

function pAltBarrageT(mTimes, mStep)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(THICKNESS) * 4
	THICKNESS = myThickness/25
	
	for i = 0, mTimes do
		cAltBarrage(i, mStep)
		t_wait(delay)
	end
	t_wait(delay)
	THICKNESS = oldThickness
end

function pMirrorSpiralT(mTimes, mExtra)
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS)
	THICKNESS = oldThickness/25
	startSide = getRandomSide()
	loopDir = getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		rWallEx(startSide + j, mExtra)
		j = j + loopDir
		t_wait(delay)
	end
	
	THICKNESS = oldThickness
	
	t_wait(getPerfectDelay(THICKNESS) * 6.5)
end

function pRandomBarrageT(mTimes, mDelayMult)
	oldThickness = THICKNESS
	THICKNESS = oldThickness/25
	oldSide = 0
	startSide = getRandomSide()
	for i = 0, mTimes do	
		cBarrage(startSide)
		oldSide = startSide
		startSide = getRandomSide()
		t_wait(getPerfectDelay(oldThickness) * (2 + (getSideDistance(startSide, oldSide)*mDelayMult)))
	end
	THICKNESS = oldThickness
	t_wait(getPerfectDelay(oldThickness) * 5.6)
end

function pBarrageSpiralT(mTimes, mDelayMult, mStep)
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 5.6 * mDelayMult
	THICKNESS = oldThickness/25
	startSide = getRandomSide()
	loopDir = mStep * getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		cBarrage(startSide + j)
		j = j + loopDir
		t_wait(delay)
		if(l_getSides() < 6) then t_wait(delay * 0.6) end
	end
	
	t_wait(delay)
	THICKNESS = oldThickness
end

function pWallExVortexT(mTimes, mStep, mExtraMult)
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 5.0 
	startSide = getRandomSide()
	THICKNESS = oldThickness/25
	loopDir = getRandomDir()
	currentSide = startSide
	
	for j = 0, mTimes do
		for i = 0, mStep do
			currentSide = currentSide + loopDir
			rWallEx(currentSide, loopDir * mExtraMult)
			t_wait(delay)
		end
		
		loopDir = loopDir * -1
		
		for i = 0, mStep + 1 do
			currentSide = currentSide + loopDir;
			rWallEx(currentSide, loopDir * mExtraMult)
			t_wait(delay)
		end
	end
	
	t_wait(delay)
	THICKNESS = oldThickness
end

function pInverseBarrageT(mTimes)
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 6.5
	THICKNESS = oldThickness/25
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		cBarrage(startSide)
		t_wait(delay)
		if(l_getSides() < 6) then t_wait(delay * 0.8) end
		cBarrage(startSide + getHalfSides())
		t_wait(delay)
	end
	
	THICKNESS = oldThickness
	t_wait(getPerfectDelay(THICKNESS) * 2.5)
end

function pMirrorWallStripT(mTimes, mExtra)
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 3.65
	THICKNESS = oldThickness/25
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		rWallEx(startSide, mExtra)
		t_wait(delay)
	end
	
	THICKNESS = oldThickness
	t_wait(getPerfectDelay(THICKNESS) * 5.00)
end

function pDMBarrageSpiralT(mTimes, mDelayMult, mStep)
	oldThickness = THICKNESS
	delay = (getPerfectDelayDM(THICKNESS) * 5.42) * (mDelayMult / (l_getDifficultyMult() ^ 0.24)) * (getSpeedMult() ^ 0.16)
	THICKNESS = oldThickness/25;
	startSide = getRandomSide()
	loopDir = mStep * getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		cBarrage(startSide + j)
		j = j + loopDir
		t_wait(delay)
		if(l_getSides() < 6) then t_wait(delay * 0.49) end
	end
	THICKNESS = oldThickness
	t_wait(getPerfectDelay(THICKNESS) * (6.7 * (l_getDifficultyMult() ^ 0.50)))
end

--Gates for the gate level, designed for 32 sides
function pCircGate()
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 3.65
	THICKNESS = oldThickness/2;
	startSide = getRandomSide();
	rWallEx(startSide, 8)
	w_wallAcc(startSide, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+8, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+16, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+24, THICKNESS*10, 0, 0.006, 1, 1.5)
	t_wait(delay*2)
	THICKNESS = oldThickness
end

function pCircGate2()
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 3.65
	THICKNESS = oldThickness/2;
	startSide = getRandomSide();
	cWallEx(startSide, 4)
	cWallEx(startSide+11, 4)
	cWallEx(startSide+22, 4)
	w_wallAcc(startSide, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+4, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+11, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+15, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+22, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+26, THICKNESS*10, 0, 0.006, 1, 1.5)
	t_wait(delay*2)
	THICKNESS = oldThickness
end

function pCircGate3()
	oldThickness = THICKNESS
	delay = getPerfectDelay(THICKNESS) * 3.65
	THICKNESS = oldThickness/2;
	startSide = getRandomSide();
	t_wait(delay * 0.6)
	cWallEx(startSide, 23)
	w_wallAcc(startSide, THICKNESS*10, 0, 0.006, 1, 1.5)
	w_wallAcc(startSide+23, THICKNESS*10, 0, 0.006, 1, 1.5)
	t_wait(delay*2)
	THICKNESS = oldThickness
end

--Keyhole pattern
function pKey(mDelayMult)
	delay = getPerfectDelay(THICKNESS) * 3
	startSide = getRandomSide();
	cWallEx(startSide, 56)
	--triple thick because people keep lagging through walls
	w_wall(startSide + 1, THICKNESS * 18.67 * mDelayMult)
	w_wall(startSide - 9, THICKNESS * 18.67 * mDelayMult)
	w_wall(startSide, THICKNESS * 18.67 * mDelayMult)
	w_wall(startSide - 8, THICKNESS * 18.67 * mDelayMult)
	for i = 0, 4 do
		t_wait(delay * mDelayMult)
		if(math.random(0, 1) == 1) then cWallEx(startSide - 8, 4)
		else cWallEx(startSide - 4, 4) end
	end
	t_wait(delay * (mDelayMult) * 0.7 )
	cWallEx(startSide, 56)
	t_wait(delay*4)
end

--"gravity" variations of normal patterns
function gravWall(mSide)
	w_wallAcc(mSide, THICKNESS, 2, -0.04675, -1, 2)
end

function gravWallEx(mSide, mExtra)
	for i = 0, mExtra do
		gravWall(mSide + i)
	end
end

function rGravWall(mSide)
	gravWall(mSide)
	gravWall(mSide + l_getSides()/2)
end

function rGravWallEx(mSide, mExtra)
	gravWallEx(mSide, mExtra)
	gravWallEx(mSide + l_getSides()/2, mExtra)
end

function cGravBarrageN(mSide, mNeighbors)
	for i = mNeighbors, l_getSides() - 2 - mNeighbors, 1 do
		gravWall(mSide + i + 1)
	end
end

function cGravBarrage(mSide) 
	cGravBarrageN(mSide, 0) 
end

function cGravAltBarrage(mSide, mStep)
	for i = 0, l_getSides() / mStep, 1 do
		gravWall(mSide + i * mStep)
	end
	t_wait(getPerfectDelay(THICKNESS) * 15)
end

function pGravityAltBarrage(mTimes, mStep)
	delay = getPerfectDelay(THICKNESS) * 1.5
	
	for i = 0, mTimes do
		cGravAltBarrage(i, mStep)
		t_wait(delay)
	end
	
	t_wait(delay * 2)
end

function pGravityVortex(mTimes, mStep)
	delay = getPerfectDelay(THICKNESS) * 12.5 
	startSide = getRandomSide()
	loopDir = getRandomDir()
	currentSide = startSide
	
	for j = 0, mTimes do
		for i = 0, mStep do
			currentSide = currentSide + loopDir
			rGravWallEx(currentSide, (l_getSides()/2) - 2)
			t_wait(delay)
		end
		
		loopDir = loopDir * -1
		
		for i = 0, mStep + 1 do
			currentSide = currentSide + loopDir;
			rGravWallEx(currentSide, (l_getSides()/2) - 2)
			t_wait(delay)
		end
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 15.0)
end

function pGravityTunnel(mTimes)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 7
	startSide = getRandomSide()
	loopDir = getRandomDir()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
			w_wallAcc(startSide, myThickness + 5 * getSpeedMult() * delay, 2, -0.047, -1, 2)
		end
		
		cGravBarrage(startSide + loopDir)
		t_wait(delay)
		
		loopDir = loopDir * -1
	end
	
	t_wait(delay * 1.5)
	THICKNESS = oldThickness
end

function pGravityInverseBarrage(mTimes)
	delay = getPerfectDelay(THICKNESS) * 17
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		cGravBarrage(startSide)
		t_wait(delay)
		if(l_getSides() < 6) then t_wait(delay * 0.8) end
		cGravBarrage(startSide + getHalfSides())
		t_wait(delay)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 15)
end

function pGravityRandomBarrage(mTimes, mDelayMult)
	side = getRandomSide()
	oldSide = 0
	
	for i = 0, mTimes do	
		cGravBarrage(side)
		oldSide = side
		side = getRandomSide()
		t_wait(3.2 * getPerfectDelay(THICKNESS) * (2 + (getSideDistance(side, oldSide)*mDelayMult)))
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 15)
end

function pGravityBarrageSpiral(mTimes, mDelayMult, mStep)
	delay = getPerfectDelay(THICKNESS) * 10 * mDelayMult
	startSide = getRandomSide()
	loopDir = mStep * getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		cGravBarrage(startSide + j)
		j = j + loopDir
		t_wait(delay)
		if(l_getSides() < 6) then t_wait(delay * 0.6) end
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 15)
end

function pGravityMirrorSpiral(mTimes, mExtra)
	oldThickness = THICKNESS
	THICKNESS = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(THICKNESS) * 3
	startSide = getRandomSide()
	loopDir = getRandomDir()	
	j = 0
	
	for i = 0, mTimes do
		rGravWallEx(startSide + j, mExtra)
		j = j + loopDir
		t_wait(delay)
	end
	
	THICKNESS = oldThickness
	
	t_wait(getPerfectDelay(THICKNESS) * 15)
end

--patterns used to block vision
function blockWall(mSide)
	w_wallAcc(mSide, THICKNESS * 3, 2, -0.06, 0, 2)
end

function blockWallThick(mSide)
	w_wallAcc(mSide, THICKNESS * 9.5, 2, -0.049, 0, 2)
end

function blockWallThick2(mSide)
	w_wallAcc(mSide, THICKNESS * 12, 2, -0.077, 0, 2)
end

function pBlock(mSide, mTimes, mDelayMult)
	for i = 0, mTimes do
		blockWall(mSide + i)
		t_wait(getPerfectDelay(THICKNESS) * 3 * mDelayMult)
	end
end

function distWall(mSide)
	w_wallAcc(mSide, THICKNESS * 1.5, 2, -0.05, 0, 2)
end

function pDistract()
	for i = 0, l_getSides() - 1 do
		distWall(i)
		t_wait(getPerfectDelay(THICKNESS) * 1.5)
	end
	t_wait(getPerfectDelay(THICKNESS) * 5)
end

function blockWall2(mSide)
	w_wallAcc(mSide, THICKNESS * 5, 2, -0.06, 0, 2)
end

function distWall2(mSide)
	w_wallAcc(mSide, THICKNESS * 3, 2, -0.05, 0, 2)
end

function pBlock2()
	for i = 0, l_getSides() do
		blockWall2(i)
		distWall2(i)
		t_wait(getPerfectDelay(THICKNESS) * 0.25)
	end
	t_wait(getPerfectDelay(THICKNESS) * 1.5)
end

function pThickBlock()
	for i = 0, l_getSides() - 1 do
		blockWallThick(i)
		blockWallThick2(i)
	end
	t_wait(getPerfectDelay(THICKNESS) * 10)
end

function leaveWall(mSide)
	w_wallAcc(mSide, THICKNESS, 5, -0.4, -0.25, 5)
end

function pLeaveDist()
	for i = 0, l_getSides() - 1 do
		leaveWall(i)
	end
end

--functions used for the "shoot" patterns

function warningWall(mSide)
	w_wallAcc(mSide, THICKNESS, 10, -1.3, -5, 10)
end

function fastWall(mSide)
	w_wallAcc(mSide, THICKNESS , 2, 1, 0, 10)
end

function warnWallEx(mSide, mExtra)
	for i = 0, mExtra do
		warningWall(mSide + i)
	end
end

function fastWallEx(mSide, mExtra)
	for i = 0, mExtra do
		fastWall(mSide + i)
	end
end

function rWarnWall(mSide)
	warningWall(mSide)
	warningWall(mSide + l_getSides()/2)
end

function rFastWall(mSide)
	fastWall(mSide)
	fastWall(mSide + l_getSides()/2)
end

function rWarnWallEx(mSide, mExtra)
	wraningWallEx(mSide, mExtra)
	warningWallEx(mSide + l_getSides()/2, mExtra)
end

function rFastWallEx(mSide, mExtra)
	fastWallEx(mSide, mExtra)
	fastWallEx(mSide + l_getSides()/2, mExtra)
end

function cWarnBarrageN(mSide, mNeighbors)
	for i = mNeighbors, l_getSides() - 2 - mNeighbors, 1 do
		warningWall(mSide + i + 1)
	end
end

function cFastBarrageN(mSide, mNeighbors)
	for i = mNeighbors, l_getSides() - 2 - mNeighbors, 1 do
		fastWall(mSide + i + 1)
	end
end

function cWarnBarrage(mSide) 
	cWarnBarrageN(mSide, 0) 
end

function cFastBarrage(mSide) 
	cFastBarrageN(mSide, 0) 
end

function cWarnAltBarrage(mSide, mStep)
	for i = 0, l_getSides() / mStep, 1 do
		warningWall(mSide + i * mStep)
	end
end

function cFastAltBarrage(mSide, mStep)
	for i = 0, l_getSides() / mStep, 1 do
		fastWall(mSide + i * mStep)
	end
end

function pShootBarrage(delayMult)
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
	fastWall(side)
	fastWall(side + l_getSides()/2)
	t_wait(getPerfectDelay(THICKNESS) * 7 * delayMult)
end

function pShootAlt(delayMult)
	delayMult = delayMult + 0.075
	side = getRandomSide()
	j = math.random(2, 3)
	for i = 0, j do
		cWarnAltBarrage(side + i, 2)
		t_wait(getPerfectDelay(THICKNESS) * 2.5 * delayMult)
	end
	t_wait(getPerfectDelay(THICKNESS) * 8 * delayMult)
	for i = 0, j do
		cFastAltBarrage(side + i + 1, 2)
		t_wait(getPerfectDelay(THICKNESS) * 3.2 * delayMult)
	end
	t_wait(getPerfectDelay(THICKNESS) * 7 * delayMult)
end

function pRandomBarrageShoot(mDelayMult)
	delay = getPerfectDelay(THICKNESS)
	a = getRandomSide()
	b = getRandomSide()
	while b == a do
		b = getRandomSide()
	end
	c = getRandomSide()
	while c == b do
		c = getRandomSide()
	end
	d = getRandomSide()
	while d == c do
		d = getRandomSide()
	end
	warningWall(a)
	t_wait(delay * (2 + (getSideDistance(a, b)* mDelayMult)))
	warningWall(b)
	t_wait(delay * (2 + (getSideDistance(a, b)* mDelayMult)))
	warningWall(c)
	t_wait(delay * (2 + (getSideDistance(a, b)* mDelayMult)))
	warningWall(d)
	t_wait(delay * 8 * mDelayMult)
	cFastBarrage(a)
	t_wait(delay * (1.5 + 2.3*(getSideDistance(a, b)* mDelayMult)))
	cFastBarrage(b)
	t_wait(delay * (1.5 + 2.3*(getSideDistance(b, c)* mDelayMult)))
	cFastBarrage(c)
	t_wait(delay * (1.5 + 2.3*(getSideDistance(c, d)* mDelayMult)))
	cFastBarrage(d)
	t_wait(delay * 7 * delayMult)
end

--Lockpick pattern
function popAndLock(mDelayMult)
	delay = getPerfectDelay(THICKNESS) * 3
	startSide = getRandomSide();
	cWallEx(startSide, 52)
	--triple thick because people keep lagging through walls
	w_wall(startSide + 1, THICKNESS * 34 * mDelayMult)
	w_wall(startSide - 13, THICKNESS * 34 * mDelayMult)
	w_wall(startSide, THICKNESS * 34 * mDelayMult)
	w_wall(startSide - 12, THICKNESS * 34 * mDelayMult)
	wario = math.random(0, 3)
	oldwario = wario
	for i = 0, 9 do
		t_wait(delay * mDelayMult)
		while wario == oldwario do
			wario = math.random(0, 3)
		end
		if wario == 1 then cWallEx(startSide - 9, 6)
		elseif wario == 2 then cWallEx(startSide - 8, 8)
		elseif wario == 3 then cWallEx(startSide - 12, 8)
		else cWallEx(startSide - 12, 3) cWallEx(startSide - 3, 3) end
		oldwario = wario
	end
	t_wait(delay * (mDelayMult) * 0.55)
	cWallEx(startSide, 52)
	t_wait(delay*4)
end