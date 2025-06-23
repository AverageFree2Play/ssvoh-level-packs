u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "common.lua")

--hurdles
function hurdle()
	for i = 0, l_getSides() do
		w_wall(i, THICKNESS * 0.6)
	end
end

function altHurdle()
	startSide = getRandomSide()
	for i = 0, l_getSides() / 2 do
		w_wall(startSide + 2 * i, THICKNESS * 5)
	end
	t_wait(getPerfectDelay(THICKNESS) * 4)
	hurdle()
	t_wait(getPerfectDelay(THICKNESS) * 11)
end

function altDoubleHurdle()
	startSide = getRandomSide()
	hurdle()
	for i = 0, l_getSides() / 2 do
		w_wall(startSide + 2 * i, THICKNESS * 11)
	end
	t_wait(getPerfectDelay(THICKNESS) * 10)
	hurdle()
	t_wait(getPerfectDelay(THICKNESS) * 11)
end

function singleHurdle()
	side = getRandomSide()
	for i = 0, l_getSides() - 2 do
		w_wall(side + i, THICKNESS * 5)
	end
	t_wait(getPerfectDelay(THICKNESS) * 4)
	hurdle()
	t_wait(getPerfectDelay(THICKNESS) * 11)
end

function doubleSingleHurdle()
	side = getRandomSide()
	hurdle()
	for i = 0, l_getSides() - 2 do
		w_wall(side + i, THICKNESS * 11)
	end
	t_wait(getPerfectDelay(THICKNESS) * 10)
	hurdle()
	t_wait(getPerfectDelay(THICKNESS) * 11)
end

function doubleHurdle()
	side = getRandomSide()
	for i = 0, l_getSides()/2 - 2 do
		w_wall(side + i, THICKNESS * 5)
		w_wall(side + l_getSides()/2 + i, THICKNESS * 5)
	end
	t_wait(getPerfectDelay(THICKNESS) * 4)
	hurdle()
	t_wait(getPerfectDelay(THICKNESS) * 11)
end

function doubleDoubleHurdle()
	side = getRandomSide()
	hurdle()
	for i = 0, l_getSides()/2 - 2 do
		w_wall(side + i, THICKNESS * 11)
		w_wall(side + l_getSides()/2 + i, THICKNESS * 11)
	end
	t_wait(getPerfectDelay(THICKNESS) * 10)
	hurdle()
	t_wait(getPerfectDelay(THICKNESS) * 11)
end

function backAndForthHurdle(mTimes)
	side = getRandomSide()
	t_wait(getPerfectDelay(THICKNESS) * 4)
	hurdle()
	for i = 0, mTimes do
		for j = 2, l_getSides() - 1 do
			w_wall(side + j, THICKNESS * 22)
		end
		w_wall(side, THICKNESS * 4.5)
		t_wait(getPerfectDelay(THICKNESS) * 10)
		hurdle()
		
		w_wall(side + 1, THICKNESS * 4.5)
		t_wait(getPerfectDelay(THICKNESS) * 10)
		hurdle()
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 10)
end

function halfHurdle(mTimes)
	side = getRandomSide()
	for i = 0, mTimes do
		for j = 0, l_getSides()/2 - 1 do
			w_wall(side + j, THICKNESS * 5)
		end
		t_wait(getPerfectDelay(THICKNESS) * 4)
		hurdle()
		t_wait(getPerfectDelay(THICKNESS) * 5.4)
		
		for j = 0, l_getSides()/2 - 1 do
			w_wall(side + l_getSides() / 2 + j, THICKNESS * 5)
		end
		t_wait(getPerfectDelay(THICKNESS) * 4)
		hurdle()
		t_wait(getPerfectDelay(THICKNESS) * 5.4)
	end
	
	t_wait(getPerfectDelay(THICKNESS) * 10)
end

function altHurdleBarrage(mTimes)
	startSide = getRandomSide()
	for i = 0, mTimes do
		for j = 0, l_getSides() / 2 do
			w_wall(startSide + 2 * j, THICKNESS * 5)
		end
		t_wait(getPerfectDelay(THICKNESS) * 4)
		hurdle()
		t_wait(getPerfectDelay(THICKNESS) * 5.4)
		startSide = startSide + 1
	end
	t_wait(getPerfectDelay(THICKNESS) * 10)
end

function hurdleSpiral(mTimes)
	side = getRandomSide()
	dir = getRandomDir()
	hurdle()
	for i = 0, mTimes do
		for j = 0, l_getSides() - 2 do
			w_wall(side + dir * i + j, THICKNESS * 5)
		end
		t_wait(getPerfectDelay(THICKNESS) * 10)
		hurdle()
	end
	t_wait(getPerfectDelay(THICKNESS) * 8)
end