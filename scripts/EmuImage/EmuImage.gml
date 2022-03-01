// Emu (c) 2020 @dragonitespam
// See the Github wiki for documentation: https://github.com/DragoniteSpam/Documentation/wiki/Emu
function EmuImage(x, y, w, h, sprite, index, blend, alpha, scale_to_fit): EmuCallback(x, y, w, h, 0, function() {}) constructor {
    self.sprite = sprite;
    self.blend = blend;
    self.alpha = alpha;
    self.fill = scale_to_fit;
    self.allow_shrink = true;
    
    self.color_back = EMU_COLOR_BACK;
    
    self.alignment = fa_center;
    self.valignment = fa_middle;
    
    self._surface = noone;
    self._index = index;
    
    self.image_obj = noone;
    
    Render = function(base_x, base_y) {
        processAdvancement();
        
        var x1 = x + base_x;
        var y1 = y + base_y;
        var x2 = x1 + width;
        var y2 = y1 + height;
        
        #region draw the image to the _surface
        if (surface_exists(_surface) && (surface_get_width(_surface) != width || surface_get_height(_surface) != height)) {
            surface_free(_surface);
        }
        
        if (!surface_exists(_surface)) {
            _surface = surface_create(width, height);
        }
        
        surface_set_target(_surface);
        draw_clear_alpha(c_black, 0);
        
        if (image_obj != noone && sprite_exists(image_obj.sprite)) {
            if (allow_shrink) {
                var scale = fill ? min(width / sprite_get_width(image_obj.sprite), height / sprite_get_height(image_obj.sprite)) : 1;
            } else {
                var scale = fill ? min(max(width / sprite_get_width(image_obj.sprite), 1), max(height / sprite_get_height(image_obj.sprite), 1)) : 1;
            }
            draw_sprite_ext(image_obj.sprite, image_obj._index, width / 2, height / 2, scale, scale, 0, blend, alpha);
        }
        surface_reset_target();
        #endregion
        
        if (getMouseHover(x1, y1, x2, y2)) {
            ShowTooltip();
        }
        
        draw_surface_ext(_surface, x1, y1, 1, 1, 0, color_back, 1);
    }
    
    Destroy = function() {
        if (surface_exists(_surface)) surface_free(_surface);
        destroyContent();
    }
}