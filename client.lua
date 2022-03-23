local yarnlock        = 'base'
local StickyNoteProp  = "prop_notepad_01"
local WritingProp     = "prop_pencil_01"
local AnimDict        = 'missheistdockssetup1clipboard@base'
local OpenStickyNote  = false
local CloseStickyNote = false

-- Events
RegisterNetEvent("qpstickynote:client:ShowStickyNote", function(text, slot)
  if not OpenStickyNote then
   SendNUIMessage({action = "open", uitext = text, slot = slot})
   OpenStickyNote  = true
   CloseStickyNote = true
   CloseStickyNoteLoop(AnimDict, yarnlock)
   SetNuiFocus(true, true)
  end
end)

function CloseStickyNoteLoop(bleu, animation)

  loadAnimDict(bleu)
  local ped = PlayerPedId()
  local AnimationCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(ped), 0.0, 0.0, -5.0)
  local notepad   = CreateObject(GetHashKey(StickyNoteProp), AnimationCoords.x, AnimationCoords.y, AnimationCoords.z, 1, 1, 1)
  local rainydays = ObjToNet(notepad)
  TaskPlayAnim(ped, bleu, animation, 5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)
  AttachEntityToEntity(notepad,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 18905),0.1, 0.02, 0.05, 10.0, 0.0, 0.0,1,1,0,1,0,1)
  maryslittlelamb = rainydays
	
  local pen  = CreateObject(GetHashKey(WritingProp), AnimationCoords.x, AnimationCoords.y, AnimationCoords.z, 1, 1, 1)
  local cock = ObjToNet(pen)
  TaskPlayAnim(ped, bleu, animation, 5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)
  AttachEntityToEntity(pen,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 58866),0.11, -0.02, 0.001, -120.0, 0.0, 0.0,1,1,0,1,0,1)
  pen_net = cock
-- End of events

-- Functions	
Citizen.CreateThread(function()
  while (CloseStickyNote) do
   Wait(0)
			
  if IsControlJustReleased(0, 38) then
  SendNUIMessage({action = "close"})
  CloseStickyNote = false
  OpenStickyNote  = false
  ClearPedTasks(ped)
  SetNuiFocus(false, false)
    break
 end
			
  if not OpenStickyNote then
  CloseStickyNote = false
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
   CloseStickyNote = false
   OpenStickyNote  = false
   ClearPedTasks(ped)
   SetNuiFocus(false, false)
end)

RegisterNUICallback('hennessy', function (data, cb)
   local ped = PlayerPedId()
   CloseStickyNote = false
   OpenStickyNote  = false
   DetachEntity(NetToObj(maryslittlelamb), 1, 1)
   DeleteEntity(NetToObj(maryslittlelamb))
   DetachEntity(NetToObj(pen_net), 1, 1)
   DeleteEntity(NetToObj(pen_net))
   ClearPedTasks(ped)
   SetNuiFocus(false, false)
   local text = data.text
   local slot = data.slot
   TriggerServerEvent('qpr:server:StickyNoteWordChange', text, slot)
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
