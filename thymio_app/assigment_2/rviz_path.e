note
	description: "Summary description for {RVIZ_PATH}."
	author: "Kamil"
	date: "$Date$"
	revision: "$Revision$"

class
	RVIZ_PATH
	INHERIT
	ROS_ENVIRONMENT
create
	make
feature
	make
	do
	end

feature -- enables to send  path to rviz

display_path(points:ARRAY[POINT_MSG])
local
	path: PATH_MSG
	poses_array: ARRAY [POSE_STAMPED_MSG]
	header: HEADER_MSG
	pose:POSE_MSG
	pose_stamped: POSE_STAMPED_MSG
	points_long,i: INTEGER_32
	quaterions: QUATERNION_MSG
	publisher: ROS_PUBLISHER[PATH_MSG]

	do
		points_long:=points.count
		create header.make_now ("/map")
		create quaterions.make_with_values(0,0,0,0)
		create pose.make_with_values (points[0], quaterions)
		create pose_stamped.make_with_values (header, pose)
		create poses_array.make_filled (pose_stamped,0,points_long-1)
		create path.make_with_values (header, poses_array)
		create publisher.make_with_topic ("/path")

		i:=1
		from 	until i>points_long-1
		loop
			poses_array[i]:=create {POSE_STAMPED_MSG}.make_with_values(header,create {POSE_MSG}.make_with_values (points[i], quaterions))
			i:=i+1
		end

		publisher.advertize (12, True)
		publisher.publish (path)
	end

end
