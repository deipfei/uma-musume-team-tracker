/// @description  draw_graph_text(x, y, width, height, variable, variable, ...)
/// @param x
/// @param  y
/// @param  width
/// @param  height
/// @param  variable
/// @param  variable
/// @param  ...
function draw_graph_text(X, Y, w, h, values) {
  if (!is_array(values)) return;
  
  var c = [c_red, c_yellow, c_blue, c_green, c_lime, c_orange, c_maroon, c_silver, c_fuchsia, c_purple, c_teal, c_navy, c_olive, c_aqua];
  var num_color_last_index = 12;
  
	var _max = 0;
  var _len = min(num_color_last_index, array_length(values));
  
	for (var i = 0; i < _len; i++) {
	  if (values[i] > _max) {
      _max = values[i]
    }
	}

	var table_w = (w) / _len;
  var old_valign = draw_get_valign();
  var old_halign = draw_get_halign();
	for (var i = 0; i < _len; i++) {
	    draw_rectangle_colour(
        X + i * (table_w + 4),
        Y + h - values[i] / _max * h,
        X + i * (table_w + 4) + table_w,
        Y + h,
        c[i], c[i], c[i], c[i], false);
	    draw_set_valign(fa_top);
	    draw_set_halign(fa_center);
	    draw_text_colour(
        X + i * (table_w+4) + table_w / 2,
        Y + h - values[i] / _max * h + 5,
        string(values[i]),
        c[12 - i], c[12 - i], c[12 - i], c[12 - i], 1)
	}

draw_set_valign(old_valign);
draw_set_halign(old_halign);

}
