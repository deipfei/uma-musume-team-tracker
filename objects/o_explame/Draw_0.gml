draw_circle_diagram_ext(500,500,190,200,q,  100, c_white,   200, c_red,   300, c_yellow)
draw_circle_diagram_text(200,200,0,100,q,  50, c_white,   50, c_red,   150, c_yellow)
draw_graph_grid_text(750,30,550,650,  312,1549,165,10, 100, 100, 100, 100, 100, 100, 100, 100, 100)
draw_graph_text(50,400,200,300,  0.5,0.2,0.4,0.1)

if mouse_check_button(mb_left) {q+=0.1} 
if mouse_check_button(mb_right) {q-=0.1} 

