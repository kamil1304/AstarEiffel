note
	description: "Summary description for {NEW_1}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GO_CLASS
	inherit
		TRIGONOMETRY_MATH


create
make
feature{NONE}
make
do

	create diff_drive.make_with_topic ({THYMIO_TOPICS}.velocity)
	jedz
end


feature


jedz
do
	from
	until false
	loop
		separate diff_drive as d do
	d.set_velocity (0.1, 0.1)
	end
	end



end

diff_drive: separate THYMIO_DIFFERENTIAL_DRIVE
end

--make (g_x, g_y: separate REAL_64)

--	do

--     	create top_leds.make_with_topic ({THYMIO_TOPICS}.top_leds)
--		create buttons_leds.make_with_topic ({THYMIO_TOPICS}.buttons_leds)
--		create circle_leds.make_with_topic ({THYMIO_TOPICS}.circle_leds)
--		create range_sensors.make ({THYMIO_TOPICS}.prox_horizontal)
--    	create odometry_signaler.make_with_topic ({THYMIO_TOPICS}.odometry)
--    	create thym_diff_drive.make_with_topic ({THYMIO_TOPICS}.velocity)

--   		set(g_x,g_y)
--    	create pid.make(x,y)

--    	launch_go(pid, range_sensors)



--    end

--feature
--	top_leds: separate THYMIO_TOP_LEDS
--	buttons_leds: separate THYMIO_BUTTONS_LEDS
--	circle_leds: separate THYMIO_CIRCLE_LEDS
--	odometry_signaler: separate ODOMETRY_SIGNALER
--	thym_diff_drive: separate THYMIO_DIFFERENTIAL_DRIVE
--	range_sensors: separate THYMIO_RANGE_GROUP

--    pid: separate PID
--	x:REAL_64
--	y:REAL_64
--	distance_go:REAL_64
--	distance_remian:REAL_64


--feature --variables

--curr_dist:REAL_64
--curr_angel:REAL_64
--is_left:BOOLEAN
--is_right:BOOLEAN
--d_min: REAL_64 --as from instruction
--set_angel:BOOLEAN
--error_one_sensor:REAL_64
--is_prievius_right:BOOLEAN
--is_prievius_left: BOOLEAN
--d_to_reach:REAL_64
--next:BOOLEAN
--x_prev,y_prev:REAL_64
--is_end: BOOLEAN


--feature

--	launch_go(one_pid: separate PID; range_sensor: separate THYMIO_RANGE_GROUP; odometry_signaler: separate ODOMETRY_SIGNALER )
--		do

--		from
--					until (distance_remian.abs)<0.002 OR (odo_x(odometry_signaler).abs>=x.abs  AND odo_y(odometry_signaler).abs>=y.abs OR  range_sen.is_real_obstacle_in_front)
--					loop

--	print("DWA   %N %N")
--				    	one_pid.err_actual_count (odometry_signaler)
--						go(0.06, 0.50*one_pid.PID_ratio)

--						difference(odometry_signaler)
--						show_pos
--					end

--					light_down_leds (top_leds, buttons_leds, circle_leds)
--					stop

--			if  range_sensor.is_obstacle_mostly_at_left OR range_sensor.is_obstacle_mostly_at_right then

--				from until is_end
--				loop
--					follow_wall(range_sensor)
--				end
--			end



--		end

--feature



--	turn(one_pid: separate PID)
--	do

--		   light_up_leds (top_leds, buttons_leds, circle_leds)

--		    one_pid.err_actual_count (odometry_signaler)
--		    from
--		    until   one_pid.err_actual.abs<0.008
--		    loop
--		   		 go(0, 0.15*one_pid.PID_ratio)
--				show_pos
--		    end

--			stop
--			one_pid.clear_integral
--			distance_go:=distance(x,0,y,0)
--			difference(odometry_signaler)

--	end

--	go_to_goal(one_pid: separate PID;range_sen: separate THYMIO_RANGE_GROUP)
--	do
--		from
--				until (distance_remian.abs)<0.002 OR (odo_x(odometry_signaler).abs>=x.abs  AND odo_y(odometry_signaler).abs>=y.abs OR  range_sen.is_real_obstacle_in_front)
--				loop

--print("DWA   %N %N")
--			    	one_pid.err_actual_count (odometry_signaler)
--					go(0.06, 0.50*one_pid.PID_ratio)

--					difference(odometry_signaler)
--					show_pos
--				end

--				light_down_leds (top_leds, buttons_leds, circle_leds)
--				stop
--	end

--go_default
--local
--dyst,xx,yy:REAL_64
--do
--	separate odometry_signaler as odo do
--		x_prev:=odo.x
--		x_prev:=odo.y
--	end

--	from 	until  dyst>0.1
--	loop
--		go(0.2,0)
--		separate odometry_signaler as odo do
--		xx:=odo.x
--		yy:=odo.y
--	end
--	dyst:=sqrt( (x_prev-xx).power(2)+(y_prev-yy).power(2))
--	end
--end

--turn_default(rotate:REAL_64)
--local
--see_something:BOOLEAN
--do


--	from 	until  see_something
--	loop
--		go(0,rotate)
--		separate range_sensors as range do
--			see_something:=range.is_obstacle
--		end

--	end
--end


--follow_wall(r_sens: separate THYMIO_RANGE_GROUP)
--local
--vtheta, vx:REAL_64
--do

--			if r_sens.sensors[1].range<0.09 then
--				vtheta:=-0.2
--				vx:=0
--			end

--			if r_sens.sensors[5].range<0.09 then
--				vtheta:=0.2
--				vx:=0
--			end

--			if r_sens.sensors[5].range<0.1 OR  r_sens.sensors[1].range<0.1 then
--				vx:=0.02
--			end
--		go(vx, vtheta)


--			if	r_sens.is_real_obstacle_in_front then --when  3  sensors detect something
--			print(" WHEN OBSTACLE IS IN FRONT %N")		--then turn right or left depends

--				If 	is_prievius_right then
--					vtheta:=-0.6
--					vx:=0
--				elseif is_prievius_left then
--				vtheta:=-0.6
--				vx:=0
--				end

--			end

--		if  not r_sens.is_obstacle then
--			go_default

--			if is_prievius_right then
--				turn_default(-0.2)
--			else
--			turn_default(0.2)
--			end
--		end

--		if   r_sens.sensors[5].is_valid_range  and   not r_sens.sensors[1].is_valid_range then
--			is_prievius_right:=true
--			is_prievius_left:=false
--		elseif  not r_sens.sensors[5].is_valid_range  and   r_sens.sensors[1].is_valid_range then
--			is_prievius_right:=false
--			is_prievius_left:=true
--		elseif   not r_sens.sensors[5].is_valid_range  and   not r_sens.sensors[1].is_valid_range then
--			is_prievius_right:=false
--			is_prievius_left:=false
--		elseif  r_sens.sensors[5].is_valid_range  and   r_sens.sensors[1].is_valid_range then
--			is_prievius_right:=true
--			is_prievius_left:=true
--		end

--end




--	set(a,b: separate REAL_64)
--		 do
--			x:=a
--			y:=b
--		end

--	odo_x(odo:separate ODOMETRY_SIGNALER):REAL_64
--		do
--			separate odo as b do
--			Result:=b.x
--			end
--		end

--	odo_y(odo:separate ODOMETRY_SIGNALER):REAL_64
--		do
--			separate odo as b do
--			Result:=b.y
--			end
--		end

--	odo_z(odo:separate ODOMETRY_SIGNALER):REAL_64
--		do
--			separate odo as b do
--			Result:=b.z
--			end
--		end

--	show_pos
--		do
--		io.put_string("Position x,y,z " +odo_x(odometry_signaler).out +" "+ odo_y(odometry_signaler).out +" "+ odo_z(odometry_signaler).out+" %N")
--		end

--	go( x_velo: REAL_64; theta_velo: REAL_64)
--		do
--		   separate thym_diff_drive as a do
--			a.set_velocity(x_velo,theta_velo)
--	       end
--		end

--	stop
--		do
--			separate thym_diff_drive as b do
--			b.set_velocity(0,0)
--			end
--		end


--	distance(x1,x2,y1,y2: REAL_64): REAL_64
--		do
--			Result:=sqrt((x1-x2).power(2)+(y1-y2).power(2))
--		end

--	difference(odos:separate ODOMETRY_SIGNALER)
--		do
--			separate odos as b do
--			distance_remian:=distance(x,b.x,y,b.y)
--			end

--		end

--	light_up_leds (top: separate THYMIO_TOP_LEDS;
--						buttons: separate THYMIO_BUTTONS_LEDS;
--						circle: separate THYMIO_CIRCLE_LEDS)
--				 Turn on some LED lights.
--		do
--			top.set_to_yellow
--			buttons.set_leds_brightness (<<0,0,0,0>>)
--			circle.set_leds_brightness (<<32,32,32,32,32,32,32,32>>)
--		end

--	light_down_leds (top: separate THYMIO_TOP_LEDS;
--					buttons: separate THYMIO_BUTTONS_LEDS;
--					circle: separate THYMIO_CIRCLE_LEDS)
--		do
--			top.set_to_green
--			buttons.set_leds_brightness (<<0,0,0,0>>)
--			circle.set_leds_brightness (<<0,0,0,0,0,0,0,0>>)
--		end

--	geometry_calcul( r_sens: separate THYMIO_RANGE_GROUP; tbug_const: separate TBUG_CONSTANTS)
--	require
--		(r_sens.sensors[1].is_valid_range  AND r_sens.sensors[2].is_valid_range) OR (r_sens.sensors[5].is_valid_range AND r_sens.sensors[4].is_valid_range)
--	local
--	x1,x2,y1,y2, vec_wall_x, vec_wall_y: REAL_64

--	do

--		if r_sens.is_obstacle_mostly_at_left then

--			x1:=(r_sens.sensors[5].range+tbug_const.range_sens_dist)*cosine(2*tbug_const.range_sens_angel)
--			y1:=(r_sens.sensors[5].range+tbug_const.range_sens_dist)*sine(2*tbug_const.range_sens_angel)
--							if 	 r_sens.sensors[4].is_valid_range  then
--			x2:=(r_sens.sensors[4].range+tbug_const.range_sens_dist)*cosine(tbug_const.range_sens_angel)
--			y2:=(r_sens.sensors[4].range+tbug_const.range_sens_dist)*sine(tbug_const.range_sens_angel)
--			is_left:=true
--			is_right:=false
--		else

--			x1:=(r_sens.sensors[1].range+tbug_const.range_sens_dist)*cosine(2*tbug_const.range_sens_angel)
--			y1:=-(r_sens.sensors[1].range+tbug_const.range_sens_dist)*sine(2*tbug_const.range_sens_angel)
--							if 	 r_sens.sensors[2].is_valid_range  then
--			x2:=(r_sens.sensors[2].range+tbug_const.range_sens_dist)*cosine(tbug_const.range_sens_angel)
--			y2:=-(r_sens.sensors[2].range+tbug_const.range_sens_dist)*sine(tbug_const.range_sens_angel)
--			is_left:=false
--			is_right:=true
--		end
--			curr_dist:=(((y2-y1)*x1-(x2-x1)*y1)/sqrt((y2-y1).power(2)+(x2-x1).power(2))).abs
--			vec_wall_x:=x2-x1
--			vec_wall_y:=y2-y1
--			curr_angel:= arc_cosine(vec_wall_x/sqrt(vec_wall_x.power(2)+vec_wall_y.power(2)))
--	end


--end

