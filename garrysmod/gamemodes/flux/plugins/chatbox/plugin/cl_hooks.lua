function Chatbox:OnResolutionChanged(new_width, new_height)
  theme.set_option('chatbox_width', new_width / 2.25)
  theme.set_option('chatbox_height', new_height / 2.25)
  theme.set_option('chatbox_x', font.scale(8))
  theme.set_option('chatbox_y', new_height - theme.get_option('chatbox_height') - font.scale(32))

  if chatbox.panel then
    chatbox.panel:Remove()
    chatbox.panel = nil
  end
end

function Chatbox:PlayerBindPress(player, bind, pressed)
  if fl.client:has_initialized() and (string.find(bind, 'messagemode') or string.find(bind, 'messagemode2')) and pressed then
    if string.find(bind, 'messagemode2') then
      fl.client.typing_team_chat = true
    else
      fl.client.typing_team_chat = false
    end

    chatbox.show()

    return true
  end
end

function Chatbox:GUIMousePressed(mouseCode, aim_vector)
  if IsValid(chatbox.panel) then
    chatbox.hide()
  end
end

function Chatbox:HUDShouldDraw(element)
  if element == 'CHudChat' then
    return false
  end
end

function Chatbox:CreateFonts()
  font.create('flChatFont', {
    font = 'Arial',
    size = 16,
    weight = 1000
  })
end

function Chatbox:OnThemeLoaded(current_theme)
  local scrw, scrh = ScrW(), ScrH()

  current_theme:set_font('chatbox_normal', 'flChatFont', font.scale(20))
  current_theme:set_font('chatbox_bold', 'flRobotoCondensedBold', font.scale(20))
  current_theme:set_font('chatbox_italic', 'flRobotoCondensedItalic', font.scale(20))
  current_theme:set_font('chatbox_italic_bold', 'flRobotoCondensedItalicBold', font.scale(20))
  current_theme:set_font('chatbox_syntax', 'flRobotoCondensed', font.scale(24))

  current_theme:set_option('chatbox_width', scrw / 2.25)
  current_theme:set_option('chatbox_height', scrh / 2.25)
  current_theme:set_option('chatbox_x', font.scale(8))
  current_theme:set_option('chatbox_y', scrh - current_theme:get_option('chatbox_height') - font.scale(32))
end

function Chatbox:ChatboxTextEntered(text)
  if text and text != '' then
    cable.send('fl_chat_player_say', text)
  end

  chatbox.hide()
end

cable.receive('fl_chat_message_add', function(message_data)
  if !IsValid(chatbox.panel) then
    chatbox.create()
  end

  chatbox.panel:add_message(message_data)

  chat.PlaySound()
end)
