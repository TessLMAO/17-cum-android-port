local c

function onCreatePost()
  c = getProperty('defaultCamZoom')
end

function onEvent(eventName, value1)
  if eventName == 'troca_zoom' then
    if value1 == nil then
      setProperty('defaultCamZoom', cache)
    else
      setProperty('defaultCamZoom', tonumber(value1))
    end
  end
end