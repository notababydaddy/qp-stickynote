local yarnlock        = 'base'
local noteProp        = "prop_notepad_01"
local writingProp     = "prop_pencil_01"
local AnimDict        = 'missheistdockssetup1clipboard@base'
local openNote        = false
local closeNote       = false

-- Events
RegisterNetEvent("qpstickynote:client:showNote", function(text, slot)
  if not openNote then
   SendNUIMessage({action = "open", uitext = text, slot = slot})
   openNote  = true
   closeNote = true
   closeNoteLoop(AnimDict, yarnlock)
   SetNuiFocus(true, true)
  end
end)

function closeNoteLoop(bleu, animation)

  loadAnimDict(bleu)
  local ped             = PlayerPedId()
  local animCoords      = GetOffsetFromEntityInWorldCoords(GetPlayerPed(ped), 0.0, 0.0, -5.0)
  local notepad         = CreateObject(GetHashKey(noteProp), animCoords.x, animCoords.y, animCoords.z, 1, 1, 1)
  local rainydays       = ObjToNet(notepad)
  TaskPlayAnim(ped, bleu, animation, 5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)
  AttachEntityToEntity(notepad,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 18905),0.1, 0.02, 0.05, 10.0, 0.0, 0.0,1,1,0,1,0,1)
  maryslittlelamb = rainydays
	
  local pen  = CreateObject(GetHashKey(writingProp), animCoords.x, animCoords.y, animCoords.z, 1, 1, 1)
  local cock = ObjToNet(pen)
  TaskPlayAnim(ped, bleu, animation, 5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)
  AttachEntityToEntity(pen,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 58866),0.11, -0.02, 0.001, -120.0, 0.0, 0.0,1,1,0,1,0,1)
  pen_net = cock
-- End of events

-- Functions	
Citizen.CreateThread(function()
  while (closeNote) do
   Wait(0)
			
  if IsControlJustReleased(0, 38) then
  SendNUIMessage({action = "close"})
  closeNote = false
  openNote  = false
  ClearPedTasks(ped)
  SetNuiFocus(false, false)
    break
 end
			
  if not openNote then
  closeNote = false
    break
 end
			
  if (not IsEntityPlayingAnim(PlayerPedId(), bleu, animation, 3)) then
      playAnim(bleu, animation)
     end
    end
  end)
end

RegisterNUICallback('balltorture', function (data, cb)
   local ped = PlayerPedId()
   closeNote = false
   openNote  = false
   ClearPedTasks(ped)
   SetNuiFocus(false, false)
end)

RegisterNUICallback('hennessy', function (data, cb)
   local ped = PlayerPedId()
   closeNote = false
   openNote  = false
   DetachEntity(NetToObj(maryslittlelamb), 1, 1)
   DeleteEntity(NetToObj(maryslittlelamb))
   DetachEntity(NetToObj(pen_net), 1, 1)
   DeleteEntity(NetToObj(pen_net))
   ClearPedTasks(ped)
   SetNuiFocus(false, false)
   local text = data.text
   local slot = data.slot
   TriggerServerEvent('qpr:server:textUpdate', text, slot)
end)

function playAnim(bleu, animation)
   TaskPlayAnim(GetPlayerPed(-1),bleu,animation,5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)
end

function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
    RequestAnimDict(dict)
     Citizen.Wait(0)
   end
end
-- End of functions
