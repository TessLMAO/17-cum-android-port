local zoom = 0
local beat = 0

function onCreate()
  if cameraZoomOnBeat == false then
    close(true)
  end
end

function onEvent(eventName, value1, value2)
  debugPrint('')
  if eventName == 'BeatForever' then
    
    if tonumber(value1) == nil then
      zoom = 0
    else
      zoom = tonumber(value1)
    end

    if tonumber(value2) == nil then
      beat = 0
    else
      beat = tonumber(value2)
    end
  end
end

function onBeatHit()
  if zoom > 0 and beat == 0 then
    triggerEvent('Add Camera Zoom', zoom, nil)
  elseif zoom > 0 and curBeat % beat == 0 then
    triggerEvent('Add Camera Zoom', zoom, nil)
  end
end