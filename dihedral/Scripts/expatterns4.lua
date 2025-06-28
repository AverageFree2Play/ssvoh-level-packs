execScript("common.lua")
--everybody get up it's time to slam now we got the real jam going down welcome to the space jam it's your chance do your dance at the space jam alright
--come on and slam and welcome to the jam come on and slam if you want to jam

--hurdles
function hurdle()
	for i = 0, getSides() do
		wall(i, THICKNESS * 0.6)
	end
end

function altHurdle()
	startSide = getRandomSide()
	for i = 0, getSides() / 2 do
		wall(startSide + 2 * i, THICKNESS * 5)
	end
	wait(getPerfectDelay(THICKNESS) * 4)
	hurdle()
	wait(getPerfectDelay(THICKNESS) * 11)
end

function altDoubleHurdle()
	startSide = getRandomSide()
	hurdle()
	for i = 0, getSides() / 2 do
		wall(startSide + 2 * i, THICKNESS * 11)
	end
	wait(getPerfectDelay(THICKNESS) * 10)
	hurdle()
	wait(getPerfectDelay(THICKNESS) * 11)
end

function singleHurdle()
	side = getRandomSide()
	for i = 0, getSides() - 2 do
		wall(side + i, THICKNESS * 5)
	end
	wait(getPerfectDelay(THICKNESS) * 4)
	hurdle()
	wait(getPerfectDelay(THICKNESS) * 11)
end

function doubleSingleHurdle()
	side = getRandomSide()
	hurdle()
	for i = 0, getSides() - 2 do
		wall(side + i, THICKNESS * 11)
	end
	wait(getPerfectDelay(THICKNESS) * 10)
	hurdle()
	wait(getPerfectDelay(THICKNESS) * 11)
end

function doubleHurdle()
	side = getRandomSide()
	for i = 0, getSides()/2 - 2 do
		wall(side + i, THICKNESS * 5)
		wall(side + getSides()/2 + i, THICKNESS * 5)
	end
	wait(getPerfectDelay(THICKNESS) * 4)
	hurdle()
	wait(getPerfectDelay(THICKNESS) * 11)
end

function doubleDoubleHurdle()
	side = getRandomSide()
	hurdle()
	for i = 0, getSides()/2 - 2 do
		wall(side + i, THICKNESS * 11)
		wall(side + getSides()/2 + i, THICKNESS * 11)
	end
	wait(getPerfectDelay(THICKNESS) * 10)
	hurdle()
	wait(getPerfectDelay(THICKNESS) * 11)
end

function backAndForthHurdle(mTimes)
	side = getRandomSide()
	wait(getPerfectDelay(THICKNESS) * 4)
	hurdle()
	for i = 0, mTimes do
		for j = 2, getSides() - 1 do
			wall(side + j, THICKNESS * 22)
		end
		wall(side, THICKNESS * 4.5)
		wait(getPerfectDelay(THICKNESS) * 10)
		hurdle()
		
		wall(side + 1, THICKNESS * 4.5)
		wait(getPerfectDelay(THICKNESS) * 10)
		hurdle()
	end
	
	wait(getPerfectDelay(THICKNESS) * 10)
end

function halfHurdle(mTimes)
	side = getRandomSide()
	for i = 0, mTimes do
		for j = 0, getSides()/2 - 1 do
			wall(side + j, THICKNESS * 5)
		end
		wait(getPerfectDelay(THICKNESS) * 4)
		hurdle()
		wait(getPerfectDelay(THICKNESS) * 5.4)
		
		for j = 0, getSides()/2 - 1 do
			wall(side + getSides() / 2 + j, THICKNESS * 5)
		end
		wait(getPerfectDelay(THICKNESS) * 4)
		hurdle()
		wait(getPerfectDelay(THICKNESS) * 5.4)
	end
	
	wait(getPerfectDelay(THICKNESS) * 10)
end

function altHurdleBarrage(mTimes)
	startSide = getRandomSide()
	for i = 0, mTimes do
		for j = 0, getSides() / 2 do
			wall(startSide + 2 * j, THICKNESS * 5)
		end
		wait(getPerfectDelay(THICKNESS) * 4)
		hurdle()
		wait(getPerfectDelay(THICKNESS) * 5.4)
		startSide = startSide + 1
	end
	wait(getPerfectDelay(THICKNESS) * 10)
end

function hurdleSpiral(mTimes)
	side = getRandomSide()
	dir = getRandomDir()
	hurdle()
	for i = 0, mTimes do
		for j = 0, getSides() - 2 do
			wall(side + dir * i + j, THICKNESS * 5)
		end
		wait(getPerfectDelay(THICKNESS) * 10)
		hurdle()
	end
	wait(getPerfectDelay(THICKNESS) * 8)
end

--2-sided patterns
function simpleAlt(mTimes)
	startSide = math.random(0,1) * 2
	for i = 0, mTimes do
		wall(startSide, THICKNESS)
		wall(startSide + 1, THICKNESS)
		wallAcc(2 - startSide, THICKNESS, 3, -0.135, -1, 3)
		wallAcc(3 - startSide, THICKNESS, 3, -0.135, -1, 3)
		wait(getPerfectDelay(THICKNESS) * 4)
		wall(2 - startSide, THICKNESS)
		wall(3 - startSide, THICKNESS)
		wallAcc(startSide, THICKNESS, 3, -0.135, -1, 3)
		wallAcc(startSide + 1, THICKNESS, 3, -0.135, -1, 3)
		wait(getPerfectDelay(THICKNESS) * 4)
	end
	wait(getPerfectDelay(THICKNESS) * 7)
end

function trickyTrick(mTimes)
	for i = 0, mTimes do
		side = math.random(0,1) * 2
		wallAcc(side, THICKNESS, 3, -0.16, 1, 3)
		wallAcc(side + 1, THICKNESS, 3, -0.16, 1, 3)
		wallAcc(2 - side, THICKNESS, 3, -0.16, 0.85, 3)
		wallAcc(3 - side, THICKNESS, 3, -0.16, 0.85, 3)
		wallAcc(side, THICKNESS, 3, -0.135, -1, 3)
		wallAcc(side + 1, THICKNESS, 3, -0.135, -1, 3)
		wallAcc(2 - side, THICKNESS, 3, -0.135, -1, 3)
		wallAcc(3 - side, THICKNESS, 3, -0.135, -1, 3)
		wait(getPerfectDelay(THICKNESS) * 7)
	end
	wait(getPerfectDelay(THICKNESS) * 7)
end

function trickyTricky(mTimes)
	for i = 0, mTimes do
		side = math.random(0,1) * 2
		wallAcc(side, THICKNESS, 0.85, 0.14, 0.5, 1)
		wallAcc(side + 1, THICKNESS, 0.85, 0.14, 0.5, 1)
		wallAcc(3 - side, THICKNESS, 3, -0.135, -1, 3)
		wallAcc(2 - side, THICKNESS, 3, -0.135, -1, 3)
		wallAcc(3 - side, THICKNESS, 0.85, 0.14, 0.5, 1.2)
		wallAcc(2 - side, THICKNESS, 0.85, 0.14, 0.5, 1.2)
		wallAcc(side + 1, THICKNESS, 3, -0.135, -1, 3)
		wallAcc(side, THICKNESS, 3, -0.135, -1, 3)
		wait(getPerfectDelay(THICKNESS) * 9)
	end
	wait(getPerfectDelay(THICKNESS) * 7)
end

function trickyTrickyTricky(mTimes)
	for i = 0, mTimes do
		side = math.random(0,1) * 2
		wallAcc(side, THICKNESS, 2, -0.07, 0.75, 2)
		wallAcc(side + 1, THICKNESS, 2, -0.07, 0.75, 2)
		wallAcc(2 - side, THICKNESS, 3, -0.135, -1, 3)
		wallAcc(3 - side, THICKNESS, 3, -0.135, -1, 3)
		wallAcc(3 - side, THICKNESS, 2, -0.07, 1, 2)
		wallAcc(2 - side, THICKNESS, 2, -0.07, 1, 2)
		wallAcc(side + 1, THICKNESS, 3, -0.135, -1, 3)
		wallAcc(side, THICKNESS, 3, -0.135, -1, 3)
		wait(getPerfectDelay(THICKNESS) * 9)
	end
	wait(getPerfectDelay(THICKNESS) * 7)
end

--vortex patterns
function vortexStuff()
	dir = getRandomDir()
	mSide = getRandomSide()
	delay = getPerfectDelay(THICKNESS) * 2.8
	rWallEx(mSide, 8)
	for i = 0, 12 do
		rWallThick(mSide + i * dir, THICKNESS * 2)
		rWallThick(mSide + 8 + i * dir, THICKNESS * 2)
		wait(delay * 0.5)
	end
	rWallEx(mSide, 8)
	wait(delay * 3)
end

function vortexStuff2()
	dir = getRandomDir()
	mSide = getRandomSide()
	delay = getPerfectDelay(THICKNESS) * 2.8
	rWallEx(mSide, 8)
	for i = 0, 11 do
		rWallThick(mSide + i * dir, THICKNESS * 2)
		rWallThick(mSide + 8 + i * dir, THICKNESS * 2)
		wait(delay * 0.5)
	end
	rWallThick(mSide, THICKNESS * 3)
	rWallThick(mSide + 8, THICKNESS * 3)
	wait(delay * 0.75)
	for i = 0, 11 do
		rWallThick(mSide - i * dir, THICKNESS * 2)
		rWallThick(mSide + 8 - i * dir, THICKNESS * 2)
		wait(delay * 0.5)
	end
	rWallEx(mSide, 8)
	wait(delay * 3)
end

function vortexStuff3()
	dir = getRandomDir()
	mSide = getRandomSide()
	delay = getPerfectDelay(THICKNESS) * 2.8
	rWallEx(mSide, 8)
	for i = 0, 7 do
		rWallThick(mSide + i * dir, THICKNESS * 2)
		rWallThick(mSide + 8 + i * dir, THICKNESS * 2)
		wait(delay * 0.5)
	end
	rWallThick(mSide - 16 * dir, THICKNESS * 3)
	rWallThick(mSide + 8 - 16 * dir, THICKNESS * 3)
	wait(delay * 0.75)
	for i = 16, 23 do
		rWallThick(mSide - i * dir, THICKNESS * 2)
		rWallThick(mSide + 8 - i * dir, THICKNESS * 2)
		wait(delay * 0.5)
	end
	rWallThick(mSide, THICKNESS * 3)
	rWallThick(mSide + 8, THICKNESS * 3)
	wait(delay * 0.75)
	for i = 0, 7 do
		rWallThick(mSide + i * dir, THICKNESS * 2)
		rWallThick(mSide + 8 + i * dir, THICKNESS * 2)
		wait(delay * 0.5)
	end
	rWallEx(mSide + 8 * dir, 8)
	wait(delay * 3)
end

function vortexStuff4()
	dir = getRandomDir()
	mSide = getRandomSide()
	delay = getPerfectDelay(THICKNESS) * 2.8
	rWallEx(mSide, 8)
	for i = 0, 5 do
		rWallThick(mSide + i * dir, THICKNESS * 2)
		rWallThick(mSide + 8 + i * dir, THICKNESS * 2)
		wait(delay * 0.5)
	end
	rWallThick(mSide - 6 * dir, THICKNESS * 3)
	rWallThick(mSide + 8 - 6 * dir, THICKNESS * 3)
	wait(delay * 0.75)
	for i = 6, 11 do
		rWallThick(mSide - i * dir, THICKNESS * 2)
		rWallThick(mSide + 8 - i * dir, THICKNESS * 2)
		wait(delay * 0.5)
	end
	rWallThick(mSide, THICKNESS * 3)
	rWallThick(mSide + 8, THICKNESS * 3)
	wait(delay * 0.75)
	for i = 0, 5 do
		rWallThick(mSide + i * dir, THICKNESS * 2)
		rWallThick(mSide + 8 + i * dir, THICKNESS * 2)
		wait(delay * 0.5)
	end
	rWallThick(mSide - 6 * dir, THICKNESS * 3)
	rWallThick(mSide + 8 - 6 * dir, THICKNESS * 3)
	wait(delay * 0.75)
	for i = 6, 11 do
		rWallThick(mSide + - i * dir, THICKNESS * 2)
		rWallThick(mSide + 8 - i * dir, THICKNESS * 2)
		wait(delay * 0.5)
	end
	rWallEx(mSide, 8)
	wait(delay * 3)
end

--shotgun pattern

function shotgunBlast()
	mSide = getRandomSide()
	delay = getPerfectDelay(THICKNESS)
	numSides = math.random(48, 52)
	sides = {}
	for j = 0, numSides do
		sides[j] = j + mSide
	end
	for k = 0, numSides * 5 do
		indexA = math.random(0, numSides)
		indexB = math.random(0, numSides)
		temp = sides[indexA]
		sides[indexA] = sides[indexB]
		sides[indexB] = temp
	end
	
	allsides = {}
	for j = 0, getSides() do
		allsides[j] = j
	end
	for k = 0, getSides() * 5 do
		indexA = math.random(0, getSides())
		indexB = math.random(0, getSides())
		temp = allsides[indexA]
		allsides[indexA] = allsides[indexB]
		allsides[indexB] = temp
	end
	
	for i = 0, getSides() do
		wallAcc(allsides[i], THICKNESS, 5, -(math.random() + 3)/8, -0.3, 5)
	end
	for i = 0, numSides * 3 do 
		wallAcc(sides[i % numSides], THICKNESS, 5, -(math.random() + 3)/8, 0.5, 5)
	end
	wait(36.5)
	for i = numSides, getSides() do
		wallAcc(getSides() + mSide + i, THICKNESS, 5, -(math.random()*0.25 + 3.3)/8, 0.5, 5)
	end
	wait(delay * 13.5)
end

--10-sided patterns

function decVortex()
	delay = getPerfectDelay(THICKNESS) * 5.0 
	startSide = getRandomSide()
	loopDir = getRandomDir()
	currentSide = startSide
	
	for j = 0, 1 do
		for i = 0, 1 do
			currentSide = currentSide + loopDir
			rWallEx(currentSide, 3 * loopDir)
			wait(delay)
		end
		
		loopDir = loopDir * -1
		
		for i = 0, 2 do
			currentSide = currentSide + loopDir;
			rWallEx(currentSide, 3 * loopDir)
			wait(delay)
		end
	end
	
	wait(getPerfectDelay(THICKNESS) * 5.5)
end

function decBackAndForth(mTimes, mDelayMult)
	oldThickness = THICKNESS
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5
	startSide = getRandomSide()
	
	THICKNESS = myThickness
	
	for i = 0, mTimes do
		if i < mTimes then
		
			wall(startSide, myThickness + 7 * getSpeedMult() * delay)
			wall(startSide+(getSides()/2), myThickness + 7 * getSpeedMult() * delay)
		end
		
		wall(startSide+1, oldThickness*1.2)
		wall(startSide+1+getHalfSides(), oldThickness*1.2)
		wait(1)
		wall(startSide+2, oldThickness*1.2)
		wall(startSide+2+getHalfSides(), oldThickness*1.2)
		wait(1)
		wall(startSide+3, oldThickness*1.2)
		wall(startSide+3+getHalfSides(), oldThickness*1.2)
		wait(delay*0.5*mDelayMult)
		wall(startSide+4, oldThickness*1.2)
		wall(startSide+4+getHalfSides(), oldThickness*1.2)
		wait(1)
		wall(startSide+3, oldThickness*1.2)
		wall(startSide+3+getHalfSides(), oldThickness*1.2)
		wait(1)
		wall(startSide+2, oldThickness*1.2)
		wall(startSide+2+getHalfSides(), oldThickness*1.2)
		wait(delay*0.5*mDelayMult)
	end
	THICKNESS = oldThickness
	wait(delay / 1.5)
end

--mirror patterns

function mirTunnel(mTimes, mDelayMult)
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		rWall(0)
		rWall(1)
		rWall(2)
		wait(delay*mDelayMult)
		rWall(3)
		rWall(2)
		rWall(1)
		wait(delay*mDelayMult)
	end
	wait(delay*mDelayMult)
end

function mirAlt(mTimes, mDelayMult)
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		rWall(1 + startSide)
		rWall(3 + startSide)
		wait(delay*mDelayMult)
		rWall(0 + startSide)
		rWall(2 + startSide)
		wait(delay*mDelayMult)
	end
	wait(delay*mDelayMult)
end

function mirRandomBarrage(mTimes, mDelayMult)
	side = math.random(0, 3)
	oldSide = 0
	
	for i = 0, mTimes do	
		rWall(side)
		rWall(side + 1)
		rWall(side + 2)
		oldSide = side
		while side == oldSide do
			side = math.random(0, 3)
		end
		wait(getPerfectDelay(THICKNESS) * mDelayMult)
	end
	
	wait(getPerfectDelay(THICKNESS) * 6)
end

function mirOuter(mTimes, mDelayMult)
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		rWall(0)
		rWall(3)
		wait(delay*mDelayMult)
		rWall(1)
		rWall(2)
		wait(delay*mDelayMult)
	end
	wait(delay * mDelayMult * 2)
end

function mirMiddle(mTimes, mDelayMult)
	myThickness = getPerfectThickness(THICKNESS)
	delay = getPerfectDelay(myThickness) * 5
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		rWall(0)
		rWall(2)
		rWall(3)
		wait(delay*mDelayMult)
		rWall(0)
		rWall(1)
		rWall(3)
		wait(delay*mDelayMult)
	end
	wait(delay*mDelayMult * 2)
end

function mirBarrageSpiralLeft()
	rWall(1)
	rWall(2)
	rWall(3)
	wait(getPerfectDelay(THICKNESS) * 2.5)
	rWall(0)
	rWall(2)
	rWall(3)
	wait(getPerfectDelay(THICKNESS) * 2.5)
	rWall(0)
	rWall(1)
	rWall(3)
	wait(getPerfectDelay(THICKNESS) * 2.5)
	rWall(0)
	rWall(1)
	rWall(2)
	wait(getPerfectDelay(THICKNESS) * 7)
end

function mirBarrageSpiralRight()
	rWall(0)
	rWall(1)
	rWall(2)
	wait(getPerfectDelay(THICKNESS) * 2.5)
	rWall(0)
	rWall(1)
	rWall(3)
	wait(getPerfectDelay(THICKNESS) * 2.5)
	rWall(0)
	rWall(2)
	rWall(3)
	wait(getPerfectDelay(THICKNESS) * 2.5)
	rWall(1)
	rWall(2)
	rWall(3)
	wait(getPerfectDelay(THICKNESS) * 7)
end

--dual action

function dBarrage(mHalf)
	openSide = math.random(0, 4)
	for i = 0, 4 do
		if i ~= openSide then
			wallAdj(i + 5 * mHalf, THICKNESS, 0.8)
		end
	end
	
	wait(getPerfectDelay(THICKNESS) * 7.5)
end

function dTunnel(mTimes, mHalf)
	start = math.random(0, 1)
	for i = 0, mTimes do
		for j = 0, 3 do
			wallAdj(mHalf * 5 + start + j, THICKNESS, 0.8)
		end
		wait(getPerfectDelay(THICKNESS) * 7.5)
		for j = 0, 3 do
			wallAdj((1 - mHalf) * 5 + 1 - start + j, THICKNESS, 0.8)
		end
		wait(getPerfectDelay(THICKNESS) * 7.5)
	end
	
	wait(getPerfectDelay(THICKNESS) * 3)
end

function dAlt(mTimes, mHalf)
	for i = 0, mTimes do
		wallAdj(mHalf * 5, THICKNESS, 0.8)
		wallAdj(mHalf * 5 + 2, THICKNESS, 0.8)
		wallAdj(mHalf * 5 + 4, THICKNESS, 0.8)
		wait(getPerfectDelay(THICKNESS) * 5.5)
		wallAdj((1 - mHalf) * 5 + 1, THICKNESS, 0.8)
		wallAdj((1 - mHalf) * 5 + 3, THICKNESS, 0.8)
		wait(getPerfectDelay(THICKNESS) * 5.5)
	end
	wait(getPerfectDelay(THICKNESS) * 3)
end

--dumb

function dumbWall()
	side = getRandomSide()
	dir = getRandomDir()
	for i = 1, getSides()*7 / 16 do 
		wallAcc(side + i * 2 + dir, THICKNESS, 0.5, -0.002, 0, 1)
	end 
	wait(30)
	for i = 1, getSides()*7 / 16 do 
		wallAcc(side + i * 2 + dir + 1, THICKNESS, 0.2, 0.008, 0, 0.475)
	end 
	wait(getPerfectDelay(THICKNESS) * 5)
end

function obfuscator()
	side = getRandomSide()
	for i = 1, getSides()*7 / 16 do 
		wallAcc(side + i * 2, THICKNESS, 2, -0.048, -1, 2)
	end 
	side = getRandomSide()
	for i = 1, getSides()*7 / 16 do 
		wallAcc(side + i * 2 + 1, THICKNESS, 2, -0.048, -1, 2)
	end 
end

function obfuscatorFull()
	side = getRandomSide()
	for i = 1, getSides()/2 do 
		wallAcc(side + i * 2, THICKNESS, 1, -0.01186, -1, 1)
	end 
	side = getRandomSide()
	for i = 1, getSides()/2 do 
		wallAcc(side + i * 2 + 1, THICKNESS, 1, -0.01186, -1, 1)
	end 
end

--wow

base = 1.5
acc = -0.04
delay = 1

function allahuAccBar1(mSide)
	for i = 1, getSides() - 1 do
		wallAcc(mSide + i, THICKNESS * 0.6, base, acc, 0.35, 3)
	end
	wait(delay)
end

function allahuAccBar2(mSide)
	for i = 1, getSides() - 1 do
		wallAcc(mSide + i, THICKNESS * 0.6, base, acc, 0.425, 3)
	end
	wait(delay)
end

function allahuAccBar3(mSide)
	for i = 1, getSides() - 1 do
		wallAcc(mSide + i, THICKNESS * 0.6, base, acc, 0.525, 3)
	end
	wait(delay)
end

function allahuAccBar4(mSide)
	for i = 1, getSides() - 1 do
		wallAcc(mSide + i, THICKNESS * 0.6, base, acc, 0.65, 3)
	end
	wait(delay)
end

function allahuAccBar5(mSide)
	for i = 1, getSides() - 1 do
		wallAcc(mSide + i, THICKNESS * 0.6, base, acc, 0.775, 3)
	end
	wait(delay * 15)
end

--cool

function flipper(side, mHalf)
	for i = 1, getSides() - 4 do
		wallAcc(mHalf * 17 - 1 + side + i, THICKNESS * 0.6, 2, -0.06, 0.4, 2)
	end
	
	wallAcc(mHalf * 17 - 5 + side, THICKNESS * 2.25, 2, -0.06, 0.4, 2)
	wallAcc(mHalf * 17 + side, THICKNESS * 2.25, 2, -0.06, 0.4, 2)
	
	for i = 1, 4 do
		wallAcc(mHalf * 17 - 5 + side + i, THICKNESS * 0.6, 2, -0.06, 0.344, 2)
	end
end
	
function fugger()
	side = getRandomSide()
	for i = 1, getSides() - 4 do
		wallAcc(side + i - 1, THICKNESS * 0.6, 2, -0.05, -0.5, 2)
	end
	
	wallAcc(side - 5, THICKNESS * 2, 2, -0.0505, -0.5, 2)
	wallAcc(side, THICKNESS * 2, 2, -0.0505, -0.5, 2)
	
	for i = 1, 4 do
		wallAcc(side - 5 + i, THICKNESS * 0.6, 2, -0.05, -0.5, 2)
	end
end

	
function slowZoom()
	side = math.random(getSides())
	for i = 1, getSides() * 7 / 8 do
		wallAcc(side + i, THICKNESS * 20, 1, -0.1, -1, 1)
	end
end

--wedge

function wedge(side)
	for i = 15, 0, -1 do
		for j = -i, i do
			wallAcc(side + j, THICKNESS * 0.5, 1.7, -0.005 * (15 - i), 1, 2)
			wallAcc(side + j + getHalfSides(), THICKNESS * 0.5, 1.7, -0.005 * (15 - i), 1, 2)
		end
	end
	wait(getPerfectDelay(THICKNESS) * 6.5)
	
	for i = 15, 0, -1 do
		for j = -i, i do
			wallAcc(side + j + getSides() / 4, THICKNESS * 0.5, 2, -0.005 * (i + 2), 1, 2)
			wallAcc(side + j + getHalfSides() + getSides() / 4, THICKNESS * 0.5, 2, -0.005 * (i + 2), 1, 2)
		end
	end
	wait(getPerfectDelay(THICKNESS) * 14)
end

function wedge2(side)
	for i = 11, 0, -1 do
		for j = -i, i do
			wallAcc(side + j, THICKNESS * 0.5, 1.8, -0.005 * (13 - i), 1, 2)
			wallAcc(side + j + getSides()/3, THICKNESS * 0.5, 1.8, -0.005 * (13 - i), 1, 2)
			wallAcc(side + j + getSides() * 2/3, THICKNESS * 0.5, 1.8, -0.005 * (13 - i), 1, 2)
		end
	end
	
	wait(getPerfectDelay(THICKNESS) * 6.7)
	
	for i = 11, 0, -1 do
		for j = -i, i do
			wallAcc(side + j + getSides()/6, THICKNESS * 0.5, 1.8, -0.005 * (i), 1, 2)
			wallAcc(side + j + getSides()/3 + getSides()/6, THICKNESS * 0.5, 1.8, -0.005 * (i), 1, 2)
			wallAcc(side + j + getSides() * 2/3 + getSides()/6, THICKNESS * 0.5, 1.8, -0.005 * (i), 1, 2)
		end
	end
	wait(getPerfectDelay(THICKNESS) * 14)
end

function wedge3(side)
	for i = 7, 0, -1 do
		for j = -i, i do
			wallAcc(side + j, THICKNESS * 0.5, 2, -0.005 * (11 - i), 1, 2)
			wallAcc(side + j + getSides()/4, THICKNESS * 0.5, 2, -0.005 * (11 - i), 1, 2)
			wallAcc(side + j + getSides()/2, THICKNESS * 0.5, 2, -0.005 * (11 - i), 1, 2)
			wallAcc(side + j + getSides()*3/4, THICKNESS * 0.5, 2, -0.005 * (11 - i), 1, 2)
		end
	end
	
	wait(getPerfectDelay(THICKNESS) * 6.9)
	
	for i = 7, 0, -1 do
		for j = -i, i do
			wallAcc(side + j + getSides()/8, THICKNESS * 0.5, 2, -0.005 * (i), 1, 2)
			wallAcc(side + j + getSides()/4 + getSides()/8, THICKNESS * 0.5, 2, -0.005 * (i), 1, 2)
			wallAcc(side + j + getSides()/2 + getSides()/8, THICKNESS * 0.5, 2, -0.005 * (i), 1, 2)
			wallAcc(side + j + getSides()*3/4 + getSides()/8, THICKNESS * 0.5, 2, -0.005 * (i), 1, 2)
		end
	end
	wait(getPerfectDelay(THICKNESS) * 11)
end

-- i'm not a wrapper

function catchBar(num, del)
	side = getRandomSide()
	for i = 1, num - 1 do
		wallAdj(side + getSides() * i/num, THICKNESS * 6, 0.6)
	end
	--wait(6 * del)
	wallAdj(side, THICKNESS * 4.9, 0.6)
	wait(getPerfectDelay(THICKNESS) * 45)
	wallAdj(side, THICKNESS * 2, 1.9)
	for i = 2, getSides() - 2 do
		wallAdj(side + i, THICKNESS * 2, 1.9)
	end
end
	
-- tilt mode

function tiltBar()
	side = getRandomSide()
	for i = 1, getSides() - 2 do
		wallAdj(side - i, THICKNESS * 2.4, 0.3)
		wait(getPerfectDelay(THICKNESS) * 0.5)
	end
	wait(getPerfectDelay(THICKNESS) * 16)
end

function tiltAlt(mTimes)
	side = getRandomSide()
	for j = 1, mTimes do
		for i = 1, getSides()/2 do
			wallAdj(side + 2 * i, THICKNESS * 3, 0.3)
		end
		wait(getPerfectDelay(THICKNESS) * 12)
		for i = 1, getSides()/2 do
			wallAdj(side + 1 + 2 * i, THICKNESS * 3, 0.3)
		end
		wait(getPerfectDelay(THICKNESS) * 12)
	end
	wait(getPerfectDelay(THICKNESS) * 7.5)
end

function tiltSpiralRight()
	side = getRandomSide()
	for i = 1, getSides() + math.random(0, getSides()) do
		wallAdj(side + i, THICKNESS * 3, 0.3)
		wait(getPerfectDelay(THICKNESS) * 1.8)
	end
	wait(getPerfectDelay(THICKNESS) * 13)
end


function tiltSpiralLeft()
	side = getRandomSide()
	for i = 1, 2 * getSides() do
		wallAdj(side - i, THICKNESS * 2.25, 0.3)
		wait(getPerfectDelay(THICKNESS) * 2.5)
	end
	wait(getPerfectDelay(THICKNESS) * 13)
end

function tiltVortex()

	side = getRandomSide()
	dir = getRandomDir()
	cur = side
	
	for i = 0, 3 do
		cur = cur - 1
		for i = 1, 2 do
			wallAdj(cur - i, THICKNESS * 3, 0.3)
			wallAdj(cur - i + getHalfSides(), THICKNESS * 3, 0.3)
			wait(getPerfectDelay(THICKNESS) * 0.75)
		end
		wait(getPerfectDelay(THICKNESS) * 10)
	end
	
	wait(getPerfectDelay(THICKNESS) * 13)
end

function tiltBnF()
	side = getRandomSide()
	
	wallAdj(side, THICKNESS * 10, 0.3)
	wallAdj(side + getHalfSides(), THICKNESS * 10, 0.3)
		
	wallAdj(side + 2, THICKNESS * 2, 0.3)
	wallAdj(side + 2 + getHalfSides(), THICKNESS * 2, 0.3)
	wait(4)
	wallAdj(side + 1, THICKNESS * 2, 0.3)
	wallAdj(side + 1 + getHalfSides(), THICKNESS * 2, 0.3)
	wait(getPerfectDelay(THICKNESS) * 15)
	wallAdj(side + 3, THICKNESS * 2, 0.3)
	wallAdj(side + 3 + getHalfSides(), THICKNESS * 2, 0.3)
	wait(4)
	wallAdj(side + 2, THICKNESS * 2, 0.3)
	wallAdj(side + 2 + getHalfSides(), THICKNESS * 2, 0.3)
	wait(getPerfectDelay(THICKNESS) * 22)
end

function tiltTunnel()
	side = getRandomSide()
	wallAdj(side, THICKNESS * 23.5, 0.3)
	for i = 1, getSides() - 2 do
		wallAdj(side - i, THICKNESS * 2, 0.3)
		wait(4)
	end
	wait(getPerfectDelay(THICKNESS) * 12)
	for i = 2, getSides() - 1 do
		wallAdj(side - i, THICKNESS * 2, 0.3)
		wait(4)
	end
	wait(getPerfectDelay(THICKNESS) * 11)
	for i = 1, getSides() - 3 do
		wallAdj(side - i, THICKNESS * 2, 0.3)
		wait(4)
	end
	wait(getPerfectDelay(THICKNESS) * 12)
	for i = 2, getSides() - 1 do
		wallAdj(side - i, THICKNESS * 2, 0.3)
		wait(4)
	end
	wait(getPerfectDelay(THICKNESS) * 16)
end

-- GET DECEPTED

function deceptWall(side)
	wallAcc(side, THICKNESS, 3, -0.14, -3, 5)
end
function blocker()
	for i = 1, getSides() do
		wallAcc(i, THICKNESS * 6, 6, -0.5, -2.1, 10)
	end
end
function realWall(side)
	wallAcc(side + getHalfSides(), THICKNESS, 6, -0.5, 1, 6)
end

function deceptBarrage()
	side = getRandomSide()
	for i = 1, getSides() - 1 do
		deceptWall(side + i)
	end
	wait(getPerfectDelay(THICKNESS) * 10)
	blocker()
	for i = 1, getSides() - 1 do
		realWall(side + i)
	end
	wait(getPerfectDelay(THICKNESS) * 6)
end