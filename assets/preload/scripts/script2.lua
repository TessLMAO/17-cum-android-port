--script by marshverso




local characters = {
  character = {},
  strum = {},
  nota = {},
  holdCap = {},
  holdTimers = {},
  offsetX = {},
  offsetY = {},
  finished = {}
  }

local cache = 0
local cache1 = 0
local loadCode = (load)

--NEW FUNCTIONS--
---------------------------------------------------------
function addCharacter(tag, imagem, camada, x, y)
  makeAnimatedLuaSprite(tag, imagem, x, y)
  addLuaSprite(tag, camada)
  characters.character[cache+1] = tag
  characters.holdTimers[cache+1] = -1
  characters.finished[cache+1] = true
  cache = cache + 1
end

function addXml(tag, name, xml, frames, loop)
  addAnimationByPrefix(tag, name, xml, frames, loop)
end

function noteCharacter(opponent, note)
  characters.strum[cache1+1] = opponent
  characters.nota[cache1+1] = note
  cache1 = cache1 + 1
end
---------------------------------------------------------



function onCountdownTick(swagCounter) --start
  if swagCounter == 2 then
    for i=1,#characters.character do
      playAnim(characters.character[i], 'idle', true)
    end
  elseif swagCounter == 4 then
    for i=1,#characters.character do
      playAnim(characters.character[i], 'idle', true)
    end
  end
end

function onUpdate(elapsed)
  for i=1,#characters.character do
    characters.holdCap[i] = stepCrochet * 0.004
    if characters.holdTimers[i] >= 0 then
      characters.holdTimers[i] = characters.holdTimers[i] + elapsed
      if characters.holdTimers[i] >= characters.holdCap[i] then
        characters.holdTimers[i] = -1
        if altAnim then
          playAnim(characters.character[i], 'idle-alt', true)
        else
          playAnim(characters.character[i], 'idle', true)
        end
      end
    end
  end
end

function onBeatHit()
  if curBeat % 2 == 0 then
    for i=1,#characters.character do
      if characters.holdTimers[i] == -1 and characters.finished[i] == true then
        if altAnim then
          playAnim(characters.character[i], 'idle-alt', true)
        else
          playAnim(characters.character[i], 'idle', true)
        end
      end
    end
  end

  if curBeat % 4 == 0 then
    for i=1,#characters.character do
      if characters.holdTimers[i] == -1 and characters.finished[i] == false then
        if altAnim then
          playAnim(characters.character[i], 'idle-alt', true)
        else
          playAnim(characters.character[i], 'idle', true)
        end

        characters.finished[i] = true
      end
    end
  end
end

function goodNoteHit(membersIndex, noteData, noteType)
  for i=1,#characters.character do
    if noteType == characters.nota[i] and characters.strum[i] == true then
      if altAnim then
        playAnim(characters.character[i], noteData..'-alt', true)
      else
        playAnim(characters.character[i], noteData, true)
      end

      characters.holdTimers[i] = 0
      characters.finished[i] = false
    end
  end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
  for i=1,#characters.character do
    if noteType == characters.nota[i] and characters.strum[i] == false then
      if altAnim then
        playAnim(characters.character[i], noteData..'-alt', true)
        characters.holdTimers[i] = 0
      else
        playAnim(characters.character[i], noteData, true)
        characters.holdTimers[i] = 0
      end

      characters.finished[i] = false
    end
  end
end

function onEndSong()
  for i=1,#characters.character do
    if altAnim then
      playAnim(characters.character[i], 'idle-alt', true)
    else
      playAnim(characters.character[i], 'idle', true)
    end
  end
end

function onCreate()
  --[[if tonumber(string.sub(version, 1, 3)) > 0.6 then
    function addOffset(obj, anim, x, y)
      setProperty(obj..'.offset.x', x)
      setProperty(obj..'.offset.y', y)
    end
  end]]

  loadCode(getTextFromFile('data/'..songName..'/characters.txt'))()
end