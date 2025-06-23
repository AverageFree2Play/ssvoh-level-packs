--[[ 
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
NOTICE:
You will have to think differently when it comes to designing patterns on commonExtended_array!
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------
commonExtended_array.lua 

Version: 0.7 OPEN BETA 

Made by: Metrono Lyte Ivernan (Aliases: Dyphonic, BossfightX)
--------------------------------------------------------------------------------------------------------------------------------------------------
This script defines some common functions that will give more power to the developer.
The purpose is to simplify certain movements that would usually take hours of work by the use of tables, along with adding new possibilities.

If you got any glitches going on with the arrays, use the function troubleshootArray() to see if you messed up. If it is something to do with this extension,
send me the code and the output for help.

(EXPECT SOME GLITCHES AND UPDATES)


--------------------------------------------------------------------------------------------------------------------------------------------------
If you have trouble figuring out what to start with, I'd start with these:

getSidesArray
drawArraySides
punctureSidesArray
castWallsByArray
--------------------------------------------------------------------------------------------------------------------------------------------------
]]--

u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")

--[[ PREDEFINED VARIABLES:
These variables are defined in this extension for the functions that will be used later on, along with variables that will speed up workflow. ]]

directionSet = {-1, 1}; -- Idk why this wasn't a hardcoded variable, but here it is!
version = 1.92; -- Will be used in a later build, where this code will be compatible with 2.0 using a method that Oshisaure uses.

--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------FUNCTIONS---------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------

-- troubleshootArray(): Takes an array and prints it out to the console. ONLY USE THIS FOR TROUBLESHOOTING, TESTING, AND BUG REPORTING! mName is what you would name the array in the output log!
function troubleshootArray(mArray, mName)
	local arrayString = mName.. " : {";
	for i = 1, #mArray do
		arrayString = arrayString..tostring(mArray[i]);
		if i ~= #mArray then
			arrayString = arrayString..", ";
		end
	end
	arrayString = arrayString.."}";
	log(arrayString);
end

-- troubleshootLayers(): Takes an assembly and prints out all of its layers to the console. ONLY USE FOR THE SAME PURPOSES AS troubleshootArray().
function troubleshootLayers(mLayers,mName)
	local arrayString = mName.. " : {";
	for i = 1, #mLayers do
		arrayString = arrayString.."{";
		for l = 1,#mLayers[i] do
			arrayString = arrayString..tostring(mLayers[i][l])
			if l ~= #mLayers[i] then
				arrayString = arrayString..", ";
			end
		end
		arrayString = arrayString.."}"
		if i ~= #mLayers then
			arrayString = arrayString..", ";
		end
	end
	arrayString = arrayString.."}"
	log(arrayString);
end

-- attract(): Moves points in mArray towards mPoint by mStrength.
function attract(mArray, mPoint, mStrength)
	local array = {};
	for i = 1,#mArray do
		if mArray[i] < mPoint then
			mArray[i] = mArray[i] + mStrength;
			table.insert(array,mArray[i])
		elseif mArray[i] > mPoint then
			mArray[i] = mArray[i] - mStrength;
			table.insert(array,mArray[i])
		else
			table.insert(array,mArray[i])
		end
	end
	return array;
end

-- castWallsByArray(): Takes a ray and makes a *layer* of cWalls with the common THICKNESS. Waits by mDelay before the pattern timeline executes another pattern.
-- TIP: This makes what is called a Layer!
function castWallsByArray(mArray, mDelay)
	for i = 1, #mArray do
		cWall(mArray[i]);
	end
	t_wait(mDelay);
end

-- castWallsByLayers(): Takes an array of layers (which are arrays) and executes them at the rate of mRate. Waits by mEndDelay before the pattern timeline executes another pattern.
function castWallsByLayers(mLayers, mRate, mEndDelay)
	for l = 1,#mLayers do
		for i = 1,#mLayers[l] do
			cWall(mLayers[l][i]); -- Jeez, now isn't that confusing?
		end
		t_wait(mRate);
	end
	t_wait(mEndDelay);
end

-- drawArraySides(): makes an array that starts at mSideBegin and ends at mSideEnd
function drawArraySides(mSideBegin, mSideEnd)
	local array = {};
	for i = mSideBegin,mSideEnd do
		table.insert(array, i);
	end
	return array;
end

-- drawArraydSides(): makes an array that startes at mSideBegin and ends at mSideEnd, but makes dashed lines that are mDashLength long and have spaces the size of mGapLength
function drawArraydSides(mSideBegin, mSideEnd, mDashLength, mGapLength)
	local count = mSideBegin;
	local chunkcount = mSideBegin;
	local array = {};
	while chunkcount < mSideEnd do
		for i = chunkcount,chunkcount+mDashLength-1 do
			table.insert(array, i);
			if chunkcount + count ~= mSideEnd then
				count = count + 1;
			else
				break;
			end
		end
		chunkcount = chunkcount + mDashLength;
		count = 0;
		chunkcount = chunkcount + mGapLength;
	end
	chunkcount = 0;
	return array;
end

-- drawArrayiSides(): Similar to drawArraySides, but increments by mIncrement instead of the default 1.
function drawArrayiSides(mSideBegin, mSideEnd, mIncrement)
	local array = {};
	for i = mSideBegin,mSideEnd,mIncrement do
		table.insert(array, i);
	end
	return array;
end

-- fill(): Fills in missing gaps for the array (from lowest number to highest)
function fill(mArray)
	begin = math.min(unpack(mArray));
	high = math.max(unpack(mArray));
	array = mArray;
	check = 0;
	for i = begin,high do
		for l = 1, #mArray do
			if i == mArray[l] then
			check = check + 1;
			end
		end
		if check == 0 then
			table.insert(array, i);
		end
		check = 0;
	end
	return array;
end

-- fillInverse(): Fills in missing gaps for the array (from highest number to lowest)
function fillInverse(mArray)
	begin = math.max(unpack(mArray));
	high = math.min(unpack(mArray));
	array = mArray;
	check = 0;
	for i = begin,high,-1 do
		for l = 1, #mArray do
			if i == mArray[l] then
			check = check + 1;
			end
		end
		if check == 0 then
			table.insert(array, i);
		end
		check = 0;
	end
	return array;
end

-- fixWallPositions(): This function is meant to fix positions that are outside of the boundaries (The boundaries range from 0 - the amount of sides subtracted by 1).
-- NOTE: This is one of the functions that you should use if something is going wrong! Some of the functions in this extension don't perform well when positions are outside of the boundaries.
function fixWallPositions(mArray)
	local fixedArray = {};
	local maxBounty = l_getSides() - 1;
	for i = 1,#mArray do
		if mArray[i] < 0 or mArray[i] > maxBounty then
			if mArray[i] < 0 then
				repeat mArray[i] = mArray[i] + l_getSides() until mArray[i] > 0;
			end
			mArray[i] = mArray[i] % l_getSides();
		end
		table.insert(fixedArray, mArray[i]);
	end
	return fixedArray;
end

-- getSidesArray(): a function that grabs each individual side and put them inside a table (or as I like to call it, array)
function getSidesArray()
	local sides = {};
  
	for i = 1, l_getSides() do
		table.insert(sides, i - 1);
	end
  
	return sides;
end

-- lerp(): A Linear Interpolation function that transitions a to b at a rate of t (0-1). Nothing to do with arrays but it is a useful function!
function lerp(a, b, t)
    return a * (1-t) + (b*t)
end

-- mergePointsInArray(): Reads mArray and looks for mPoint1 and mPoint2 and merges them. The result will be placed at the end of the array.
-- WARNING: LIKE WITH mergePoints(), TRY TO AVOID GETTING A DECIMAL!
function mergeArrayPoints(mArray,mPoint1,mPoint2)
	local array = {};
	local newPoint = 0;
	local twoPointCheck = 0;
	for i = 1,#mArray do
		if mArray[i] == mPoint1 or mArray[i] == mPoint2 then
		newPoint = newPoint + mArray[i];
		twoPointCheck = twoPointCheck + 1;
		else
		table.insert(array, mArray[i]);
		end
	end
	if twoPointCheck == 2 then
		newPoint = newPoint/2; -- calculate the average
		table.insert(array,newPoint);
		return array;
	else
		log("ERROR: SOMETHING WENT WRONG WHEN CALCULATING MERGE POINT FOR ORIGINAL ARRAY. RETURNING ORIGINAL ARRAY");
		return mArray; -- There was an error in the calculation, so just return the array that was started with
	end
	newPoint = 0;
	twoPointCheck = 0;
end

-- mergeArrays(): Combine arrays together into one.
function mergeArrays(mArrays)
	local array = {};
	for a = 1,#mArrays do
		for i = 1,#mArrays[a] do
			table.insert(array, mArrays[a][i])
		end
		for i = 1,#mArrays[a] do
			table.insert(array, mArrays[a][i])
		end
	end
	return array;
end

-- mergePoints(): a function that takes two different points and merges them into one point. An average position is calculated to determine where the merged point is.
-- WARNING: TRY TO AVOID GETTING A DECIMAL. OTHERWISE IT WONT BE PERFECTLY CENTERED
function mergePoints(mPoint1,mPoint2)
	return math.floor((mPoint1+mPoint2)/2);
end

-- mergeArrayPointsByArrayPosition(): Like mergeArrayPoints, except it merges the values that are in mArrayPosition1 and mArrayPosition2.
function mergeArrayPointsByArrayPosition(mArray,mArrayPosition1,mArrayPosition2)
	local array = {};
	local merged = 0;
	for i = 1,#mArray do
		if i == mArrayPosition1 or i == mArrayPosition2 then
			merged = merged + mArray[i];
		else
			table.insert(array,merged);
		end
	end
	merged = math.floor(merged/2);
	table.insert(array,merged);
	merged = 0;
	return array;
end

-- organizeArray(): Organizes the array from least to greatest.
function organizeArray(mArray)
	local array = {};
	local numberSearch = math.min(unpack(mArray));
	for i = math.min(unpack(mArray)), math.max(unpack(mArray)) do
		for a = 1, #mArray do
			if i == mArray[a] then
				table.insert(array, mArray[a]);
			end
		end
	end
	return array;
end

-- punctureSidesArray(): a function that takes a table of selected sides (mSidesArray) and removes any sides that are listed in mDeleteValues.
function punctureSidesArray(mSidesArray, mDeleteValues)
	local resultArray = mSidesArray;
  
	for i = 1, #mSidesArray do
		for r = 1, #mDeleteValues do 
			if (resultArray[i] == mDeleteValues[r]) then
				table.remove(resultArray,i);
			end
		end
	end  
	return resultArray;
end

-- removeDuplicates(): Removes numbers that have the same value as others in order to save computation power.
function removeDuplicates(mArray)
	local array = {};
	local check = 0;
	for i = 1,#mArray do
		if #array ~= 0 then
			for l = 1,#array do
				if mArray[i] == array[l] then
					check = 1;
				end
			end
		end
		if check == 0 then
			table.insert(array,mArray[i]);
		end
		check = 0;
	end
	return array;
end

-- repel(): Moves points in mArray away from mPoint by mStrength. Any positions that are the same as mPoint will perform the split function.
function repel(mArray, mPoint, mStrength)
	local array = {};
	for i = 1,#mArray do
		if mArray[i] < mPoint then
			mArray[i] = mArray[i] - mStrength;
			table.insert(array,mArray[i])
		elseif mArray[i] > mPoint then
			mArray[i] = mArray[i] + mStrength;
			table.insert(array,mArray[i])
		else
			local splitpoints = splitPoint(mArray[i]);
			for i = 1,#splitpoints do
				table.insert(array,splitpoints[i]);
			end
		end
	end
	return array;
end

-- repelNoSplit(): Just like repel, but it doesn't split when any positions are the same as mPoint, giving you a custom strength for it to repel (mCenterOverride)
function repelNoSplit(mArray, mPoint, mStrength, mCenterOverride)
	local array = {};
	for i = 1,#mArray do
		if mArray[i] < mPoint then
			mArray[i] = mArray[i] - mStrength;
			table.insert(array,mArray[i])
		elseif mArray[i] > mPoint then
			mArray[i] = mArray[i] + mStrength;
			table.insert(array,mArray[i])
		else
			mArray[i] = mArray[i] + mCenterOverride;
			table.insert(array,mArray[i]);
		end
	end
	return array;
end

-- splitPoint(): Takes a point and splits it into two points in an array, the first being mPoint - 1, the second being mPoint - 2.
function splitPoint(mPoint)
	local splits = {};
	table.insert(splits, mPoint + 1);
	table.insert(splits, mPoint - 1);
	return splits;
end

-- splitArray(): Similar to splitPoint, except you split all the points in an array.
function splitArray(mArray)
	local array = {};
	for i = 1,#mArray do
		table.insert(array, mArray[i] + 1);
		table.insert(array, mArray[i] - 1);
	end
	return array;
end

-- splitPointsInArray(): Similiar to splitArray and splitPoint, except this function splits mArray points that are listed in mPointsArray
function splitPointsInArray(mArray, mPointsArray)
	local array = {};
	local matchCheck = 0;
	for i = 1,#mArray do
		for r = 1,#mPointsArray do
			if (mArray[i] == mPointsArray[i]) then
				table.insert(array, mArray[i] + 1);
				table.insert(array, mArray[i] - 1);
				matchCheck = matchCheck + 1;
			end
		end
		if matchCheck == 0 then
			table.insert(array,mArray[i]);
		end
		matchCheck = 0;
	end
end

-- translateArrayOrganization(): Translates the elements in the array by mMovement to be in different positions of the array.
function translateArrayOrganization(mArray, mMovement)
	local newArray = {};
	if mMovement > 0 then
		for i = 1, mMovement do
			table.insert(newArray,mArray[#mArray-i]);
		end
		for i = 0, #mArray - mMovement do
			table.insert(newArray,mArray[i]);
		end
	elseif mMovement < 0 then
		for i = mMovement, #mArray do
			table.insert(newArray,mArray[i]);
		end
		for i = 1, mMovement do
			table.insert(newArray,mArray[i]);
		end
	end
	return newArray;
end


-- translateArrayValue(): Adds or subtracts the value of each element in mArray by mValue
function translateArrayValue(mArray, mValue)
	local array = {};
	for i = 1,#mArray do
		mArray[i] = mArray[i] + mValue;
		table.insert(array, mArray[i]);
	end
	return array;
end





