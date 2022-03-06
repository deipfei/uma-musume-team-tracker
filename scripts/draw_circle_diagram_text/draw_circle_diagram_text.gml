/// @description  draw_circle_diagram_text(x, y, r_from, r_to, quality, variable, color, variable, color, ...)
/// @param x
/// @param  y
/// @param  r_from
/// @param  r_to
/// @param  quality
/// @param  variable
/// @param  color
/// @param  variable
/// @param  color
/// @param  ...
function draw_circle_diagram_text() {
	var X=argument[0],Y=argument[1],r=argument[2], R=argument[3], q=argument[4],v,count=argument_count-5,summ=0,index=0,midsumm;
	for (i=5; i<argument_count; i+=2)
	{
	    v_min[index]=(argument[i])
	    v[index]=v_min[index]
	    c[index]=argument[i+1]
	    summ+=v_min[index]
	    v_min[index]=summ-v_min[index]    
	    index++
	};
	v_min[index]=summ
	var ind=index
	index=0

	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)

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

	for (i=0; i<ind; i+=1)
	{
	    draw_text_colour(X+lengthdir_x(R+35,(v_min[i]+v_min[i+1])/2/summ*360),Y+lengthdir_y(R+35,(v_min[i]+v_min[i+1])/2/summ*360),string_hash_to_newline(string(v[i])),c[i],c[i],c[i],c[i],1)
	}



}
