note
	description: "Summary description for {PID}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PID
	inherit
		TRIGONOMETRY_MATH
create
	make

feature

make (g_x,g_y: separate REAL_64)
	do
		create odometry_signaler.make_with_topic ({THYMIO_TOPICS}.odometry)
		create timer.make(1000)
		create pids.make("test")
		take_ratios
		 x:=g_x
         y:=g_y
         err_prev:=0
         err_actual:=0

         count_angel(odometry_signaler)

	end

feature

	odometry_signaler: separate ODOMETRY_SIGNALER
	x:REAL_64
	y:REAL_64
	k_P: REAL_64
	k_I: REAL_64
	k_D: REAL_64
	err_prev:REAL_64
	err_actual:REAL_64
	goal_angel: REAL_64
	time_prev: REAL_64
	dt:REAL_64=0.001 -- from class TIMER.current_time_millis- resolution is 0.001
	err_sum: REAL_64
	timer: TIMER
	pids: READ_PID

feature

	take_ratios
		do
			k_P:=pids.list_ratios[1]
			k_I:=pids.list_ratios[2]
			k_D:=pids.list_ratios[3]
		end

	count_angel(odo: separate ODOMETRY_SIGNALER)
		do
			goal_angel:= atan2(y-odo.y,x-odo.x)
		end


	err_actual_count(odometry: separate ODOMETRY_SIGNALER)
		do
			count_angel(odometry_signaler)
			err_actual:=goal_angel-odometry.theta

			 if err_actual > pi then
			    err_actual := err_actual - 2*Pi
			 elseif err_actual < -pi then
			     err_actual := err_actual + 2*Pi
			 end
			 --print(" Actul ERROR  "+err_actual.out+"  %N")
		end

	clear_integral
	do
		err_sum:=0
	end

	err_delta:REAL_64
		do
			err_prev:=err_actual
			err_actual_count(odometry_signaler)
			Result:=err_actual-err_prev
		end

	P_control:REAL_64
		do
			err_actual_count(odometry_signaler)
			Result:= k_P*err_actual
		end

	I_control:REAL_64
		do
			err_sum:=err_sum+err_actual*dt
			Result:=k_D*err_sum
		end

	D_control:REAL_64
		do
		Result:=k_I*err_delta/dt
		end

	PID_ratio: REAL_64
		do
			Result:=P_control +I_control+D_control
		end
end
