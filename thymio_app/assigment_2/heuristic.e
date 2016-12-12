note
	description: "Summary description for {HEURISTIC}."
	author: "Kamil"
	date: "$Date$"
	revision: "$Revision$"

class
	HEURISTIC
	inherit
	TRIGONOMETRY_MATH
create
make
feature--load value of goal
	make( goal_node: SPATIAL_GRAPH_NODE)
	do
		goal:=goal_node
	end

feature--calculate value of heuristic cost

	cost (a:separate SPATIAL_GRAPH_NODE): REAL_64
		do
			Result:=euclidean_distance(a.position, goal.position)
		end
feature--goal value
	goal:SPATIAL_GRAPH_NODE
end

