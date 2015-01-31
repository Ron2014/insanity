Anchor = {
	TopLeft = 0,
	Top = 1,
	TopRight = 2,
	Left = 3,
	Center = 4,
	Right = 5,
	BottomLeft = 6,
	Bottom = 7,
	BottomRight = 8,
}

function sortpairs(t, inc)
	local inc = inc
	if inc==nil then inc = true end

	local arrayt = {}
	local i = 0
	for k, v in pairs(t) do
		i = i + 1
		arrayt[i] = {k, v}
	end

	table.sort(arrayt, function(a, b)
		local w1, w2, rate = 0, 0, (inc and 1) or -1

		local k1 = unpack(a)
		local k2 = unpack(b)

		if k1 < k2 then w2 = w2 + rate
		elseif k1 > k2 then w1 = w1 + rate end

		return w1 < w2
	end)

	i = 0
	return function()
		i = i + 1
		local e = arrayt[i]
		if e then
			return unpack(e)
		else
			return nil, nil
		end
	end
end

