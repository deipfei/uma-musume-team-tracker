// Emu (c) 2020 @dragonitespam
// See the Github wiki for documentation: https://github.com/DragoniteSpam/Documentation/wiki/Emu
function EmuButtonImageHorse(x, y, w, h, race_type, horse_position, blend, alpha, scale_to_fit, callback) : EmuButtonImage(x, y, w, h, noone, 0, blend, alpha, scale_to_fit, callback) constructor {
    self.race_type = race_type;
    self.horse_position = horse_position;
    self.horse = noone;
    self.statsButton = false;
    
    Render = function(base_x, base_y) {
        processAdvancement();
        var horse = self.horse;
        
        if (!statsButton && horse == noone) {
           horse = oUmaTeamTracker.team_in_memory[self.race_type][self.horse_position];
        }
        
        var x1 = x + base_x;
        var y1 = y + base_y;
        var x2 = x1 + width;
        var y2 = y1 + height;
        
        #region draw the image to the _surface
        if (surface_exists(_surface) && (surface_get_width(_surface) != width || surface_get_height(_surface) != height)) {
            surface_free(_surface);
        }
        
        if (!surface_exists(_surface)) {
            _surface = surface_create(width, height + 30);
        }
        
        surface_set_target(_surface);
        draw_clear_alpha(c_black, 0);
        draw_sprite_stretched_ext(sprite_nineslice, 1, 0, 0, width, height, color_back, 1);
        if (sprite_exists(umaheadshots)) {
            if (checker_background) drawCheckerbox(0, 0, width - 1, height - 1);
            if (allow_shrink) {
                var scale = fill ? min(width / sprite_get_width(umaheadshots), height / sprite_get_height(umaheadshots)) : 1;
            } else {
                var scale = fill ? min(max(width / sprite_get_width(umaheadshots), 1), max(height / sprite_get_height(umaheadshots), 1)) : 1;
            }
            if (horse != noone) {
              var _ind = horse.base.sprInd;
              draw_sprite_ext(umaheadshots, _ind, width / 2, height / 2, scale, scale, 0, blend, alpha);
              scribble_set_box_align(alignment, valignment);
              scribble_set_wrap(width, height);
              scribble_draw(width div 2, height + 15, "Total: " + string(horse.total));
            }
        }
        
        
        surface_reset_target();
        #endregion
        
        if (getMouseHover(x1, y1, x2, y2)) {
            ShowTooltip();
        }
        
        if (getMouseReleased(x1, y1, x2, y2)) {
            Activate();
            callback();
        }
        
        var back_color = getMouseHover(x1, y1, x2, y2) ? color_hover : (GetInteractive() ? color_back : color_disabled);
        draw_surface_ext(_surface, x1, y1, 1, 1, 0, back_color, 1);
        draw_sprite_stretched_ext(sprite_nineslice, 0, x1, y1, x2 - x1, y2 - y1, color, 1);
    }
}