function aracCek(thePlayer, commandName, id)
	if getElementData(thePlayer, "loggedin") == 1 and not getElementData(thePlayer, "adminjailed") and not getElementData(thePlayer, "pd.jailtimer") then
		local playerID = getElementData(thePlayer, "dbid")
		local vehicle = exports.pool:getElement("vehicle", id)
		local dimen = getElementDimension(thePlayer)
		local inter = getElementInterior(thePlayer)
			if vehicle then
				if getElementData(vehicle, "Satilik") then
					outputChatBox("Araç şuan 2. el galeride satışta.", thePlayer, 255, 194, 14)
					return
				end
				if getElementData(vehicle, "aracCekiliyor") then
					outputChatBox("Araç şuan çekiliyor.", thePlayer, 255, 194, 14)
					return
				end					
				if getElementData(vehicle, "otopark") == 1 then
					outputChatBox("Araç şuan otoparkta.", thePlayer, 255, 194, 14)
					return
				end	
				if getElementData(vehicle, "baglandi") == 1 then
					outputChatBox("Bağlı aracı çekemezsiniz.", thePlayer, 255, 194, 14)
					return
				end					
				if getElementData(vehicle, "kilit:kiriliyor") then
					outputChatBox("Aracın kilidi kırıldığı için çekemezsiniz.", thePlayer, 255, 194, 14)
					return
				end					
					if exports.global:takeMoney(thePlayer, 200000) then
						local r = getPedRotation(thePlayer)
						local x, y, z = getElementPosition(thePlayer)
						x = x + ( ( math.cos ( math.rad ( r ) ) ) * 5 )
						y = y + ( ( math.sin ( math.rad ( r ) ) ) * 5 )

						if	(getElementHealth(vehicle)==0) then
							spawnVehicle(vehicle, x, y, z, 0, 0, r)
						else
							setElementPosition(vehicle, x, y, z)
							setVehicleRotation(vehicle, 0, 0, r)
							setElementDimension(vehicle, dimen)
							setElementInterior(vehicle, inter)
						end


						-- outputChatBox("[+] #ffffffArabanı Yanına Çektin.", thePlayer, 255, 194, 14, true)
						outputChatBox("[+] #ffffffArabanı Yanına Çektiğin için 200.000TL kesildi.", thePlayer, 255, 194, 14, true)
					else
						outputChatBox("[!] #ffffffYeterli Miktarda Paran Yok.(200,000TL)", thePlayer, 255, 0, 0,true)
					end
			end
	end
end
addEvent("aracimi:getir", true)
addEventHandler("aracimi:getir", root, aracCek)

function ara_bilgi(thePlayer)
	dbid = getElementData(thePlayer, "dbid")
	outputChatBox("[+] #ffffffSize ait araçlar;", thePlayer, 0,255,0, true)
	for key, value in ipairs(exports.pool:getPoolElementsByType("vehicle")) do
		local owner = tonumber(getElementData(value, "owner"))

		if (owner) and (owner==dbid) then
			outputChatBox(getElementData(value, "dbid"), thePlayer, 255,255,255)
			setElementData(value, "owner", dbid)
		end
	end
end
addCommandHandler("araclarbug", ara_bilgi)
