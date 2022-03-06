/// @description  draw_graph_ext(x, y, width, height, variable, color, variable, color, ...)
/// @param x
/// @param  y
/// @param  width
/// @param  height
/// @param  variable
/// @param  color
/// @param  variable
/// @param  color
/// @param  ...
function draw_graph_ext() {
	var table=0, X=argument[0], Y=argument[1], w=argument[2], h=argument[3], index=0, count,c;
	for (i=4; i<argument_count; i+=2)
	{
	    table[index]=argument[i]
	    c[index]=argument[i+1]
	    index++
	};
	var count=index;
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




}
