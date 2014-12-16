collection @lines

attributes :id, :name, :time 

node(:position){
	|line| [{x: line.point_a_x, y: line.point_a_y}, {x: line.point_b_x, y: line.point_b_y}]
}

