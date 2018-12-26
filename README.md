关闭玩家进出频道的提示信息
/script ChatFrame_RemoveMessageGroup(ChatFrame1, "CHANNEL")

扩大视野
/script SetCVar("cameraDistanceMax", 50)

将“TAB”的最远距离改为50码 （最大是50）
/console SET targetNearestDistance "50" 

用TAB选择身后的目标最远设为50码 （默认是10码）
/console SET targetNearestDistanceRadius "50" 

光柱宏

/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button1
1骷髅 2XX 3方块 4月亮 5三角 6菱形 7大饼 8星星 9取消

设置/取消屏幕中间标记
/run UIParent:CreateTexture("TuInd");TuInd:SetSize(24,24);TuInd:SetPoint("CENTER",0, -45);TuInd:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_6")
/run TuInd:Hide()


转团给A
/click RaidFrameConvertToRaidButton
/click RaidFrameAllAssistCheckButton

去除和恢复屏幕中上部系统的红字提示（一些系统和战斗报错信息，宏多了这些信息刷的很快，清除了比较舒服点。）
去除：/script UIErrorsFrame:Hide()
恢复：/script UIErrorsFrame:Show()

关语言过滤
/run InterfaceOptionsSocialPanelProfanityFilter:Enable()

/console SET profanityFilter "0"

/script race=UnitRace("player");if race=="牛头人" then Miss=7;else Miss=5;end;DEFAULT_CHAT_FRAME:AddMessage("满四围需要102.4. 你当前的四围是: "..string.format("%.2f", GetDodgeChance()+GetBlockChance()+GetParryChance()+Miss))

/script SILVER_PER_GOLD =0.00001 金币调大
/script SILVER_PER_GOLD =100  恢复原状

防暂离宏
/script T,F=T or 0,F or CreateFrame("frame")if X then X=nil else X=function()local t=GetTime()if t-T>1 then StaticPopup1Button1:Click()T=t end end end F:SetScript ("OnUpdate",X)
使用方法：1、角色界面禁用所有插件
2、进入游戏
3、点击宏
4、将人物跑到野外
5、回角色选择
如果没有出现读秒 则表示挂机成功，人物挂机不会掉线

