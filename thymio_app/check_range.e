note
	description: "Summary description for {CHECK_RANGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHECK_RANGE
create
	make
feature

	make
	do
		create range_sensors.make ({THYMIO_TOPICS}.prox_horizontal)
		create timer.make(10000)
	     something
	end

feature

range_sensors: separate THYMIO_RANGE_GROUP
timer: TIMER

feature

	something
	do
		timer.start
		from
		until timer.is_completed
		loop

		separate range_sensors as b do
		print("Range_1: "+	b.sensors[1].range.out+" %N")
		print("field of view_1: "+b.sensors[1].field_of_view.out+" %N")

		print("Range_2: "+	b.sensors[2].range.out+" %N")
		print("field of view_2: "+b.sensors[2].field_of_view.out+" %N")

		print("Range_3: "+	b.sensors[3].range.out+" %N")
		print("field of view_3: "+b.sensors[3].field_of_view.out+" %N"+" %N")

	--	range_sensors.sensors[3]
		end
	end
	end

end
