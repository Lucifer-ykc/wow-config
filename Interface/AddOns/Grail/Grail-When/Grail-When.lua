--
--	Grail-When
--	Written by scott@mithrandir.com
--
--	UTF-8 file
--
--	This records when a quest is last completed, and if the quest can be completed more than once,
--	the count of completions is recorded.
--
--	Version History
--		001	Initial version.
--

GrailWhenPlayer = { ['when'] = {}, ['count'] = {} }

local bitMask = Grail.bitMaskQuestRepeatable + Grail.bitMaskQuestDaily + Grail.bitMaskQuestWeekly + Grail.bitMaskQuestMonthly + Grail.bitMaskQuestYearly

Grail._When = function(callbackType, questId)
	questId = tonumber(questId)
	if nil ~= questId then
		local hour, minute = GetGameTime()
		local date = C_DateAndTime.GetCurrentCalendarTime();
		local month, day, year = date.month, date.monthDay, date.year
		GrailWhenPlayer['when'][questId] = string.format("%4d-%02d-%02d %02d:%02d", year, month, day, hour, minute)
		if bit.band(Grail:CodeType(questId), bitMask) > 0 then
			local currentCount = GrailWhenPlayer['count'][questId] or 0
			GrailWhenPlayer['count'][questId] = currentCount + 1	
		end
	end
end

Grail:RegisterObserverQuestComplete(Grail._When)
