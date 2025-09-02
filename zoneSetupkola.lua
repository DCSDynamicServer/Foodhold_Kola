function merge(tbls)
	local res = {}
	for i,v in ipairs(tbls) do
		for i2,v2 in ipairs(v) do
			table.insert(res,v2)
		end
	end
	
	return res
end

function allExcept(tbls, except)
	local tomerge = {}
	for i,v in pairs(tbls) do
		if i~=except then
			table.insert(tomerge, v)
		end
	end
	return merge(tomerge)
end

carrier = {
	blue = { "bShip","bShip"},
	red = {}
}

airfield = {
	blue = { "bInfantry", "bArmor", "bSam", "bSam2", "bSam3"},
	red = {"rInfantry", "rArmor", "rSam", "rSam2", "rSam3" }
}

farp = {
	blue = {"bInfantry", "bArmor", "bSam"},
	red = {"rInfantry", "rArmor", "rSam" }
}

regularzone = {
	blue = {"bInfantry", "bArmor", "bSamIR"},
	red = {"rInfantry", "rArmor", "rSamIR" }
}

specialSAM = {
	blue = {"bInfantry", "bSamIR","bInfantry", "bInfantry", "bSamBig" },
	red = {"rInfantry", "rSamIR", "rInfantry", "rInfantry", "rSamBig" }
}

specialKrasnodar = {
	blue = {"bInfantry", "bSamIR","bSam2", "bSam3", "bSamBig", "bSamFinal" },
	red = {"rInfantry", "rSamIR", "rSam2", "rSam3", "rSamBig", "rSamFinal" }
}

convoy = {
	blue = {"bInfantry"},
	red = {"rInfantry", "rInfantry", "rArmor"}
}

cargoSpawns = {
	["Bodø"] = {"c1","c2","c3"},
	["Alta FARP"] = {"c6","c7"},
	["Murmansk"] = {"c8","c9","c10"},
	["Monchegorsk Factory"] = {"c4","c5","c11"},
	["Kirkenes FARP"] = {"c12","c13"}
}

farpSupply = {
	["Alta FARP"] = {"bravoFuelAndAmmo"},
	["Kirkenes FARP"] = {"echoFuelAndAmmo"}
}

cargoAccepts = {
	anapa = allExcept(cargoSpawns, 'Bodø'),
	bravo =  allExcept(cargoSpawns, 'Alta FARP'),
	krymsk =  allExcept(cargoSpawns, 'Murmansk'),
	factory =  allExcept(cargoSpawns, 'Monchegorsk Factory'),
	echo =  allExcept(cargoSpawns, 'Kirkenes FARP'),
	general = allExcept(cargoSpawns)
}

flavor = {
	anapa = 'WPT 1\nHome base',
	carrier = 'Carrier group',
	alpha='WPT 2\nDefensive position next to the town of Natuhaevskaya',
	bravo='WPT 3\nFARP next to the town of Damanka.\nWill let us launch helicopter attacks from a bit closer to the action.',
	charlie='WPT 4\nDefensive position next to an old TV tower.\nWill provide allied air patrol to help capture Alta FARP',
	convoy='WPT 5\nSupply convoy detained north of Alta FARP.\nKeep damage to the trucks to a minimum while liberating this area.\nWe could really use the supplies.',
	krymsk='WPT 7\nAirbase next to the city of Murmansk.\nCapturing it will provide us with valuable aircraft to use for our cause.',
	radio='WPT 8\nRadio atenna on the outskirts of Murmansk.\nIf we capture it, we can launch AWACS from the nearby airport\nto get some much needed intel on the enemy.',
	oilfields='WPT 6\nOil extraction and Refinery north of Murmansk.\nCapture it to get a steady stream of income, or just destroy it to put a hole in the enemy wallet.',
	delta='WPT 10\nDefensive position out in the middle of nowhere',
	factory='WPT 9\nWeapon factory next to the town of Homskiy.\nWe can use it to resupply nearby bases.\nIt will also provide a steady stream of income.',
	samsite='WPT 11\nHome to an old SA-2 site.\nIf we capture it, we might be able to get some use out of it.',
	foxtrot='WPT 13\nDefensive position with a nice view of a lake',
	echo='WPT 12\nFARP next to the city of Rovaniemi.\nCapturing it will let us operate our helicopters in the area.',
	krasnodar='WPT 14\nAirbase next to the city of Rovaniemi.\nThe home base of our enemy. Capture it to deprive them of their most valuable asset.'
}

local filepath = 'foothold_1.4.lua'
if lfs then 
	local dir = lfs.writedir()..'Missions/Saves/'
	lfs.mkdir(dir)
	filepath = dir..filepath
	env.info('Foothold - Save file path: '..filepath)
end
bc = BattleCommander:new(filepath, 10, 60)
anapa = ZoneCommander:new({zone='Bodø', side=2, level=5, upgrades=airfield, crates=cargoAccepts.anapa, flavorText=flavor.anapa})
carrier = ZoneCommander:new({zone='Carrier Group', side=2, level=2, upgrades=carrier, crates={}, flavorText=flavor.carrier})
alpha = ZoneCommander:new({zone='Tromsø', side=0, level=0, upgrades=regularzone, crates=cargoAccepts.general, flavorText=flavor.alpha})
bravo = ZoneCommander:new({zone='Alta FARP', side=1, level=3, upgrades=farp, crates=cargoAccepts.bravo, flavorText=flavor.bravo})
charlie = ZoneCommander:new({zone='Hammerfest', side=0, level=0, upgrades=regularzone, crates=cargoAccepts.general, flavorText=flavor.charlie})
convoy = ZoneCommander:new({zone='Convoy', side=1, level=3, upgrades=convoy, crates=cargoAccepts.general, flavorText=flavor.convoy})
krymsk = ZoneCommander:new({zone='Murmansk', side=1, level=5, upgrades=airfield, crates=cargoAccepts.krymsk, flavorText=flavor.krymsk})
oilfields = ZoneCommander:new({zone='Petrozavodsk Oilfields', side=1, level=3, upgrades=farp, crates=cargoAccepts.general, flavorText=flavor.oilfields, income=2})
radio = ZoneCommander:new({zone='Radar Site', side=1, level=1, upgrades=regularzone, crates=cargoAccepts.general, flavorText=flavor.radio})
delta = ZoneCommander:new({zone='Narvik', side=1, level=1, upgrades=regularzone, crates=cargoAccepts.general, flavorText=flavor.delta})
factory = ZoneCommander:new({zone='Monchegorsk Factory', side=1, level=1, upgrades=regularzone, crates=cargoAccepts.factory, flavorText=flavor.factory, income=2})
samsite = ZoneCommander:new({zone='Old SA-2 Site', side=0, level=0, upgrades=specialSAM, crates=cargoAccepts.general, flavorText=flavor.samsite})
foxtrot = ZoneCommander:new({zone='Kandalaksha', side=1, level=3, upgrades=regularzone, crates=cargoAccepts.general, flavorText=flavor.foxtrot})
echo = ZoneCommander:new({zone='Kirkenes FARP', side=1, level=3, upgrades=farp, crates=cargoAccepts.echo, flavorText=flavor.echo})
krasnodar = ZoneCommander:new({zone='Rovaniemi', side=1, level=6, upgrades=specialKrasnodar, crates=cargoAccepts.general, flavorText=flavor.krasnodar, income=2})

radio:addCriticalObject('RadioTower')
samsite:addCriticalObject('CommandCenter')
factory:addCriticalObject('FactoryBuilding1')
factory:addCriticalObject('FactoryBuilding2')
convoy:addCriticalObject('convoy1')
convoy:addCriticalObject('convoy2')
convoy:addCriticalObject('convoy3')
convoy:addCriticalObject('convoy4')

local oilbuildings = {'oilref1','oilref2'}
for i,v in ipairs(oilbuildings) do
	oilfields:addCriticalObject(v)
end

dispatch = {
	krymsk = {
		GroupCommander:new({name='krym1', mission='supply', targetzone='Alta FARP'}),
		GroupCommander:new({name='krym2', mission='attack', targetzone='Alta FARP'}),
		GroupCommander:new({name='krym3', mission='patrol', targetzone='Alta FARP'}),
		GroupCommander:new({name='krym4', mission='patrol', targetzone='Murmansk'}),
		GroupCommander:new({name='krym5', mission='supply', targetzone='Radar Site'}),
		GroupCommander:new({name='krym6', mission='attack', targetzone='Radar Site'}),
		GroupCommander:new({name='krym7', mission='patrol', targetzone='Radar Site'}),
		GroupCommander:new({name='krym8', mission='patrol', targetzone='Alta FARP'}),
		GroupCommander:new({name='krym9', mission='patrol', targetzone='Murmansk'}),
		GroupCommander:new({name='krym10', mission='supply', targetzone='Alta FARP'}),
		GroupCommander:new({name='krym11', mission='supply', targetzone='Radar Site'}),
		GroupCommander:new({name='krym12', mission='supply', targetzone='Narvik'}),
		GroupCommander:new({name='krym13', mission='attack', targetzone='Narvik'}),
		GroupCommander:new({name='krym14', mission='supply', targetzone='Monchegorsk Factory'}),
		GroupCommander:new({name='krym15', mission='attack', targetzone='Monchegorsk Factory'}),
		GroupCommander:new({name='krym16', mission='supply', targetzone='Narvik'}),
		GroupCommander:new({name='krym17', mission='supply', targetzone='Monchegorsk Factory'}),
		GroupCommander:new({name='krym18', mission='supply', targetzone='Old SA-2 Site'}),
		GroupCommander:new({name='krym19', mission='supply', targetzone='Old SA-2 Site'}),
		GroupCommander:new({name='krym20', mission='attack', targetzone='Old SA-2 Site'}),
		GroupCommander:new({name='krym21', mission='patrol', targetzone='Narvik'}),
		GroupCommander:new({name='krym22', mission='supply', targetzone='Petrozavodsk Oilfields'}),
		GroupCommander:new({name='krym23', mission='supply', targetzone='Petrozavodsk Oilfields'}),
		GroupCommander:new({name='krym24', mission='attack', targetzone='Petrozavodsk Oilfields'}),
		GroupCommander:new({name='krym25', mission='attack', targetzone='Alta FARP', type='surface'})
	},
	bravo = {
		GroupCommander:new({name='bravo1', mission='supply', targetzone='Tromsø'}),
		GroupCommander:new({name='bravo2', mission='attack', targetzone='Tromsø'}),
		GroupCommander:new({name='bravo6', mission='supply', targetzone='Hammerfest'}),
		GroupCommander:new({name='bravo7', mission='attack', targetzone='Hammerfest'}),
		GroupCommander:new({name='bravo4', mission='supply', targetzone='Murmansk'}),
		GroupCommander:new({name='bravo5', mission='attack', targetzone='Murmansk'}),
		GroupCommander:new({name='bravo8', mission='supply', targetzone='Murmansk'}),
		GroupCommander:new({name='bravo10', mission='supply', targetzone='Hammerfest'}),
		GroupCommander:new({name='bravo9', mission='supply', targetzone='Tromsø'}),
		GroupCommander:new({name='bravo11', mission='supply', targetzone='Petrozavodsk Oilfields'}),
		GroupCommander:new({name='bravo12', mission='supply', targetzone='Petrozavodsk Oilfields'}),
		GroupCommander:new({name='bravo13', mission='attack', targetzone='Petrozavodsk Oilfields'}),
		GroupCommander:new({name='bravo14', mission='supply', targetzone='Convoy', type='surface'})
	},
	anapa = {
		GroupCommander:new({name='anapa1', mission='supply', targetzone='Tromsø'}),
		GroupCommander:new({name='anapa3', mission='supply', targetzone='Alta FARP'}),
		GroupCommander:new({name='anapa2', mission='supply', targetzone='Hammerfest'}),
		GroupCommander:new({name='anapa5', mission='patrol', targetzone='Alta FARP'})
	},
	charlie={
		GroupCommander:new({name='anapa6', mission='attack', targetzone='Alta FARP'})
	},
	factory={
		GroupCommander:new({name='factory1', mission='supply', targetzone='Murmansk'}),
		GroupCommander:new({name='factory2', mission='supply', targetzone='Murmansk'}),
		GroupCommander:new({name='factory3', mission='supply', targetzone='Narvik'}),
		GroupCommander:new({name='factory4', mission='supply', targetzone='Narvik'}),
		GroupCommander:new({name='factory5', mission='supply', targetzone='Kandalaksha'}),
		GroupCommander:new({name='factory6', mission='supply', targetzone='Kandalaksha'}),
		GroupCommander:new({name='factory7', mission='supply', targetzone='Kirkenes FARP'}),
		GroupCommander:new({name='factory8', mission='supply', targetzone='Kirkenes FARP'}),
		GroupCommander:new({name='factory-krymsk-supply', mission='supply', targetzone='Murmansk', type='surface'}),
		GroupCommander:new({name='factory-delta-supply', mission='supply', targetzone='Narvik', type='surface'}),
		GroupCommander:new({name='factory-echo-supply', mission='supply', targetzone='Kirkenes FARP', type='surface'}),
		GroupCommander:new({name='factory-foxtrot-supply', mission='supply', targetzone='Kandalaksha', type='surface'})
	},
	echo={
		GroupCommander:new({name='echo1', mission='supply', targetzone='Old SA-2 Site'}),
		GroupCommander:new({name='echo2', mission='supply', targetzone='Old SA-2 Site'}),
		GroupCommander:new({name='echo3', mission='attack', targetzone='Narvik'}),
		GroupCommander:new({name='echo4', mission='supply', targetzone='Narvik'}),
		GroupCommander:new({name='echo5', mission='supply', targetzone='Narvik'}),
		GroupCommander:new({name='echo6', mission='supply', targetzone='Monchegorsk Factory'}),
		GroupCommander:new({name='echo7', mission='supply', targetzone='Monchegorsk Factory'}),
		GroupCommander:new({name='echo8', mission='attack', targetzone='Monchegorsk Factory'}),
		GroupCommander:new({name='echo9', mission='supply', targetzone='Kandalaksha'}),
		GroupCommander:new({name='echo10', mission='supply', targetzone='Kandalaksha'}),
		GroupCommander:new({name='echo11', mission='attack', targetzone='Kandalaksha'}),
		GroupCommander:new({name='echo12', mission='supply', targetzone='Rovaniemi'}),
		GroupCommander:new({name='echo13', mission='supply', targetzone='Rovaniemi'}),
		GroupCommander:new({name='echo14', mission='supply', targetzone='Rovaniemi'})
	},
	krasnodar={
		GroupCommander:new({name='kras1', mission='supply', targetzone='Kirkenes FARP'}),
		GroupCommander:new({name='kras2', mission='supply', targetzone='Kirkenes FARP'}),
		GroupCommander:new({name='kras3', mission='supply', targetzone='Kandalaksha'}),
		GroupCommander:new({name='kras4', mission='supply', targetzone='Kandalaksha'}),
		GroupCommander:new({name='kras5', mission='attack', targetzone='Old SA-2 Site'}),
		GroupCommander:new({name='kras6', mission='attack', targetzone='Murmansk'}),
		GroupCommander:new({name='kras7', mission='attack', targetzone='Radar Site'}),
		GroupCommander:new({name='kras8', mission='attack', targetzone='Monchegorsk Factory'}),
		GroupCommander:new({name='kras9', mission='attack', targetzone='Kirkenes FARP'}),
		GroupCommander:new({name='kras10', mission='attack', targetzone='Kandalaksha'}),
		GroupCommander:new({name='kras11', mission='patrol', targetzone='Kirkenes FARP'}),
		GroupCommander:new({name='kras12', mission='patrol', targetzone='Narvik'}),
		GroupCommander:new({name='kras13', mission='patrol', targetzone='Monchegorsk Factory'})
	},
	foxtrot={
		GroupCommander:new({name='foxtrot-krymsk-attack', mission='attack', targetzone='Murmansk', type='surface'}),
		GroupCommander:new({name='foxtrot-echo-attack', mission='attack', targetzone='Kirkenes FARP', type='surface'})
	},
	oilfields={
		GroupCommander:new({name='oil-krymsk-supply', mission='supply', targetzone='Murmansk', type='surface'})
	}
}


anapa:addGroups(dispatch.anapa)
bravo:addGroups(dispatch.bravo)
krymsk:addGroups(dispatch.krymsk)
charlie:addGroups(dispatch.charlie)
factory:addGroups(dispatch.factory)
echo:addGroups(dispatch.echo)
krasnodar:addGroups(dispatch.krasnodar)
foxtrot:addGroups(dispatch.foxtrot)
oilfields:addGroups(dispatch.oilfields)

bc:addZone(anapa)
bc:addZone(carrier)
bc:addZone(alpha)
bc:addZone(bravo)
bc:addZone(charlie)
bc:addZone(convoy)
bc:addZone(krymsk)
bc:addZone(oilfields)
bc:addZone(radio)
bc:addZone(delta)
bc:addZone(factory)
bc:addZone(samsite)
bc:addZone(foxtrot)
bc:addZone(echo)
bc:addZone(krasnodar)

bc:addConnection("Bodø","Tromsø")
bc:addConnection("Tromsø","Alta FARP")
bc:addConnection("Alta FARP","Murmansk")
bc:addConnection("Alta FARP","Hammerfest")
bc:addConnection("Alta FARP","Convoy")
bc:addConnection("Bodø","Hammerfest")
bc:addConnection("Alta FARP","Petrozavodsk Oilfields")
bc:addConnection("Murmansk","Petrozavodsk Oilfields")
bc:addConnection("Murmansk","Radar Site")
bc:addConnection("Murmansk","Monchegorsk Factory")
bc:addConnection("Murmansk","Narvik")
bc:addConnection("Monchegorsk Factory","Narvik")
bc:addConnection("Monchegorsk Factory","Kandalaksha")
bc:addConnection("Monchegorsk Factory","Kirkenes FARP")
bc:addConnection("Narvik","Kirkenes FARP")
bc:addConnection("Kandalaksha","Rovaniemi")
bc:addConnection("Kirkenes FARP","Rovaniemi")
bc:addConnection("Kirkenes FARP","Old SA-2 Site")
bc:addConnection("Murmansk","Old SA-2 Site")


convoy:registerTrigger('lost', function (event, sender)
	local convoyItems = {'convoy1','convoy2','convoy3', 'convoy4'}
	
	local message = "Convoy liberated"
	local totalLost = 0
	for i,v in ipairs(convoyItems) do
		if not StaticObject.getByName(v) then
			totalLost = totalLost+1
		end
	end
	
	if totalLost>0 then
		local percentLost = math.ceil((totalLost/#convoyItems)*100)
		percentLost = math.min(percentLost,100)
		percentLost = math.max(percentLost,1)
		message = message..' but we lost '..percentLost..'% of the trucks.'
	else
		message = message..'. We recovered all of the supplies.'
	end
	
	local creditsEarned = (#convoyItems - totalLost) * 250
	message = message..'\n\n+'..creditsEarned..' credits'
	
	bc:addFunds(2, creditsEarned)
	
	trigger.action.outTextForCoalition(2, message, 15)
end, 'convoyLost', 1)

local showCredIncrease = function(event, sender)
	trigger.action.outTextForCoalition(sender.side, '+'..math.floor(sender.income*360)..' Credits/Hour', 5)
end

oilfields:registerTrigger('captured', showCredIncrease, 'oilfieldcaptured')
factory:registerTrigger('captured', showCredIncrease, 'factorycaptured')

krymsk:registerTrigger('captured', function(event,sender)
	local kr = bc:getZoneByName('Murmansk')
	if kr.side == 1 then
		local krforces = { 'krymsk-gforce-1','krymsk-gforce-2','krymsk-gforce-3','krymsk-tforce-1' }
		for _,v in ipairs(krforces) do
			local g = Group.getByName(v)
			if g then
				g:destroy()
			end
		end
	end
end, 'krymskcaptured')

local checkMissionComplete = function (event, sender)
	local done = true
	for i,v in ipairs(bc:getZones()) do
		if v.side == 1 then
			done = false
			break
		end
	end
	
	if done then
		trigger.action.outText("Enemy has been defeated. \n\nMission Complete.", 120)
	end
end

for i,v in ipairs(bc:getZones()) do
	v:registerTrigger('lost', checkMissionComplete, 'missioncompleted')
end

--bc:addFunds(1,0)
--bc:addFunds(2,0)

Group.getByName('sead1'):destroy()
local seadTargetMenu = nil
bc:registerShopItem('sead', 'F/A-18C SEAD mission', 250, function(sender) 
	local gr = Group.getByName('sead1')
	if Utils.isGroupActive(gr) then 
		return 'SEAD mission still in progress'
	end
	mist.respawnGroup('sead1', true)
	
	if seadTargetMenu then
		return 'Choose target zone from F10 menu'
	end
	
	local launchAttack = function(target)
		if Group.getByName('sead1') then
			local err = bc:engageZone(target, 'sead1')
			if err then
				return err
			end
			
			trigger.action.outTextForCoalition(2, 'F/A-18C Hornets engaging SAMs at '..target, 15)
		else
			trigger.action.outTextForCoalition(2, 'Group has left the area or has been destroyed', 15)
		end
		
		seadTargetMenu = nil
	end
	
	seadTargetMenu = bc:showTargetZoneMenu(2, 'SEAD Target', launchAttack, 1)
	
	trigger.action.outTextForCoalition(2, 'F/A-18C Hornets on route. Choose target zone from F10 menu', 15)
end,
function (sender, params)
	if params.zone and params.zone.side == 1 then
		local gr = Group.getByName('sead1')
		if Utils.isGroupActive(gr) then 
			return 'SEAD mission still in progress'
		end
		
		mist.respawnGroup('sead1', true)
		mist.scheduleFunction(function(target)
			if Group.getByName('sead1') then
				local err = bc:engageZone(target, 'sead1')
				if err then
					return err
				end
				
				trigger.action.outTextForCoalition(2, 'F/A-18C Hornets engaging SAMs at '..target, 15)
			end
		end,{params.zone.zone},timer.getTime()+2)
	else
		return 'Can only target enemy zone'
	end
end)

Group.getByName('sweep1'):destroy()
bc:registerShopItem('sweep', 'F-14B Fighter Sweep', 150, function(sender) 
	local gr = Group.getByName('sweep1')
	if Utils.isGroupActive(gr) then 
		return 'Fighter sweep mission still in progress'
	end
	mist.respawnGroup('sweep1', true)
end,
function (sender, params)
	local gr = Group.getByName('sweep1')
	if Utils.isGroupActive(gr) then 
		return 'Fighter sweep mission still in progress'
	end
	mist.respawnGroup('sweep1', true)
end)

Group.getByName('cas1'):destroy()
local casTargetMenu = nil
bc:registerShopItem('cas', 'F-4 Ground Attack', 400, function(sender) 
	local gr = Group.getByName('cas1')
	if Utils.isGroupActive(gr) then 
		return 'Ground attack mission still in progress'
	end
	
	mist.respawnGroup('cas1', true)
	
	if casTargetMenu then
		return 'Choose target zone from F10 menu'
	end
	
	local launchAttack = function(target)
		if casTargetMenu then
			if Group.getByName('cas1') then
				local err = bc:engageZone(target, 'cas1')
				if err then
					return err
				end
				
				trigger.action.outTextForCoalition(2, 'F-4 Phantoms engaging groups at '..target, 15)
			else
				trigger.action.outTextForCoalition(2, 'Group has left the area or has been destroyed', 15)
			end
			
			casTargetMenu = nil
		end
	end
	
	casTargetMenu = bc:showTargetZoneMenu(2, 'F-4 Target', launchAttack, 1)
	
	trigger.action.outTextForCoalition(2, 'F-4 Phantoms on route. Choose target zone from F10 menu', 15)
end,
function (sender, params)
	if params.zone and params.zone.side == 1 then
		local gr = Group.getByName('cas1')
		if Utils.isGroupActive(gr) then 
			return 'Ground attack mission still in progress'
		end
		
		mist.respawnGroup('cas1', true)
		mist.scheduleFunction(function(target)
			if Group.getByName('cas1') then
				local err = bc:engageZone(target, 'cas1')
				if err then
					return err
				end
				
				trigger.action.outTextForCoalition(2, 'F-4 Phantoms engaging groups at '..target, 15)
			end
		end,{params.zone.zone},timer.getTime()+2)
	else
		return 'Can only target enemy zone'
	end
end)

bc:addMonitoredROE('cruise1')
local cruiseMissileTargetMenu = nil
bc:registerShopItem('cruisemsl', 'Cruise Missile Strike', 800, function(sender)
	if cruiseMissileTargetMenu then
		return 'Choose target zone from F10 menu'
	end
	
	local launchAttack = function(target)
		if cruiseMissileTargetMenu then
			local err = bc:fireAtZone(target, 'cruise1', true, 8)
			if err then
				return err
			end
			
			cruiseMissileTargetMenu = nil
			trigger.action.outTextForCoalition(2, 'Launching cruise missiles at '..target, 15)
		end
	end
	
	cruiseMissileTargetMenu = bc:showTargetZoneMenu(2, 'Cruise Missile Target', launchAttack, 1)
	
	trigger.action.outTextForCoalition(2, 'Cruise missiles ready. Choose target zone from F10 menu', 15)
end,
function (sender, params)
	if params.zone and params.zone.side == 1 then
		local err = bc:fireAtZone(params.zone.zone, 'cruise1', true, 8)
		if err then
			return err
		end
		
		trigger.action.outTextForCoalition(2, 'Launching cruise missiles at '..params.zone.zone, 15)
	else
		return 'Can only target enemy zone'
	end
end)

local upgradeMenu = nil
bc:registerShopItem('supplies', 'Resupply friendly Zone', 200, function(sender)
	if upgradeMenu then
		return 'Choose zone from F10 menu'
	end
	
	local upgradeZone = function(target)
		if upgradeMenu then
			local zn = bc:getZoneByName(target)
			if zn and zn.side==2 then
				zn:upgrade()
			else
				return 'Zone not friendly'
			end
			
			upgradeMenu = nil
		end
	end
	
	upgradeMenu = bc:showTargetZoneMenu(2, 'Select Zone to resupply', upgradeZone, 2)
	
	trigger.action.outTextForCoalition(2, 'Supplies prepared. Choose zone from F10 menu', 15)
end,
function(sender, params)
	if params.zone and params.zone.side == 2 then
		params.zone:upgrade()
	else
		return 'Can only target friendly zone'
	end
end)

Group.getByName('jtacDrone'):destroy()
local jtacTargetMenu = nil
drone = JTAC:new({name = 'jtacDrone'})
bc:registerShopItem('jtac', 'MQ-1A Predator JTAC mission', 100, function(sender)
	
	if jtacTargetMenu then
		return 'Choose target zone from F10 menu'
	end
	
	local spawnAndOrbit = function(target)
		if jtacTargetMenu then
			local zn = bc:getZoneByName(target)
			drone:deployAtZone(zn)
			drone:showMenu()
			trigger.action.outTextForCoalition(2, 'Predator drone deployed over '..target, 15)
			jtacTargetMenu = nil
		end
	end
	
	jtacTargetMenu = bc:showTargetZoneMenu(2, 'Deploy JTAC', spawnAndOrbit, 1)
	
	trigger.action.outTextForCoalition(2, 'Choose which zone to deploy JTAC at from F10 menu', 15)
end,
function(sender, params)
	if params.zone and params.zone.side == 1 then
		drone:deployAtZone(params.zone)
		drone:showMenu()
		trigger.action.outTextForCoalition(2, 'Predator drone deployed over '..params.zone.zone, 15)
	else
		return 'Can only target enemy zone'
	end
end)


local smoketargets = function(tz)
	local units = {}
	for i,v in pairs(tz.built) do
		local g = Group.getByName(v)
		for i2,v2 in ipairs(g:getUnits()) do
			table.insert(units, v2)
		end
	end
	
	local tgts = {}
	for i=1,3,1 do
		if #units > 0 then
			local selected = math.random(1,#units)
			table.insert(tgts, units[selected])
			table.remove(units, selected)
		end
	end
	
	for i,v in ipairs(tgts) do
		local pos = v:getPosition().p
		trigger.action.smoke(pos, 1)
	end
end

local smokeTargetMenu = nil
bc:registerShopItem('smoke', 'Smoke markers', 20, function(sender)
	if smokeTargetMenu then
		return 'Choose target zone from F10 menu'
	end
	
	local launchAttack = function(target)
		if smokeTargetMenu then
			local tz = bc:getZoneByName(target)
			smoketargets(tz)
			smokeTargetMenu = nil
			trigger.action.outTextForCoalition(2, 'Targets marked with RED smoke at '..target, 15)
		end
	end
	
	smokeTargetMenu = bc:showTargetZoneMenu(2, 'Smoke marker target', launchAttack, 1)
	
	trigger.action.outTextForCoalition(2, 'Choose target zone from F10 menu', 15)
end,
function(sender, params)
	if params.zone and params.zone.side == 1 then
		smoketargets(params.zone)
		trigger.action.outTextForCoalition(2, 'Targets marked with RED smoke at '..params.zone.zone, 15)
	else
		return 'Can only target enemy zone'
	end
end)

local spawnAwacs = function(sender) 
	local gr = Group.getByName('awacs1')
	if Utils.isGroupActive(gr) then 
		return 'Darkstar still active on 252.00 MHz AM'
	end
	mist.respawnGroup('awacs1', true)
	trigger.action.outTextForCoalition(2,'Darkstar active on 252.00 MHz AM',15)
end
Group.getByName('awacs1'):destroy()
bc:registerShopItem('awacs', 'AWACS', 100, spawnAwacs, spawnAwacs)

Group.getByName('ewAircraft'):destroy()
local jamMenu = nil
bc:registerShopItem('jam', 'Jam radars at zone', 500, function(sender)
	local gr = Group.getByName('ewAircraft')
	if Utils.isGroupActive(gr) then 
		return 'Jamming mission still in progress'
	end
	
	mist.respawnGroup('ewAircraft', true)
	
	if jamMenu then
		return 'Choose target zone from F10 menu'
	end
	
	local startJam = function(target)
		if jamMenu then
			bc:jamRadarsAtZone('ewAircraft', target)
			jamMenu = nil
			trigger.action.outTextForCoalition(2, 'Growler jamming radars at '..target, 15)
		end
	end
	
	jamMenu = bc:showTargetZoneMenu(2, 'Jamming target', startJam, 1)
	trigger.action.outTextForCoalition(2, 'Choose target zone from F10 menu', 15)
end,
function(sender, params)
	if params.zone and params.zone.side == 1 then
		local gr = Group.getByName('ewAircraft')
		if Utils.isGroupActive(gr) then 
			return 'Jamming mission still in progress'
		end
		
		mist.respawnGroup('ewAircraft', true)
		
		mist.scheduleFunction(function(target)
			local ew = Group.getByName('ewAircraft')
			if ew then
				local err = bc:jamRadarsAtZone('ewAircraft', target)
				if err then
					return err
				end
				
				trigger.action.outTextForCoalition(2, 'Growler jamming radars at '..target, 15)
			end
		end,{params.zone.zone},timer.getTime()+2)
		
	else
		return 'Can only target enemy zone'
	end
end)

tanksMenu = nil
bc:registerShopItem('armor', 'Deploy armor (for combined arms)', 100, function(sender)
	
	if tanksMenu then
		return 'Choose deploy zone from F10 menu'
	end
	
	local deployTanks = function(target)
		if tanksMenu then
		
			local zn = CustomZone:getByName(target)
			zn:spawnGroup('ca-tanks')
			
			tanksMenu = nil
			trigger.action.outTextForCoalition(2, 'Friendly armor deployed at '..target, 15)
		end
	end
	
	tanksMenu = bc:showTargetZoneMenu(2, 'Deploy armor (Choose friendly zone)', deployTanks, 2)
	trigger.action.outTextForCoalition(2, 'Choose deploy zone from F10 menu', 15)
end,
function(sender, params)
	if params.zone and params.zone.side == 2 then
		
		local zn = CustomZone:getByName(params.zone.zone)
		zn:spawnGroup('ca-tanks')
		trigger.action.outTextForCoalition(2, 'Friendly armor deployed at '..params.zone.zone, 15)
	else
		return 'Can only deploy at friendly zone'
	end
end)

artyMenu = nil
bc:registerShopItem('artillery', 'Deploy artillery (for combined arms)', 100, function(sender)
	
	if artyMenu then
		return 'Choose deploy zone from F10 menu'
	end
	
	local deployArty = function(target)
		if artyMenu then
		
			local zn = CustomZone:getByName(target)
			zn:spawnGroup('ca-arty')
			
			artyMenu = nil
			trigger.action.outTextForCoalition(2, 'Friendly artillery deployed at '..target, 15)
		end
	end
	
	artyMenu = bc:showTargetZoneMenu(2, 'Deploy artillery (Choose friendly zone)', deployArty, 2)
	trigger.action.outTextForCoalition(2, 'Choose deploy zone from F10 menu', 15)
end,
function(sender, params)
	if params.zone and params.zone.side == 2 then
		
		local zn = CustomZone:getByName(params.zone.zone)
		zn:spawnGroup('ca-arty')
		trigger.action.outTextForCoalition(2, 'Friendly artillery deployed at '..params.zone.zone, 15)
	else
		return 'Can only deploy at friendly zone'
	end
end)

reconMenu = nil
bc:registerShopItem('recon', 'Deploy recon group (for combined arms)', 50, function(sender)
	
	if reconMenu then
		return 'Choose deploy zone from F10 menu'
	end
	
	local deployRecon = function(target)
		if reconMenu then
		
			local zn = CustomZone:getByName(target)
			zn:spawnGroup('ca-recon')
			
			reconMenu = nil
			trigger.action.outTextForCoalition(2, 'Friendly recon group deployed at '..target, 15)
		end
	end
	
	reconMenu = bc:showTargetZoneMenu(2, 'Deploy recon group (Choose friendly zone)', deployRecon, 2)
	trigger.action.outTextForCoalition(2, 'Choose deploy zone from F10 menu', 15)
end,
function(sender, params)
	if params.zone and params.zone.side == 2 then
		
		local zn = CustomZone:getByName(params.zone.zone)
		zn:spawnGroup('ca-recon')
		trigger.action.outTextForCoalition(2, 'Friendly recon group deployed at '..params.zone.zone, 15)
	else
		return 'Can only deploy at friendly zone'
	end
end)

airdefMenu = nil
bc:registerShopItem('airdef', 'Deploy air defence (for combined arms)', 150, function(sender)
	
	if airdefMenu then
		return 'Choose deploy zone from F10 menu'
	end
	
	local deployAirDef = function(target)
		if airdefMenu then
		
			local zn = CustomZone:getByName(target)
			zn:spawnGroup('ca-airdef')
			
			airdefMenu = nil
			trigger.action.outTextForCoalition(2, 'Friendly air defence deployed at '..target, 15)
		end
	end
	
	airdefMenu = bc:showTargetZoneMenu(2, 'Deploy air defence (Choose friendly zone)', deployAirDef, 2)
	trigger.action.outTextForCoalition(2, 'Choose deploy zone from F10 menu', 15)
end,
function(sender, params)
	if params.zone and params.zone.side == 2 then
		
		local zn = CustomZone:getByName(params.zone.zone)
		zn:spawnGroup('ca-airdef')
		trigger.action.outTextForCoalition(2, 'Friendly air defence deployed at '..params.zone.zone, 15)
	else
		return 'Can only deploy at friendly zone'
	end
end)

bc:addShopItem(2, 'sead', -1)
bc:addShopItem(2, 'sweep', -1)
bc:addShopItem(2, 'cas', -1)
bc:addShopItem(2, 'cruisemsl', 12)
bc:addShopItem(2, 'supplies', -1)
bc:addShopItem(2, 'jtac', -1)
bc:addShopItem(2, 'smoke', -1)
bc:addShopItem(2, 'jam', -1)
bc:addShopItem(2, 'awacs', -1)

bc:addShopItem(2, 'armor', -1)
bc:addShopItem(2, 'artillery', -1)
bc:addShopItem(2, 'recon', -1)
bc:addShopItem(2, 'airdef', -1)

--red support
Group.getByName('redcas1'):destroy()
bc:registerShopItem('redcas1', 'Red Cas', 1000, function(sender) 
	local gr = Group.getByName('redcas1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return 'still alive'
	end
	mist.respawnGroup('redcas1', true)
	trigger.action.outTextForCoalition(2,'The enemy has deployed a couple of Su-34 against our ground forces',15)
end)

Group.getByName('redcap1'):destroy()
bc:registerShopItem('redcap1', 'Red Cap', 1000, function(sender) 
	local gr = Group.getByName('redcap1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return 'still alive'
	end
	mist.respawnGroup('redcap1', true)
	trigger.action.outTextForCoalition(2,'Enemy MiG-31 interceptors, coming in from the South-East',15)
end)

Group.getByName('redsead1'):destroy()
bc:registerShopItem('redsead1', 'Red Sead', 1000, function(sender) 
	local gr = Group.getByName('redsead1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return 'still alive'
	end
	mist.respawnGroup('redsead1', true)
	trigger.action.outTextForCoalition(2,'The enemy has launched an attack from the North-East on our air defenses',15)
end)

Group.getByName('redmlrs1'):destroy()
bc:registerShopItem('redmlrs1', 'spawn Red mlrs', 1000, function(sender) 
	local zn = bc:getZoneByName('Kandalaksha')
	if zn.side == 1 and zn.active then
		local gr = Group.getByName('redmlrs1')
		if gr then
			local full = true
			for i,v in ipairs(gr:getUnits()) do
				for i2,v2 in ipairs(v:getAmmo()) do
					if v2.count < 3 then
						full = false
						break
					end
				end
				
				if not full then 
					break
				end
			end
			
			if full and gr:getSize()==gr:getInitialSize() then
				return 'ammo full'
			end
			
			trigger.action.outTextForCoalition(2,'The enemy has resupplied its artillery near Kandalaksha',15)
		end
		
		mist.respawnGroup('redmlrs1')
		bc:removeShopItem(1,'redmlrs1fire')
		bc:addShopItem(1, 'redmlrs1fire', 3)
	else
		return 'zone not red'
	end
end)

bc:registerShopItem('redmlrs1fire', 'fire red mlrs', 200, function(sender) 
	local gr = Group.getByName('redmlrs1')
	if gr then
		local targetzones = {'Kirkenes FARP', 'Narvik', 'Old SA-2 Site', 'Monchegorsk Factory', 'Radar Site', 'Murmansk'}
		local viabletargets = {}
		for i,v in ipairs(targetzones) do
			local z = bc:getZoneByName(v)
			
			if z and z.side == 2 then
				table.insert(viabletargets, v)
			end
		end

		if #viabletargets==0 then
			return 'no targets'
		end
		
		local targetzn = viabletargets[math.random(1,#viabletargets)]
		
		local err = bc:fireAtZone(targetzn, 'redmlrs1', true, 3, 6)
		
		if not err then
			trigger.action.outTextForCoalition(2,'Enemy artillery near Kandalaksha has begun preparations to fire on '..targetzn,15)
		else
			return err
		end
	else
		return 'buy first'
	end
end)


Group.getByName('intercept1'):destroy()
Group.getByName('intercept2'):destroy()
local cargoDieEvent = nil
bc:registerShopItem('intercept1', 'Red intercept', 1000, function(sender) 
	local grt = Group.getByName('intercept1')
	local gre = Group.getByName('intercept2')
	if gre and gre:getSize()>0 and gre:getController():hasTask() then 
		return 'still alive'
	end
	
	if grt and grt:getSize()>0 and grt:getController():hasTask() then 
		return 'still alive'
	end
	
	mist.respawnGroup('intercept1', true)
	mist.respawnGroup('intercept2', true)
	
	if not cargoDieEvent then
		local cargoPlaneDied = function(event)
			if event.id==28 then
				if event.initiator and event.initiator:getCoalition()==2 and event.target and event.target.getName then
					if event.target:getName()=='intercept1' then
						trigger.action.outTextForCoalition(2,'Enemy cargo transport destroyed.\n+500 credits',15)
						bc:addFunds(2,500)
						mist.removeEventHandler(cargoDieEvent)
						cargoDieEvent = nil
					elseif not Unit.getByName('intercept1') then
						mist.removeEventHandler(cargoDieEvent)
						cargoDieEvent = nil
					end
				end
			end
		end
		
		cargoDieEvent = mist.addEventHandler(cargoPlaneDied)
	end
end)

Group.getByName('escort1'):destroy()
Group.getByName('antiescort1'):destroy()
Group.getByName('antiescort2'):destroy()
bc:registerShopItem('escort1', 'Red antiescort', 1000, function(sender) 
	local gr = Group.getByName('escort1')
	if gr and gr:getSize()>0 and gr:getController():hasTask() then 
		return 'still alive'
	end
	
	mist.respawnGroup('escort1', true)
	
	local spawnIntercept = function(groupname)
		if Group.getByName('escort1') then
			local g = Group.getByName(groupname)
			if not g then
				if math.random(1,100) > 30 then
					if math.random(1,100) > 50 then
						trigger.action.outTextForCoalition(2,'Enemy interceptor spotted heading for our cargo transport.',15)
					else
						trigger.action.outTextForCoalition(2,'The enemy has launched an intercept mission against our cargo transport',15)
					end
					mist.respawnGroup(groupname, true)
				end
			end
		end
	end
	
	local timers = {math.random(3*60,15*60), math.random(8*60,15*60)}
	mist.scheduleFunction(spawnIntercept, {'antiescort1'}, timer.getTime()+timers[1])
	mist.scheduleFunction(spawnIntercept, {'antiescort2'}, timer.getTime()+timers[2])
end)

krymskForce = {
	'krymsk-force-1',
	'krymsk-force-2',
	'krymsk-force-3',
	'krymsk-gforce-1',
	'krymsk-gforce-2',
	'krymsk-gforce-3',
	'krymsk-tforce-1',
	'krymsk-aforce-1',
	'krymsk-aforce-2',
	'krymsk-aforce-3',
}

for _,v in ipairs(krymskForce) do Group.getByName(v):destroy() end

bc:registerShopItem('krymskForce', 'Murmansk Assault', 1000, function(sender) 
	for _,v in ipairs(krymskForce) do
		local gr = Group.getByName(v)
		if gr and gr:getSize()>0 and gr:getController():hasTask() then 
			return 'still alive'
		end
	end
	
	if bc:getZoneByName('Kirkenes FARP').side==1 and bc:getZoneByName('Murmansk').side==2 then
		for _,v in ipairs(krymskForce) do
			mist.respawnGroup('krymsk-force-1', true)
			mist.respawnGroup('krymsk-force-2', true)
			mist.respawnGroup('krymsk-force-3', true)
			
			if bc:getZoneByName('Narvik').side==1 then
				mist.respawnGroup('krymsk-tforce-1', true)
			end
			
			mist.respawnGroup('krymsk-aforce-1', true)
			mist.respawnGroup('krymsk-aforce-2', true)
			mist.respawnGroup('krymsk-aforce-3', true)
		end
	else
		return 'zone no match'
	end
end)

bc:addShopItem(1, 'redcas1', -1)
bc:addShopItem(1, 'redcap1', -1)
bc:addShopItem(1, 'redsead1', -1)
bc:addShopItem(1, 'redmlrs1', -1)
bc:addShopItem(1, 'intercept1', -1)
bc:addShopItem(1, 'escort1', -1)
bc:addShopItem(1, 'krymskForce', -1)

budgetAI = BudgetCommander:new({ battleCommander = bc, side=1, decissionFrequency=20*60, decissionVariance=10*60, skipChance = 10})
budgetAI:init()
--end red support

lc = LogisticCommander:new({battleCommander = bc, supplyZones = {'Bodø', 'Murmansk', 'Monchegorsk Factory', 'Alta FARP', 'Kirkenes FARP', 'Carrier Group'}})
lc:init()


bc:loadFromDisk() --will load and overwrite default zone levels, sides, funds and available shop items
bc:init()
bc:startRewardPlayerContribution(15,{infantry = 5, ground = 15, sam = 30, airplane = 30, ship = 200, helicopter=40, crate=100, rescue = 50})

HercCargoDropSupply.init(bc)

mc = MissionCommander:new({side = 2, battleCommander = bc, checkFrequency = 60})

mc:trackMission({
	title = "Escort",
	description = "Friendly cargo transport has entered the airspace from the south. Protect it from the enemy.",
	messageStart = "New mission: Escort",
	messageEnd = "Mission ended: Escort",
	startAction = function() trigger.action.outSoundForCoalition(2,"ding.ogg") end,
	endAction = function() 
		trigger.action.outSoundForCoalition(2,"cancel.ogg")
	end,
	isActive = function()
		if Group.getByName('escort1') then return true end
		
		return false
	end
})

mc:trackMission({
	title = "Intercept",
	description = "Enemy cargo transport has entered the airspace from the south. Intercept and destroy it before it escapes.",
	messageStart = "New mission: Intercept",
	messageEnd = "Mission ended: Intercept",
	startAction = function() trigger.action.outSoundForCoalition(2,"ding.ogg") end,
	endAction = function() 
		trigger.action.outSoundForCoalition(2,"cancel.ogg")
	end,
	isActive = function()
		if Group.getByName('intercept1') then return true end
		
		return false
	end
})

mc:trackMission({
	title = "Destroy artillery",
	description = "The enemy has deployed artillery near Kandalaksha. Destroy it before it has a chance to fire",
	messageStart = "New mission: Destroy artillery",
	messageEnd = "Mission ended: Destroy artillery",
	startAction = function() trigger.action.outSoundForCoalition(2,"ding.ogg") end,
	endAction = function() 
		trigger.action.outSoundForCoalition(2,"cancel.ogg")
	end,
	isActive = function()
		if Group.getByName('redmlrs1') then return true end
		
		return false
	end
})

mc:trackMission({
	title = "Defend Murmansk",
	description = "The enemy has launched an all out attack on Murmansk.\nDefend the airfield at all cost.",
	messageStart = "New mission: Defend Murmansk",
	messageEnd = "Mission ended: Defend Murmansk",
	startAction = function() trigger.action.outSoundForCoalition(2,"ding.ogg") end,
	endAction = function() 
		trigger.action.outSoundForCoalition(2,"cancel.ogg")
	end,
	isActive = function()
		for _,v in ipairs(krymskForce) do
			local gr = Group.getByName(v)
			if gr and gr:getSize()>0 and gr:getController():hasTask() then 
				return true
			end
		end
		
		return false
	end
})



resupplyTarget = nil
mc:trackMission({
	title = function() return "Resupply "..resupplyTarget end,
	description = function() return "Deliver supplies to "..resupplyTarget end,
	messageStart = function() return "New mission: Resupply "..resupplyTarget end,
	messageEnd = function() return "Mission ended: Resupply "..resupplyTarget end,
	startAction = function() trigger.action.outSoundForCoalition(2,"ding.ogg") end,
	endAction = function() 
		resupplyTarget = nil
		trigger.action.outSoundForCoalition(2,"cancel.ogg")
	end,
	isActive = function()
		if not resupplyTarget then return false end
		
		local targetzn = bc:getZoneByName(resupplyTarget)
		return targetzn:canRecieveSupply()
	end
})

attackTarget = nil
mc:trackMission({
	title = function() return "Attack "..attackTarget end,
	description = function() return "Destroy enemy forces at "..attackTarget end,
	messageStart = function() return "New mission: Attack "..attackTarget end,
	messageEnd = function() return "Mission ended: Attack "..attackTarget end,
	startAction = function() trigger.action.outSoundForCoalition(2,"ding.ogg") end,
	endAction = function() 
		attackTarget = nil 
		trigger.action.outSoundForCoalition(2,"cancel.ogg")
	end,
	isActive = function()
		if not attackTarget then return false end
		
		local targetzn = bc:getZoneByName(attackTarget)
		return targetzn.side == 1
	end
})

captureTarget = nil
mc:trackMission({
	title = function() return "Capture "..captureTarget end,
	description = function() return captureTarget.." is neutral. Capture it by delivering supplies" end,
	messageStart = function() return "New mission: Capture "..captureTarget end,
	messageEnd = function() return "Mission ended: Capture "..captureTarget end,
	startAction = function() trigger.action.outSoundForCoalition(2,"ding.ogg") end,
	endAction = function() 
		captureTarget = nil 
		trigger.action.outSoundForCoalition(2,"cancel.ogg")
	end,
	isActive = function()
		if not captureTarget then return false end
		
		local targetzn = bc:getZoneByName(captureTarget)
		return targetzn.side == 0 and targetzn.active
	end
})

function generateCaptureMission()
	if captureTarget ~= nil then return end
		
	local validzones = {}
	for _,v in ipairs(bc.zones) do
		if v.side == 0 and v.active then
			table.insert(validzones, v.zone)
		end
	end
	
	if #validzones == 0 then return end
	
	local choice = math.random(1, #validzones)
	if validzones[choice] then
		captureTarget = validzones[choice]
		return true
	end
end

function generateAttackMission()
	if attackTarget ~= nil then return end
		
	local validzones = {}
	for _,v in ipairs(bc.connections) do
		local to = bc:getZoneByName(v.to)
		local from = bc:getZoneByName(v.from)
		
		if from.side ~= to.side and from.side ~= 0  and to.side ~= 0 and from.active and to.active then
			if from.side == 1 then
				table.insert(validzones, from.zone)
			elseif to.side == 1 then
				table.insert(validzones, to.zone)
			end
		end
	end
	
	if #validzones == 0 then return end
	
	local choice = math.random(1, #validzones)
	if validzones[choice] then
		attackTarget = validzones[choice]
		return true
	end
end

function generateSupplyMission()
	if resupplyTarget ~= nil then return end
		
	local validzones = {}
	for _,v in ipairs(bc.zones) do
		if v.side == 2 and v:canRecieveSupply() then
			table.insert(validzones, v.zone)
		end
	end
	
	if #validzones == 0 then return end
	
	local choice = math.random(1, #validzones)
	if validzones[choice] then
		resupplyTarget = validzones[choice]
		return true
	end
end

timer.scheduleFunction(function(_, time)
	if generateCaptureMission() then
		return time+300
	else
		return time+120
	end
end, {}, timer.getTime() + 20)

timer.scheduleFunction(function(_, time)
	if generateAttackMission() then
		return time+300
	else
		return time+120
	end
end, {}, timer.getTime() + 40)

timer.scheduleFunction(function(_, time)
	if generateSupplyMission() then
		return time+300
	else
		return time+120
	end
end, {}, timer.getTime() + 60)

mc:init()

function respawnStatics()
	for i,v in pairs(cargoSpawns) do
		local farp = bc:getZoneByName(i)
		if farp then
			if farp.side==2 then
				for ix,vx in ipairs(v) do
					if not StaticObject.getByName(vx) then
						mist.respawnGroup(vx)
					end
				end
			else
				for ix,vx in ipairs(v) do
					local cr = StaticObject.getByName(vx)
					if cr then
						cr:destroy()
					end
				end
			end
		end
	end
	
	for i,v in pairs(farpSupply) do
		local farp = bc:getZoneByName(i)
		if farp then
			if farp.side==2 then
				for ix,vx in ipairs(v) do
					local gr = Group.getByName(vx)
					if not gr then
						mist.respawnGroup(vx)
					elseif gr:getSize() < gr:getInitialSize() then
						mist.respawnGroup(vx)
					end
				end
			else
				for ix,vx in ipairs(v) do
					local cr = Group.getByName(vx)
					if cr then
						cr:destroy()
					end
				end
			end
		end
	end
end

mist.scheduleFunction(respawnStatics, {}, timer.getTime() + 1, 30)
