function AracGUI(Data)
	if not source then
		source = getLocalPlayer()
	end
	local screenW, screenH = guiGetScreenSize()
	local scaleW, scaleH = (screenW/1366), (screenH/768)
	
    vergiPanelWindow = guiCreateWindow(scaleW * 426, scaleH * 205, scaleW * 513, scaleH * 240, "X Roleplay - Araç Bulma Sistemi", false)
	createTAB = guiCreateTabPanel(scaleW * 0, scaleH * 25, scaleW * 530, scaleH * 185, false, vergiPanelWindow)
	kendiarac = guiCreateTab("Şahsi Araçlarım", createTAB)
	if getElementData(localPlayer, "faction") == 1 then
	polisicin = guiCreateTab("EGM Arac Bul", createTAB)	
	aracid = guiCreateEdit(230,79,50,50,"", false, polisicin)
	guiEditSetMaxLength ( aracid, 100 )
	bilgi = guiCreateLabel(2,2,3000,30,"Merhaba memur dostum. \nAşağıda bulunan boşluğa bulmak istediğin aracın ID'sini yaz ve butona bas.", false, polisicin)
	aracbul = guiCreateButton(scaleW * 3, scaleH * 125, scaleW * 490, scaleH * 35, "Aracı Bul", false, polisicin)   
	end
	guiSetInputEnabled(true)
    guiWindowSetSizable(vergiPanelWindow, false)

    vergiPanelGrid = guiCreateGridList(scaleW * 2, scaleH * 2, scaleW * 490, scaleH * 120, false, kendiarac)
    guiGridListAddColumn(vergiPanelGrid, "ID", 0.35)
    guiGridListAddColumn(vergiPanelGrid, "Plaka", 0.25)
    guiGridListAddColumn(vergiPanelGrid, "Marka", 0.30)
	for k,data in ipairs(getElementsByType("vehicle")) do
	if getElementData(data, "owner") == getElementData(getLocalPlayer(), "dbid") then
		local row = guiGridListAddRow(vergiPanelGrid)
		guiGridListSetItemText(vergiPanelGrid, row, 1, getElementData(data, "dbid"), false, true)
		guiGridListSetItemText(vergiPanelGrid, row, 2, getElementData(data, "plate"), false, true)
		guiGridListSetItemText(vergiPanelGrid, row, 3, exports.aracNames:getAracName(getElementModel(data)), false, true)
	end
	end
    kapatBtn = guiCreateButton(scaleW * 10, scaleH * 210, scaleW * 490, scaleH * 25, "Kapat", false, vergiPanelWindow)  
    gtrBtn = guiCreateButton(scaleW * 2, scaleH * 125, scaleW * 495, scaleH * 35, "Yanıma Getir", false, kendiarac)    
	addEventHandler("onClientGUIClick", guiRoot, 
		function() 
			if source == odeBtn then
				local row, col = guiGridListGetSelectedItem(vergiPanelGrid)
				if row == -1 then
					outputChatBox("[!] #f0f0f0Lütfen listeden bir araç seçin.", 255, 0, 0, true)
					return
				end
				local aracID = guiGridListGetItemText(vergiPanelGrid, row, 1)
				destroyElement(vergiPanelWindow)
				triggerServerEvent("aracimi:bul", localPlayer, localPlayer,localPlayer, aracID)
				guiSetInputEnabled(false)
			elseif source == aracbul then
				local aracID = guiGetText(aracid)
				destroyElement(vergiPanelWindow)
				triggerServerEvent("aracimi:bul", localPlayer, localPlayer,localPlayer, aracID)
				guiSetInputEnabled(false)			
			elseif source == gtrBtn then
				local row, col = guiGridListGetSelectedItem(vergiPanelGrid)
				if row == -1 then
					outputChatBox("[!] #f0f0f0Lütfen listeden bir araç seçin.", 255, 0, 0, true)
					return
				end
				local aracID = guiGridListGetItemText(vergiPanelGrid, row, 1)
				destroyElement(vergiPanelWindow)
				triggerServerEvent("aracimi:getir", localPlayer, localPlayer,localPlayer, aracID)
				guiSetInputEnabled(false)			
			elseif source == kapatBtn then
				destroyElement(vergiPanelWindow)
				guiSetInputEnabled(false)
			end
		end
	)
end
addCommandHandler("araclar", AracGUI)
addCommandHandler("araclarim", AracGUI)
