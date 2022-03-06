/// @description  draw_graph_grid_text(x, y, width, height, variable, variable, ...)
/// @param x
/// @param  y
/// @param  width
/// @param  height
/// @param  variable
/// @param  variable
/// @param  ...
function draw_graph_grid_text() {
	var table=0, X=argument[0], Y=argument[1], w=argument[2], h=argument[3], index=0;
	c[0]=c_red; c[1]=c_yellow; c[2]=c_blue; c[3]=c_green; c[4]=c_lime; c[5]=c_orange; c[6]=c_maroon; c[7]=c_silver; c[8]=c_fuchsia; c[9]=c_purple; c[10]=c_teal; c[11]=c_navy; c[12]=c_olive
	for (i=4; i<argument_count; i+=1)
	{
	    table[index]=argument[i]
	    index++
	};
	var count=argument_count-4;
	maks=0
	for (i=0; i<count; i+=1)
	{
	    if table[i]>maks {maks=table[i]}
	}

	var table_w=(w)/count-4
	for (i=0; i<count; i+=1)
	{
	    draw_rectangle_colour(X+i*(table_w+4),Y+h-table[i]/maks*h,X+i*(table_w+4)+table_w,Y+h,c[i],c[i],c[i],c[i],0)
	}
	var txt="";
	draw_set_halign(fa_right)
	draw_set_valign(fa_middle)
	for (i=0; i<h+1; i+=40)
	{
	    draw_line_colour(X,Y+h-i,X+w,Y+h-i,0,0)
	    if maks<10 {txt=i/h*maks} else {txt=floor(i/h*maks)}
	    draw_text(X-5,Y+h-i,string_hash_to_newline(string(txt)))
	}

	draw_set_valign(fa_top)
	draw_set_halign(fa_center)
	for (i=0; i<count; i+=1)
	{
	    draw_text_colour(X+i*(table_w+4)+table_w/2,Y+h-table[i]/maks*h+5,string_hash_to_newline(string(table[i])),-c[i],-c[i],-c[i],-c[i],1)
	}



}
