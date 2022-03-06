/// @description  draw_circle_diagram(x, y, r_from, r_to, quality, variable, variable, ...)
/// @param x
/// @param  y
/// @param  r_from
/// @param  r_to
/// @param  quality
/// @param  variable
/// @param  variable
/// @param  ...
function draw_circle_diagram() {
	var X=argument[0],Y=argument[1],r=argument[2], R=argument[3], q=7,v,count=argument_count-5,c,summ=0,index=0,midsumm;
	c[0]=c_red; c[1]=c_yellow; c[2]=c_blue; c[3]=c_green; c[4]=c_lime; c[5]=c_orange; c[6]=c_maroon; c[7]=c_silver; c[8]=c_fuchsia; c[9]=c_purple; c[10]=c_teal; c[11]=c_navy; c[12]=c_olive
	for (i=4; i<argument_count; i+=1)
	{
	    v_min[index]=(argument[i])
	    summ+=v_min[index]
	    v_min[index]=summ-v_min[index]
	    index++
	};
	var ind=index
	index=0

	for (i=0; i<360; i+=min(20/max(q,0.1),360-i))
	{
	    for (j=0; j<ind; j+=1)
	    {
	        if i/360>v_min[j]/summ {index=j}
	    }
	    draw_primitive_begin(pr_trianglestrip)
	    draw_vertex_colour(X+lengthdir_x(r,i),Y+lengthdir_y(r,i),c[index],1)
	    draw_vertex_colour(X+lengthdir_x(R,i),Y+lengthdir_y(R,i),c[index],1)
	    draw_vertex_colour(X+lengthdir_x(r,i+20/max(q,0.1)),Y+lengthdir_y(r,i+20/max(q,0.1)),c[index],1)
	    draw_vertex_colour(X+lengthdir_x(R,i+20/max(q,0.1)),Y+lengthdir_y(R,i+20/max(q,0.1)),c[index],1)
	    draw_primitive_end()
	};



}
