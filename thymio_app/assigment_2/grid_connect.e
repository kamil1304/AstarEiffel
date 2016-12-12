note
	description: "Summary description for {GRID_CONNECT}."
	author: "Kamil"
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_CONNECT_6
	inherit
		GRID_CONNECTIVITY_STRATEGY
create
	make
feature
	make
	do
	end
feature-- create neighbours of node, in this case one spatian node can have 6 neighbours

	connect(g: separate GRID_GRAPH)
	local
		i,j,k:INTEGER
	do
		i:=1
		j:=1
		k:=1
		from until not  g.is_valid_index (i,j,k) loop
			from until  not g.is_valid_index (i,j,k) loop
				from until not  g.is_valid_index (i,j,k) loop
					connect_node(g, i, j,k, i+1,j,k)
					connect_node(g, i, j,k, i-1,j,k)
					connect_node(g, i, j,k, i,j,k+1)
					connect_node(g, i, j,k, i,j,k-1)
					connect_node(g, i, j,k, i,j+1,k)
					connect_node(g, i, j,k, i,j-1,k)
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
