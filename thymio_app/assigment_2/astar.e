
note
	description: "Summary description for {ASTAR}."
	author: "Kamil"
	date: "$Date$"
	revision: "$Revision$"

class
	ASTAR
create
	make
feature--initialization
	make(x_start, y_start, z_start,x_goal, y_goal, z_goal,min_x,min_y,min_z,resolution:REAL_64)
	do
		--initalization of start and goal as SPATIAL_GRAPH_NODE
		create start.make_with_coords (create {POINT_MSG}.make_with_values (x_start, y_start, z_start))
		create goal.make_with_coords (create {POINT_MSG}.make_with_values (x_goal, y_goal, z_goal))
		create h_cost.make(goal)
		create g_cost.make(start)

		-- variables needed to calculate node's coordinates
		min_x_map:=min_x
		min_y_map:=min_y
		min_z_map:=min_z
		resolution_map:=resolution

		--initalization of start and deff object  as UP_HEAP_COST
		create default_value.make (x_start, y_start, z_start, max_value.max_value,0,0,0,0,0,0)
		create start_h.make(x_start, y_start, z_start,h_cost.cost(start),0,x_start, y_start, z_start,0,0)

		--initialization of open_set
		create open_set_h.make_empty
				open_set_h.force (default_value, 0)
			  	open_set_h.force (start_h, 1)

		--initialization of close_set
		create close_set_h.make_empty
			   close_set_h.force (start_h, 0)
		       close_set_h.force (start_h, 1)

		-- initialization of optimal path
		create path.make_empty
		create display.make_empty

	end
feature
	--Used array of different types of nodes
	open_set_h:ARRAY[UP_HEAP_COST]
	close_set_h:ARRAY[UP_HEAP_COST]
	path:ARRAY[UP_HEAP_COST]
	display:ARRAY[POINT_MSG]

	--used objects
	start_h, default_value:UP_HEAP_COST
	start:SPATIAL_GRAPH_NODE
	goal:SPATIAL_GRAPH_NODE
	h_cost: HEURISTIC
	g_cost: COST_TO_GO
	position_of_repeat,	global_iter:INTEGER
	min_x_map,min_y_map, min_z_map, resolution_map:REAL_64
	total_cost:REAL_64
	max_value:INTEGER_16

feature--Astar algorithm

	do_star(grid_graph: GRID_GRAPH)
	local
		curr_cost, temp_cost:REAL_64
		i,j,k:INTEGER
		neighbor, next:UP_HEAP_COST
		neigh_of_curr,current_n: SPATIAL_GRAPH_NODE
		get_me_out, stop:BOOLEAN
		--mian function which  implements Astar algorithm
	do


		create next.make (0,0,0,0,0,0,0,0,0,0)
		create neigh_of_curr.make_with_coords (create {POINT_MSG}.make_with_values (1,1,1))
		create current_n.make_with_coords (create {POINT_MSG}.make_with_values (1,1,1))


		if grid_graph.node_at( conv_x_to_node(goal.position.x),conv_x_to_node(goal.position.y),conv_x_to_node(goal.position.z)).neighbours.count/=0  then

			from until  open_set_h.is_empty OR  is_goal_visited OR get_me_out
			loop

				bubble_sort(open_set_h)
				k:=k+1
			print( "inside loop: "+k.out+" %N")

				--get a node with the lowest expected cost
				create next.make_point (open_set_h[open_set_h.upper].cur_point, open_set_h[open_set_h.upper].parent_point,  open_set_h[open_set_h.upper].cur_cost,  open_set_h[open_set_h.upper].cur_g,  open_set_h[open_set_h.upper].parent_cost, open_set_h[open_set_h.upper].parent_g)
		--	print( "heuristic cost: "+(next.cur_cost-next.cur_g).out+"%N")
				open_set_h.remove_tail (1)
				close_set_h.force (next, close_set_h.upper+1)

				if are_two_points_the_smae (next.cur_point, goal.position) then

					--if the node is at goal, build the path
					get_me_out:=True
					path.force (next, 0)
					total_cost:=next.cur_cost
					i:=1

					--creating path
					from until are_two_points_the_smae (next.cur_point, start.position)
					loop
						j:=0
						stop:=False
						from 	until  j>close_set_h.count OR stop
						loop
							if are_two_points_the_smae (close_set_h[j].cur_point,next.parent_point) then

								next:=close_set_h[j]
								stop:=True
							end
							j:=j+1
						end
						path.force (next, i)
						i:=i+1
					end
				else

					--if the node is not at goa, updtae its neighbor's expected cost
					current_n:=grid_graph.node_at (conv_x_to_node(next.cur_x),conv_y_to_node(next.cur_y), conv_z_to_node(next.cur_z))
					i:= current_n.neighbours.count
					j:=1
					from until j>i
					loop
						--go through all neighboring nodes of the node
						neigh_of_curr:=current_n.neighbours[j]
						create neighbor.make_point (neigh_of_curr.position, next.cur_point,0,0,next.cur_cost,next.cur_g)

						if  not is_in_array (close_set_h,neighbor)   then

							if not is_in_array (open_set_h,neighbor)then

								--if node is not in open_set- add him with computating cost and its parent
								neighbor.add_cost (h_cost.cost (neigh_of_curr)+neighbor.parent_g+g_cost.cost (current_n,neigh_of_curr))
								neighbor.add_cost_g (neighbor.parent_g+g_cost.cost (current_n,neigh_of_curr))
								open_set_h.force (neighbor,open_set_h.upper+1)

							else

								--if node is in open set, check if it is possible to  get lower expecte cost, if yes, then change its cost and parents
								curr_cost:=	open_set_h[position_of_repeat].cur_cost
								neighbor.add_cost (h_cost.cost (neigh_of_curr)+neighbor.parent_g+g_cost.cost (current_n,neigh_of_curr))
								temp_cost:=neighbor.cur_cost
								neighbor.add_cost_g (neighbor.parent_g+g_cost.cost (current_n,neigh_of_curr))

								if temp_cost<curr_cost then
									open_set_h[position_of_repeat].change_parent (neighbor)
									open_set_h[position_of_repeat].add_cost (temp_cost)
									open_set_h[position_of_repeat].add_cost_g (neighbor.cur_g)
								end

							end
						end
						j:=j+1
					end

				end
			end

			i:=0

			--converting  the path to type ARRAY[POINT_MSG]		
			from	until i> path.count-1

			loop
				display.force (path[i].cur_point, i)
				print( display.item (i).x.out+" "+display.item (i).y.out+" numer "+i.out+" %N ")
				i:=i+1
			end

			print( goal.position.x.out+" "+goal.position.y.out+ " GOAL %N")
			print ( start.position.x.out+"  "+start.position.y.out+" START %N")


			--dispay info if there is  no possibility to reach point
			if open_set_h.is_empty  then
				Print ("Unreachable point, cannot find path %N")
			end

		else

			--it is displayed when goal is in obstacle
			Print( "This is unreachable point %N")
		end
	end

feature--functions used in Astar


	is_goal_visited:BOOLEAN
		local
			i:INTEGER
			a:BOOLEAN
			--check if  goal was visited
		do
			i:=0
			a:=False
				from 	until   i>close_set_h.count-1
				loop

					if	conv_x_to_node (close_set_h[i].cur_x)=conv_x_to_node(goal.position.x) AND
						conv_x_to_node (close_set_h[i].cur_y)=conv_x_to_node(goal.position.y) AND
						conv_x_to_node (close_set_h[i].cur_z)=conv_x_to_node(goal.position.z) then
						a:=True
					end

					i:=i+1
				end

			Result:=a
		end

	is_in_array(array:ARRAY[UP_HEAP_COST]; temp:UP_HEAP_COST):BOOLEAN
	local
		i:INTEGER
		a:BOOLEAN
		--chech if  given point is in  given array by node
	do
		i:=0
		a:=False
			from 	until   i>array.count-1 or a
			loop
				if  are_two_points_the_smae (array[i].cur_point,temp.cur_point) then
					a:=True
					position_of_repeat:=i
				end
				i:=i+1
			end
		Result:=a
	end

	conv_x_to_node(x:REAL_64):INTEGER
		--find a node by its coordinates-x value
		do
			Result:=((x-min_x_map)/resolution_map+1).ceiling
		end

	conv_y_to_node(y:REAL_64):INTEGER
		--find a node by its coordinates-y value
		do
			Result:=((y-min_y_map)/resolution_map+1).ceiling
		end

	conv_z_to_node(z:REAL_64):INTEGER
		--find a node by its coordinates-z value
		do
			Result:=((z-min_z_map)/resolution_map+1).ceiling
		end

	are_two_points_the_smae (p1,p2:POINT_MSG):BOOLEAN
	--check if two point on th map can be written as common node
	do
		if	conv_x_to_node (p1.x)=conv_x_to_node(p2.x) AND
			conv_x_to_node (p1.y)=conv_x_to_node(p2.y) AND
			conv_x_to_node (p1.z)=conv_x_to_node(p2.z) then
			Result:=True
		else
			Result:=False
		end
	end

	bubble_sort(array:ARRAY[UP_HEAP_COST])
		local
			n,i:INTEGER
			temp:UP_HEAP_COST
			--bubble sorting of elements in an  array
		do
			create temp.make (0,0,0,0,0,0,0,0,0,0)
			n:=array.count
			from until n<1
			loop
				i:=0
				from until i>=n-1
				loop
					if array[i].cur_cost< array[i+1].cur_cost then

						array.force (array[i], array.upper+1)
						array.force (array[i+1],i)
						array.force (array[array.upper],i+1)
						array.remove_tail (1)
					end
				i:=i+1
				end
			n:=n-1
			end
		end
end
