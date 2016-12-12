note
	description: "Summary description for {FIND_BEST_WAY}."
	author: "Kamil"
	date: "$Date$"
	revision: "$Revision$"

class
	FIND_BEST_WAY
create
	make
feature--initialization
	make
	--	retrieve  needed info to start	
	do
		--take values from console
--		create read.make
--		x_goal:=read.xgoal
--		y_goal:=read.ygoal
--		z_goal:=0.0
--		inflate_big:=read.radius
--		x_start:=read.xstart
--		y_start:=read.ystart
--		z_start:=0.0
--		strategy:=read.strategy

		--creating graph
		create nodes.make(inflate_big,strategy)
		min_x:=nodes.min_x
		min_y:=nodes.min_y
		resolution:=nodes.resolution

		--start Astar
		create a_star.make(x_start,y_start,z_start,x_goal,y_goal,z_goal,min_x,min_y,min_z,resolution)
		a_star.do_star(nodes.g)

		--show optimal path in rvitz
		create rviz_path_draw.make
		rviz_path_draw.display_path (a_star.display)

	end

feature
	--date about start, goal and need objects

--	read:READ_FROM_CONSOLE
	i:INTEGER_32
	nodes: NODES
	is_end:BOOLEAN
	a_star: ASTAR
	strategy:INTEGER=26 -- 6 or 26 neighbours
	rviz_path_draw:RVIZ_PATH

	x_goal:REAL_64=0.48
	y_goal:REAL_64=1.57
	z_goal:REAL_64=0.0
	inflate_big:REAL_64=0.1


	x_start:REAL_64=0.5
	y_start:REAL_64=0.5
	z_start:REAL_64=0.0
	min_x,min_y,min_z,resolution:REAL_64

end
