u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "alternativepatterns.lua")
u_execScript("commonExtended_array.lua")

function AscendingCheckerboard(mSide, mTimes)
	local firstPoint = {mSide};
	local layers = {firstPoint};
	local newLayer = firstPoint;
	for i = 1, mTimes do 
		local layer = splitArray(newLayer);
		--troubleshootArray(layer, "SplitArray");
		table.insert(layers, layer);
		newLayer = removeDuplicates(layer);
	end
	castWallsByLayers(layers, getPerfectDelay(THICKNESS), getPerfectDelay(THICKNESS) * 5.6);
end

function twoHoleBarrage(mSide, mGapSize)
	local thing = fixWallPositions(drawArraySides(mSide,mSide + mGapSize));
	local thing2 = fixWallPositions(drawArraySides(mSide+2+mGapSize*2, mSide+2+mGapSize*3));
	local deletion = mergeArrays({thing,thing2});
	castWallsByArray(punctureSidesArray(getSidesArray(), deletion), getPerfectDelay(THICKNESS) * 8);
end

function repelBarrage(mSide, mClosedness)
	local layers = {{mSide-1,mSide,mSide+1}};
	local newLayer = {mSide-1,mSide,mSide+1};
	local test = newLayer;
	for i = 0,mClosedness do
		local layer = repelNoSplit(test,mSide,1,0);
		table.insert(layers, layer);
		newLayer = layer;
	end
	-- troubleshootLayers(layers, "Barrage");
	castWallsByLayers(layers, getPerfectDelay(THICKNESS), getPerfectDelay(THICKNESS) * 7)
end

function obstructedBarrageSpiral(mSide, mGapSize, mTimes, mRate)
	local layers = {}
	local layer = {};
	local direction = directionSet[math.random(1,#directionSet)];
	if direction == 1 then
		for i = 0, mTimes - 1 do
			local begin = mSide + (i * mGapSize);
			layer = punctureSidesArray(getSidesArray(), fixWallPositions(drawArraySides(begin, begin + mGapSize)));
			table.insert(layers, layer);
			layer = drawArraySides(begin, begin + 2 * mGapSize);
			table.insert(layers, layer);
		end
	else
		for i = 0, mTimes - 1 do
			local begin = mSide - (i * mGapSize);
			layer = punctureSidesArray(getSidesArray(), fixWallPositions(drawArraySides(begin - mGapSize, begin)));
			table.insert(layers, layer);
			layer = drawArraySides(begin - 2 * mGapSize, begin);
			table.insert(layers, layer);
		end
	end
	castWallsByLayers(layers, mRate, getPerfectDelay(THICKNESS) * 7);
end

function rhombusHollow(mSide, mWidth, mHeightMult)
	local layers = {{mSide}, {mSide - 1, mSide + 1}};
	local layer = {mSide - 1, mSide + 1};
	local oldThickness = THICKNESS;
	THICKNESS = THICKNESS * mHeightMult;
	for i = 1, mWidth do
		table.insert(layers, layer);
		layer = repel(layer, mSide, 1);
	end
	for i = mWidth,0,-1 do
		table.insert(layers,layer);
		layer = attract(layer, mSide, 1);
	end
	--troubleshootLayers(layers, "Thing");
	castWallsByLayers(layers, getPerfectDelay(THICKNESS), getPerfectDelay(THICKNESS) * 7);
	THICKNESS = oldThickness;
end

function rhombusFilled(mSide, mWidth, mHeightMult)
	local layers = {};
	local layer = {};
	local oldThickness = THICKNESS;
	THICKNESS = THICKNESS * mHeightMult;
	for i = 0, mWidth do
		layer = drawArraySides(mSide - i, mSide + i);
		table.insert(layers, layer);
	end
	for i = mWidth - 1, 0, -1 do
		layer = drawArraySides(mSide - i, mSide + i);
		table.insert(layers, layer);
	end
	castWallsByLayers(layers, getPerfectDelay(THICKNESS), getPerfectDelay(THICKNESS) * 7);
	THICKNESS = oldThickness;
end

function growingInverseBarrage(mSide, mGapSize, mTimeInc)
	local layer = {};
	local times = math.floor(l_getSides()/(mGapSize * 3));
	local delayMult = 5.6;
	for i = 1, times do
		castWallsByArray(punctureSidesArray(getSidesArray(), fixWallPositions(drawArraySides(mSide, mSide+mGapSize))), getPerfectDelay(THICKNESS) * delayMult);
		castWallsByArray(drawArraySides(mSide - (i * mGapSize), mSide + mGapSize + (i * mGapSize)), getPerfectDelay(THICKNESS) * delayMult);
		delayMult = delayMult + mTimeInc;
	end
end

function spreadBarrage(mSide, mGapSize, mSpreadRate)
	local layers = {};
	local layer = {};
	for i = 0, getHalfSides() - 1 - mGapSize do
		layer = drawArraySides(mSide - i - mGapSize, mSide + i);
		table.insert(layers,layer);
	end
	castWallsByLayers(layers, getPerfectDelay(THICKNESS)/mSpreadRate, getPerfectDelay(THICKNESS) * 6);
end

function narrowBarrage(mSide, mGapSize, mNarrowRate)
	local layers = {};
	local layer = {};
	for i = getHalfSides() - 1 - mGapSize, 0, -1 do
		layer = drawArraySides(mSide - i - mGapSize, mSide + i);
		table.insert(layers,layer);
	end
	castWallsByLayers(layers, getPerfectDelay(THICKNESS)/mNarrowRate, getPerfectDelay(THICKNESS) * 6);
end

function tunnelTowardsCenter(mSide, mGapSize)
	local countdown = l_getSides() - mGapSize * 4;
	local oldThickness = THICKNESS;
	local layer = {};
	local direction = 1;
	local gap = fixWallPositions(drawArraySides(mSide+mGapSize+1, mSide+mGapSize*2+1));
	local stickThing = drawArraySides(mSide, mSide+mGapSize);
	local count = 1.3;
	while countdown > 0 do -- The rare case to use a while loop
		layer = punctureSidesArray(getSidesArray(), gap);
		THICKNESS = oldThickness;
		castWallsByArray(layer, getPerfectDelay(THICKNESS));
		THICKNESS = (getPerfectThickness(THICKNESS)*5)/(count);
		castWallsByArray(stickThing, getPerfectDelay(THICKNESS));
		gap = fixWallPositions(translateArrayValue(gap,countdown*direction));
		if direction == 1 then
			direction = -1;
		else
			direction = 1;
		end
		countdown = countdown - mGapSize;
		count = count + .2;
	end
	t_wait(getPerfectDelay(THICKNESS) * 4);
	THICKNESS = oldThickness;
end

function spiralPingPongLength(mSide, mTimes, mWidthBegin, mWidthEnd, mIncrement)
	local direction = getRandomDir();
	local currentLength = mWidthBegin;
	local lengthDir = mIncrement;
	local pos = mSide;
	local oldThickness = THICKNESS;
	local layers = {};
	local layer = {};
	local offsetThing = 1; -- I had to make this in order for the negative direction to work. Fuck sake OH.
	
	THICKNESS = getPerfectThickness(THICKNESS);
	-- 2, 3, 2, 1
	-- 1, 2, 1, 0
	for i = 1, mTimes do
		if (currentLength >= mWidthEnd) then
			offsetThing = -1;
		elseif (currentLength == mWidthBegin) then
			offsetThing = 1;
		end
		layer = drawArraydSides(pos, pos+l_getSides() + currentLength, currentLength, getHalfSides() - currentLength);
		table.insert(layers,layer);
		if direction == 1 then
		pos = pos + currentLength * direction;
		else
		pos = pos + currentLength * direction - offsetThing;
		end
		if (currentLength >= mWidthEnd) then
			lengthDir = -mIncrement;
		elseif (currentLength == mWidthBegin) then
			lengthDir = mIncrement;
		end
		currentLength = currentLength + lengthDir;
	end
	castWallsByLayers(layers, getPerfectDelay(THICKNESS), getPerfectDelay(THICKNESS) * 7);
	THICKNESS = oldThickness;
end

function spiralRandomLength(mSide, mTimes, mWidthMin, mWidthMax) 
	local currentLength = math.random(mWidthMin,mWidthMax);
	local pos = mSide;
	local oldThickness = THICKNESS;
	local layers = {};
	local layer = {};
	
	THICKNESS = getPerfectThickness(THICKNESS);
	
	for i = 1, mTimes do
		layer = drawArraydSides(pos, pos+l_getSides() + currentLength, currentLength, getHalfSides() - currentLength);
		table.insert(layers,layer)
		pos = pos + currentLength;
		currentLength = math.random(mWidthMin, mWidthMax);
	end
	castWallsByLayers(layers, getPerfectDelay(THICKNESS), getPerfectDelay(THICKNESS) * 7);
	THICKNESS = oldThickness;
end

function eloquentSpiral(mSide, mTimes, mGapSize, mWidth) 
	local direction = getRandomDir();
	local pos = mSide;
	local oldThickness = THICKNESS;
	local layers = {};
	local layer = {};
	local beginBarrage = {}; -- This barrage will be used at the beginning and end of the spiral
	
	local deletion1 = fixWallPositions(drawArraySides(pos, pos + mGapSize));
	local deletion2 = fixWallPositions(drawArraySides(pos+getHalfSides(),pos+getHalfSides()+mGapSize));
	--local part1 = drawArraySides(pos+mGapSize, pos + getHalfSides());
	--local part2 = drawArraySides(pos + getHalfSides() + mGapSize, pos + l_getSides());
	beginBarrage = punctureSidesArray(punctureSidesArray(getSidesArray(), deletion1), deletion2);
	castWallsByArray(beginBarrage, getPerfectDelay(THICKNESS));
	
	THICKNESS = getPerfectThickness(THICKNESS)/1.5;
	local part1 = drawArraydSides(pos - mWidth - direction, pos + l_getSides(), mWidth, getHalfSides() - mWidth);
	local part2 = drawArraydSides(pos + mGapSize, pos + l_getSides(), mWidth, getHalfSides() - mWidth);
	if direction == -1 then
	part2 = translateArrayValue(part2, 2)
	end
	layer = mergeArrays({part1,part2});
	for i = 1, mTimes do
		table.insert(layers,layer);
		layer = translateArrayValue(layer, mWidth * direction);
	end
	castWallsByLayers(layers,getPerfectDelay(THICKNESS),0);
	THICKNESS = oldThickness;
	beginBarrage = translateArrayValue(beginBarrage, (mTimes - 1) * mWidth * direction);
	castWallsByArray(beginBarrage, getPerfectDelay(THICKNESS) * 7);
end

function altBarrageSpiral(mSide, mTimes, mWidth, mIncrement)
	local mult = math.floor(l_getSides()/mWidth);
	local direction = getRandomDir();
	local layer = {};
	local layers = {};
	layer = drawArraydSides(mSide, mSide + l_getSides() + mWidth, mWidth, mWidth);
	table.insert(layers,layer);
	for i = 1, mTimes do
		layer = translateArrayValue(layer, mIncrement * direction);
		table.insert(layers, layer);
	end
	castWallsByLayers(layers, getPerfectDelay(THICKNESS), getPerfectDelay(THICKNESS) * 7);
end

function attractBarrage(mSide, mClosedness)
	local layers = {{mSide-mClosedness,mSide,mSide+mClosedness}};
	local newLayer = {mSide-mClosedness,mSide,mSide+mClosedness};
	local test = newLayer;
	for i = mClosedness,0,-1 do
		local layer = attract(test,mSide,1);
		table.insert(layers, layer);
		newLayer = layer;
	end
	-- troubleshootLayers(layers, "Barrage");
	castWallsByLayers(layers, getPerfectDelay(THICKNESS), getPerfectDelay(THICKNESS) * 7)
end