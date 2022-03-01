// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EmuInput_Result(x, y, w, h, text, value, help_text, character_limit, input, race_type, horse_position, callback): EmuInput(x, y, w, h, text, value, help_text, character_limit, input, callback) constructor{
  self.race_type = race_type;
  self.horse_position = horse_position;
  
  processAdvancement = function() {
      if (!self.isActiveElement()) return false;
      if ((!self._override_tab && keyboard_check_pressed(vk_tab)) || keyboard_check_pressed(vk_enter)) {
          if (keyboard_check(vk_shift) && self._previous) {
              self._previous.Activate();
              keyboard_clear(vk_tab);
              keyboard_clear(vk_enter);
              keyboard_string = "";
              return true;
          }
          if (self._next) {
              self._next.Activate();
              keyboard_clear(vk_tab);
              keyboard_clear(vk_enter);
              keyboard_string = "";
              return true;
          }
      }
  }
}