note
	description: "Summary description for {UP_HEAP_COST}."
	author: "Kamil"
	date: "$Date$"
	revision: "$Revision$"

class
	UP_HEAP_COST
create
	make, make_point
feature  --two posiibilities of inicilization


	make(x,y,z,cost, cost_g,p_x,p_y,p_z,p_cost,p_g:REAL_64)
		--initialize using  separate  coordinates
	do
		--current node's features
		cur_x:=x
		cur_y:=y
		cur_z:=z
		cur_cost:=cost
		cur_g:=cost_g
		create cur_point.make_with_values (cur_x,cur_y,cur_z)

		--parrent node's features
		parent_x:=p_x
		parent_y:=p_y
		parent_z:=p_z
		parent_cost:=p_cost
		parent_g:=p_g
		create parent_point.make_with_values (parent_x, parent_y, parent_z)
	end

	make_point(curr,parent:POINT_MSG; curr_cost, cost_g,par_cost, p_g:REAL_64)
		--initialize using points
	do
		--current node's features
		cur_x:=curr.x
		cur_y:=curr.y
		cur_z:=curr.z
		cur_cost:=curr_cost
		cur_g:=cost_g
		create cur_point.make_with_values (cur_x,cur_y,cur_z)

		--parrent node's features
		parent_x:=parent.x
		parent_y:=parent.y
		parent_z:=parent.z
		parent_cost:=par_cost
		parent_g:=p_g
		create parent_point.make_with_values (parent_x, parent_y, parent_z)

	end



feature	--feature which characterize current node

	cur_x, cur_y, cur_z, cur_cost, cur_g:REAL_64
	parent_x, parent_y, parent_z, parent_cost, parent_g:REAL_64
	cur_point:POINT_MSG
	parent_point:POINT_MSG

feature	--methods enables  fullfil or change node's features

	change_curr(chan:POINT_MSG)
	--change  current features
	do
		cur_x:=chan.x
		cur_y:=chan.y
		cur_z:=chan.z
		create cur_point.make_with_values (cur_x,cur_y,cur_z)
	end

	add_parent(temp: like current)
	--add parent's information
	do
		parent_x:=temp.cur_x
		parent_y:=temp.cur_y
		parent_z:=temp.cur_z
		parent_cost:=temp.cur_cost
		create parent_point.make_with_values (parent_x, parent_y, parent_z)
	end

	change_parent(temp: like current)
	--change parent's features
	do
		parent_x:=temp.parent_x
		parent_y:=temp.parent_y
		parent_z:=temp.parent_z
		parent_cost:=temp.parent_cost
		parent_g:=temp.parent_g
		create parent_point.make_with_values (parent_x, parent_y, parent_z)
	end

	add_cost( all_cost:REAL_64)
	--add  current cost
	do
		cur_cost:=all_cost
	end

	add_cost_g( g:REAL_64)
	--add g_cost
	do
		cur_g:=g
	end

end
