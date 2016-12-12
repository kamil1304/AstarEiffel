note
	description: "Summary description for {NODES}."
	author: "Kamil"
	date: "$Date$"
	revision: "$Revision$"

class
	NODES

create
	make

feature {NONE}-- Initialization

	make(inflate_size:REAL_64; neighbours:INTEGER)
		--retive info about map and create graph
		do
			inflate:=inflate_size
			is_end:=false
			create signal_map1.make_with_topic("/map")

			from until is_end
			loop
				take_values(signal_map1)
			end

			create conn_strategy6.make
			create conn_strategy26.make

			if neighbours=6 then
				create g.make_2d (width, height, min_x, max_x, min_y, max_y, conn_strategy6)
			else
				create g.make_2d (width, height, min_x, max_x, min_y, max_y, conn_strategy26)
			end

			make_graph(signal_map1)

		end

feature--graph information and object need to create it well

	conn_strategy26: GRID_CONNECT_26
	conn_strategy6: GRID_CONNECT_6
	g:  GRID_GRAPH
	signal_map1: separate OCCUPANCY_GRID_SIGNALER
	width, height: INTEGER_32
	min_x, max_x, min_y, max_y, ori_x, ori_y,resolution: REAL_64
	is_end:BOOLEAN
	inflate:REAL_64


feature--Preparing graph

	take_values(signal_map: separate OCCUPANCY_GRID_SIGNALER)
		--get information abou map
	do
		if signal_map.state.info.width/=0.0 OR  signal_map.state.info.height/=0.0  then

			width:=signal_map.state.info.width.as_integer_32
			height:=signal_map.state.info.height.as_integer_32
			ori_x:=signal_map.state.info.origin.position.x
			ori_y:=signal_map.state.info.origin.position.y
			resolution:=signal_map.state.info.resolution
			min_x:=ori_x+0.5*resolution
			max_x:= ori_x+width*resolution-0.5*resolution
			min_y:=ori_y+0.5*resolution
			max_y:= ori_y +height*resolution-0.5*resolution
			is_end:=true
		end
	end

	make_graph(signal_map: separate OCCUPANCY_GRID_SIGNALER)
		local
		i,j,k:INTEGER
		--add obstacles to  map-> remove nodes which are obstacles
	do
		signal_map.inflate (inflate)
		i:=1
		j:=1
		k:=1
		from until not  g.is_valid_index (i,j,k) loop
			from until  not g.is_valid_index (i,j,k) loop
				from until not  g.is_valid_index (i,j,k) loop

					if signal_map.occupancy (i,j) >= signal_map.occupancy_threshold then
						g.add_obstacle_by_index (i,j,k)
					end
						i:=i+1
					end
				j:=j+1
				i:=1
			end
			k:=k+1
			j:=1
			i:=1
		end
	end

end
