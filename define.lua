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

State = {
	Ready = 0,
	Run = 1,
	Over = 2,
}

Collider = {
	Category = {
		Border = 0x0003,
		Player = 0x0005,
		Enemy = 0x0006,
		Score = 0x0006,
	},

	Mask = {
		Border = 0x0004,
		Player = 0x0002,
		Enemy = 0x0001,
		Score = 0x0001,
	},

	Group = {
		Border = 1,
		Player = 2,
		Enemy = -3,
		Score = -4,
	}
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

