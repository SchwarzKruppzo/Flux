PLUGIN:set_name('Color Modify')
PLUGIN:set_author('TeslaCloud Studios')
PLUGIN:set_description('Provides a color modify API.')

do
  local default_color_mod = {
    ['$pp_colour_addr'] = 0,
    ['$pp_colour_addg'] = 0,
    ['$pp_colour_addb'] = 0,
    ['$pp_colour_brightness'] = 0,
    ['$pp_colour_contrast'] = 1,
    ['$pp_colour_colour'] = 1,
    ['$pp_colour_mulr'] = 0,
    ['$pp_colour_mulg'] = 0,
    ['$pp_colour_mulb'] = 0
  }

  function fl.color_mod_enabled(enable)
    if !fl.client.color_mod_table then
      fl.client.color_mod_table = default_color_mod
    end

    if enable then
      fl.client.color_mod = true
      return true
    end

    fl.client.color_mod = false
  end

  function enable_color_mod()
    return fl.color_mod_enabled(true)
  end

  function fl.disable_color_mod()
    return fl.color_mod_enabled(false)
  end

  function fl.set_color_mod(index, value)
    if !fl.client.color_mod_table then
      fl.client.color_mod_table = default_color_mod
    end

    if isstring(index) then
      if !index:starts('$pp_colour_') then
        if index == 'color' then index = 'colour' end

        fl.client.color_mod_table['$pp_colour_'..index] = (isnumber(value) and value) or 0
      else
        fl.client.color_mod_table[index] = (isnumber(value) and value) or 0
      end
    end
  end

  function fl.set_color_mod_table(tab)
    if istable(tab) then
      fl.client.color_mod_table = tab
    end
  end
end

function PLUGIN:RenderScreenspaceEffects()
  if fl.client.color_mod then
    DrawColorModify(fl.client.color_mod_table)
  end
end
