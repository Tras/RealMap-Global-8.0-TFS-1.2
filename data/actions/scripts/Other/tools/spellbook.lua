function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local cid = player:getId()
	local text = {}
	local spells = {}
	local count = getPlayerInstantSpellCount(cid)
	for i = 0, count - 1 do
		local spell = getPlayerInstantSpellInfo(cid, i)
		if spell and spell.level ~= 0 then
			if spell.manapercent and spell.manapercent > 0 then
				spell.mana = spell.manapercent .. "%"
			end
			if spell.params and spell.params > 0 then
				spell.words = spell.words .. " para"
			end
			spells[#spells + 1] = spell
		end
	end

	table.sort(spells, function(a, b) return a.level < b.level end)

	local prevLevel = -1
	for i, spell in ipairs(spells) do
		if prevLevel ~= spell.level then
			if i == 1 then
				text[1] = "Spells for Level "
			else
				text[#text + 1] = "\nSpells for Level "
			end
			text[#text + 1] = spell.level .. "\n"
			prevLevel = spell.level
		end
		text[#text + 1] = spell.words .. " - " .. spell.name .. " : " .. spell.mana .. "\n"
	end

	player:showTextDialog(item:getId(), table.concat(text))
	return true
end