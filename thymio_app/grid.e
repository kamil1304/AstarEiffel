note
	description: "Summary description for {GRID}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRID
create
	make
feature

	make

		do
		--	create deff.make_empty
		--	create maps_meta.make_from_pointer ("nav_msgs/OccupancyGrid")
			create signal_map.make_with_topic("/map")
			create show.make_empty
			take_value
			print("iside make %N")
		end

feature

--deff: OCCUPANCY_GRID_MSG
--maps_meta: OCCUPANCY_GRID_MSG`
signal_map: OCCUPANCY_GRID_SIGNALER
show:MARKER_MSG
a:REAL_64






take_value
	do
	print("hey hey hey %N")
--	a:=	signal_map.
	a:=signal_map.state.info.height
--	print(a.out+"%N")
print( a.out+"%N")


--marker message
	print(" Im inside %N")
	end
	--nav_msgs/Path

	set_see
	local
		pose: POSE_MSG
		scale:VECTOR_3D_MSG
		color:COLOR_RGBA_MSG
		id, type, action: INTEGER_32
		lifetime: REAL_64
		give_see:MARKER_MSG
		header: HEADER_MSG
	do
		create pose.make_with_values (create {POINT_MSG}.make_with_values (1,1,1), create {QUATERNION_MSG}.make_with_values(0,0,0,0))
		create scale.make_with_values(1,1,1)
		create color.make_with_values (1.0,0.0,0.0, 1.0)
		create header.make_now ("/visualization_marker")
		id:=1
		type:=1
		action:=0
		lifetime:=30


		create give_see.make_with_values (header,pose,scale,
		 color, "a_namespace", "a_text", id,type, action, lifetime)
	end

	show_path
		local
			path: PATH_MSG
			poses_array: ARRAY [POSE_STAMPED_MSG]
			header: HEADER_MSG
			pose: POSE_MSG
			pose2: POSE_MSG

			pose_stamped: POSE_STAMPED_MSG
			pose_stamped2: POSE_STAMPED_MSG
			publisher: ROS_PUBLISHER[PATH_MSG]
		do

			create header.make_now ("/map")
			create pose.make_with_values (create {POINT_MSG}.make_with_values (1,1,1), create {QUATERNION_MSG}.make_with_values(0,0,0,0))
			create pose2.make_with_values (create {POINT_MSG}.make_with_values (2,2,1), create {QUATERNION_MSG}.make_with_values(0,0,0,0))


			create pose_stamped.make_with_values (header, pose)
			create pose_stamped2.make_with_values (header, pose2)
			create poses_array.make_filled (pose_stamped,1,2)

			poses_array[2]:=pose_stamped2

--------------skopiowane
			create path.make_with_values (header, poses_array)
			create publisher.make_with_topic ("/path")



			publisher.advertize (12, True)
			publisher.publish (path)



		end


end
