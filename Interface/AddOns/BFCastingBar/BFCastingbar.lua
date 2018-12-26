 local BFCBEvent = BLibrary("BEvent"); local BFCastingBar_6c391f92e72d1c9b7434bca8947c5e2c = BLibrary("BSecureHook"); local SM = LibStub("LibSharedMedia-3.0") local _ BFCB={} BFCBConfig = BFCBConfig or { showText=true, showLatency=true, width=200, showUsedTime=true } BFCBEvent:Init{ name="BFCastingBar", func=function() local BFCastingBar_1ec77ded1507d66ae96235380f042d6e=CastingBarFrame:CreateFontString("CastingBarFrameLatencyText"); BFCastingBar_1ec77ded1507d66ae96235380f042d6e:SetPoint("TOPRIGHT",CastingBarFrame,"BOTTOMRIGHT",0,-4) BFCastingBar_1ec77ded1507d66ae96235380f042d6e:SetFont("Fonts\\FRIZQT__.TTF",12,"OUTLINE"); BFCBEvent.latencyText=BFCastingBar_1ec77ded1507d66ae96235380f042d6e BFCBEvent.castingBar=CastingBarFrame if BFCBConfig.width then CastingBarFrame:SetWidth(220 ) CastingBarFrame.Border:SetWidth(1.3*220) CastingBarFrame.Flash:SetWidth(1.3*220) end BFCBEvent.castingBarText=CastingBarFrame.Text if not BFCBEvent.delayBar then BFCBEvent.delayBar = CastingBarFrame:CreateTexture("StatusBar", "BORDER"); BFCBEvent.delayBar:SetHeight(CastingBarFrame:GetHeight()); BFCBEvent.delayBar:SetTexture(SM:Fetch("statusbar", "Smooth")) BFCBEvent.delayBar:SetVertexColor(0.8, 0, 0, 0.8) BFCBEvent.delayBar:Hide() end end, } function BFCBEvent:spell_start(unit) if unit ~= 'player' then return end if not self.sendTime then return end local _spellName, startTime, endTime if self.channeling then _spellName, _, _, startTime, endTime = UnitChannelInfo(unit) elseif self.casting then _spellName, _, _, startTime, endTime = UnitCastingInfo(unit) end if not startTime or not endTime then return end self.startTime = startTime / 1000; self.endTime = endTime/1000; self.timeDiff = GetTime() - self.sendTime; local castlength = endTime - startTime self.timeDiff = self.timeDiff > castlength and castlength or self.timeDiff self.spellName = _spellName or "" self.spellLength = castlength/1000 end function BFCBEvent:UNIT_SPELLCAST_START(unit) if unit ~= 'player' then return end self.channeling=nil self.casting = true BFCBEvent:spell_start(unit) end function BFCBEvent:UNIT_SPELLCAST_SENT(unit) if unit ~= 'player' then return end self.sendTime = GetTime() end function BFCBEvent:UNIT_SPELLCAST_FAILED(unit) if unit ~= "player" then return end self.casting = nil self.channeling = nil end function BFCBEvent:UNIT_SPELLCAST_INTERRUPTED(unit) if unit ~= "player" then return end self.casting = nil self.channeling = nil end function BFCBEvent:UNIT_SPELLCAST_CHANNEL_START(unit) if unit ~= 'player' then return end self.channeling=true self.casting = nil BFCBEvent:spell_start(unit) end function BFCBEvent:OnUpdate(BFCastingBar_411b8aa6d5954c6020f0b9c9e80e847a) if self.channeling or self.casting then local BFCastingBar_e6955c64cf39bdb23dc86de1a9ec2117="" if BFCBConfig.showText and self.spellName then BFCastingBar_e6955c64cf39bdb23dc86de1a9ec2117=BFCastingBar_e6955c64cf39bdb23dc86de1a9ec2117..self.spellName end if self.startTime and self.endTime then if BFCBConfig.showUsedTime then BFCastingBar_e6955c64cf39bdb23dc86de1a9ec2117=BFCastingBar_e6955c64cf39bdb23dc86de1a9ec2117.."\t("..string.onedigitfloat(GetTime()-self.startTime) else BFCastingBar_e6955c64cf39bdb23dc86de1a9ec2117=BFCastingBar_e6955c64cf39bdb23dc86de1a9ec2117.."\t("..string.onedigitfloat(self.endTime-GetTime()) end end if self.spellLength then BFCastingBar_e6955c64cf39bdb23dc86de1a9ec2117=BFCastingBar_e6955c64cf39bdb23dc86de1a9ec2117.."/"..string.twodigitfloat(self.spellLength)..")"; end self.castingBarText:SetText(BFCastingBar_e6955c64cf39bdb23dc86de1a9ec2117) self.castingBarText:Show() if BFCBConfig.showLatency and self.timeDiff then self.latencyText:SetText("+"..string.twodigitfloat(self.timeDiff).."s") self.latencyText:Show() end end local modulus = self.timeDiff/BFCastingBar_411b8aa6d5954c6020f0b9c9e80e847a.maxValue local color if self.timeDiff<0.1 then color={0.2,0.8,0.8,0.8} elseif self.timeDiff<0.3 then color={0.4,0.8,0.2,0.8} else color={0.8,0,0,0.8} end if modulus > 1 then modulus = 1 elseif modulus < 0 then modulus = 0 end end function BFCB_CastingBarUpdate(frame) BFCBEvent:OnUpdate(frame) end local function initValues() BFCBEvent.timeDiff = 0; BFCBEvent.startTime = 0; BFCBEvent.endTime = 0; BFCBEvent.sendTime = 0; BFCBEvent.spellLength = 0; end function BFCB:Toggle(enabled) if enabled then BFCBEvent:RegisterEvent("UNIT_SPELLCAST_SENT"); BFCBEvent:RegisterEvent("UNIT_SPELLCAST_START"); BFCBEvent:RegisterEvent("UNIT_SPELLCAST_FAILED"); BFCBEvent:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED"); BFCBEvent:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START"); initValues(); BFCastingBar_6c391f92e72d1c9b7434bca8947c5e2c:Enable() BFCastingBar_6c391f92e72d1c9b7434bca8947c5e2c:HookScript(CastingBarFrame, "OnUpdate", BFCB_CastingBarUpdate); else BFCBEvent:UnregisterAllEvent(); BFCBEvent.delayBar:Hide() BFCBEvent.latencyText:Hide() BFCastingBar_6c391f92e72d1c9b7434bca8947c5e2c:Disable(); end end string.twodigitfloat = function(BFCastingBar_f4e13e8ecf20422833dd2d694a22bf40) return string.format("%.1f",BFCastingBar_f4e13e8ecf20422833dd2d694a22bf40) end string.onedigitfloat = function(BFCastingBar_f4e13e8ecf20422833dd2d694a22bf40) return string.format("%.1f",BFCastingBar_f4e13e8ecf20422833dd2d694a22bf40) end 
