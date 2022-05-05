// Emu (c) 2020 @dragonitespam
// See the Github wiki for documentation: https://github.com/DragoniteSpam/Documentation/wiki/Emu
function EmuButtonImageHorse(x, y, w, h, race_type, horse_position, blend, alpha, scale_to_fit, callback) : EmuButtonImage(x, y, w, h, noone, 0, blend, alpha, scale_to_fit, callback) constructor {
    self.race_type = race_type;
    self.horse_position = horse_position;
    self.horse = noone;
    self.statsButton = false;
    
    self.Render = function(base_x, base_y) {
        self.gc.Clean();
        self.update_script();
        self.processAdvancement();
        
        var horse = self.horse;
        
        if (!statsButton && horse == noone) {
           horse = oUmaTeamTracker.team_in_memory[self.race_type][self.horse_position];
        }
        
        var x1 = x + base_x;
        var y1 = y + base_y;
        var x2 = x1 + self.width;
        var y2 = y1 + self.height;
        
        #region draw the image to the surface
        self.surface = self.surfaceVerify(self.surface, self.width, self.height + 30).surface;
        
        surface_set_target(self.surface);
        draw_clear_alpha(c_black, 0);
        var back_color = self.getMouseHover(x1, y1, x2, y2) ? self.color_hover() : (self.GetInteractive() ? self.color_back() : self.color_disabled());
        draw_sprite_stretched_ext(sprite_nineslice, 1, 0, 0, self.width, self.height, back_color, 1);
        if (sprite_exists(umaheadshots)) {
            if (self.checker_background) self.drawCheckerbox(0, 0, self.width - 1, self.height - 1);
            var scale = self.allow_shrink ?
                (self.fill ? min(self.width / sprite_get_width(umaheadshots), self.height / sprite_get_height(umaheadshots)) : 1) :
                (self.fill ? min(max(self.width / sprite_get_width(umaheadshots), 1), max(self.height / sprite_get_height(umaheadshots), 1)) : 1);
            
            if (horse != noone) {
              var _ind = horse.base.sprInd;
              draw_sprite_ext(umaheadshots, _ind, width / 2, height / 2, scale, scale, 0, blend, alpha);
              scribble("Total: " + string(horse.total))
                  .wrap(self.width, self.height)
                  .starting_format(EMU_DEFAULT_FONT, c_white)
                  .align(self.align.h, self.align.v)
                  .draw(self.width div 2, self.height + 15);
            }
        }
        surface_reset_target();
        #endregion
        
        if (self.getMouseHover(x1, y1, x2, y2)) {
            self.ShowTooltip();
        }
        
        if (self.getMouseReleased(x1, y1, x2, y2)) {
            self.Activate();
            self.callback();
        }
        
        
        draw_surface_ext(self.surface, x1, y1, 1, 1, 0, c_white, 1);
        draw_sprite_stretched_ext(sprite_nineslice, 0, x1, y1, x2 - x1, y2 - y1, self.color(), 1);
    };
}