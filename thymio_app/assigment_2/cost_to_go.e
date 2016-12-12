note
	description: "Summary description for {COST_TO_GO}."
	author: "Kamil"
	date: "$Date$"
	revision: "$Revision$"

class
	COST_TO_GO
create
make
feature	--load values of start

	make(start_node: SPATIAL_GRAPH_NODE)
	do
		start:=start_node
	end

feature--calculate  cost  between  two nodes

	cost (a,b: separate SPATIAL_GRAPH_NODE): REAL_64
		do
			Result:=1.5*a.distance (b)
		end
feature--value of start
	start:SPATIAL_GRAPH_NODE

end
