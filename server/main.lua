--[[
_________ _______________  ___ ________                       
\_   ___ \\_   _____/\   \/  / \______ \   _______  __________
/    \  \/ |    __)   \     /   |    |  \_/ __ \  \/ /\___   /
\     \____|     \    /     \   |    `   \  ___/\   /  /    / 
 \______  /\___  /   /___/\  \ /_______  /\___  >\_/  /_____ \
        \/     \/          \_/         \/     \/            \/
    Discord: Aizen#9186
    CFX Devz: https://discord.gg/dMMmr82S23
    KK: https://discord.gg/MT2996y
    Antichix: https://discord.gg/NmFcvCs
]]

ESX=nil;TriggerEvent('esx:getSharedObject',function(a)ESX=a end)local b={}RegisterServerEvent("cfx_vehicletuning:server:setupVehicleStatus")AddEventHandler("cfx_vehicletuning:server:setupVehicleStatus",function(c,d,e)print('^3SETTING UP VEHICLE STATUS^0')local f=source;local d=d~=nil and d or 1000.0;local e=e~=nil and e or 1000.0;if b[c]==nil then MySQL.Async.fetchAll('SELECT plate FROM owned_vehicles WHERE plate = @plate',{['@plate']=c},function(g)if g[1]~=nil then MySQL.Async.fetchAll("SELECT `status` FROM `owned_vehicles` WHERE `plate` = @plate",{['@plate']=c},function(g)if g[1]~=nil then local h=g[1].status~=nil and json.decode(g[1].status)or nil;if h==nil then print('^1STATUS INFO NIL SET UP FULL MAINTENANE^0')h={["engine"]=d,["body"]=e,["radiator"]=Config.MaxStatusValues["radiator"],["axle"]=Config.MaxStatusValues["axle"],["brakes"]=Config.MaxStatusValues["brakes"],["clutch"]=Config.MaxStatusValues["clutch"],["fuel"]=Config.MaxStatusValues["fuel"]}end;b[c]=h;TriggerClientEvent("cfx_vehicletuning:client:setVehicleStatus",-1,c,h)print('^2STATUS INFO FULLY CONFIGURED MAINTENANE^0')end end)else print('^1VEHICLE NOT OWNED MAX MAINTENANCE CONFIGURED^0')local h={["engine"]=d,["body"]=e,["radiator"]=Config.MaxStatusValues["radiator"],["axle"]=Config.MaxStatusValues["axle"],["brakes"]=Config.MaxStatusValues["brakes"],["clutch"]=Config.MaxStatusValues["clutch"],["fuel"]=Config.MaxStatusValues["fuel"]}b[c]=h;TriggerClientEvent("cfx_vehicletuning:client:setVehicleStatus",-1,c,h)end end)else TriggerClientEvent("cfx_vehicletuning:client:setVehicleStatus",-1,c,b[c])end end)RegisterServerEvent("cfx_vehicletuning:server:updatePart")AddEventHandler("cfx_vehicletuning:server:updatePart",function(c,i,j)if b[c]~=nil then if i=="engine"or i=="body"then b[c][i]=j;if b[c][i]<0 then b[c][i]=0 elseif b[c][i]>1000 then b[c][i]=1000.0 end else b[c][i]=j;if b[c][i]<0 then b[c][i]=0 elseif b[c][i]>100 then b[c][i]=100 end end;TriggerClientEvent("cfx_vehicletuning:client:setVehicleStatus",-1,c,b[c])end end)RegisterServerEvent('cfx_vehicletuning:server:SetPartLevel')AddEventHandler('cfx_vehicletuning:server:SetPartLevel',function(c,i,j)if b[c]~=nil then b[c][i]=j;TriggerClientEvent("cfx_vehicletuning:client:setVehicleStatus",-1,c,b[c])end end)RegisterServerEvent("cfx_vehicletuning:server:fixEverything")AddEventHandler("cfx_vehicletuning:server:fixEverything",function(c)if b[c]~=nil then for k,l in pairs(Config.MaxStatusValues)do b[c][k]=l end;TriggerClientEvent("cfx_vehicletuning:client:setVehicleStatus",-1,c,b[c])end end)RegisterServerEvent("cfx_vehicletuning:server:saveStatus")AddEventHandler("cfx_vehicletuning:server:saveStatus",function(c)if b[c]~=nil then MySQL.Async.execute('UPDATE owned_vehicles SET status = @status WHERE plate = @plate',{['@status']=json.encode(b[c]),['@plate']=c},nil)print('^2VEHILCE STATUS SAVED PLATE: '..c..'^0')end end)RegisterCommand('vehstatus',function(source,m,n)TriggerClientEvent("cfx_vehicletuning:client:getVehicleStatus",source)end)ESX.RegisterServerCallback('cfx_vehicletuning:server:GetStatus',function(source,o,c)if b[c]~=nil and next(b[c])~=nil then o(b[c])else o(nil)end end)RegisterServerEvent("cfx_vehicletuning:server:removeItem")AddEventHandler("cfx_vehicletuning:server:removeItem",function(p,q)local f=source;local r=ESX.GetPlayerFromId(f)r.removeInventoryItem(p,q)end)RegisterServerEvent("cfx_vehicletuning:server:giveItem")AddEventHandler("cfx_vehicletuning:server:giveItem",function(p,q)local f=source;local r=ESX.GetPlayerFromId(f)r.addInventoryItem(p,q)end)RegisterServerEvent("cfx_vehicletuning:server:givePlayerDirtyMoney")AddEventHandler("cfx_vehicletuning:server:givePlayerDirtyMoney",function(q)local f=source;local r=ESX.GetPlayerFromId(f)r.addAccountMoney('black_money',q)end)