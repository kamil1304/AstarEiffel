note
	description: "Constants used for tangent bug algorithm."
	author: "Konrad Cop, Kamil Grycz, Fabian Bloechliger"
	date: "12.10.2015"

class
	TBUG_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make
			-- Create objects.
		do

		end

feature -- Constants

	-- Test settings.

	--initial_state: STRING = "forward"
	initial_state: STRING = "boundary"
	-- Goal coordinates
	x_goal: REAL_64 = -0.5
	y_goal: REAL_64 = -0.5

	-- TBUG_STATE_FORWARD
	test_vx: REAL_64 = 0.03
	test_thete:REAL_64=0.08
--	forward_theta_control_settings: PID_SETTINGS
--	forward_theta_control_settings_drive: PID_SETTINGS
--	forward_distance_control_settings: PID_SETTINGS

	-- TBUG_STATE_BOUNDARY
	loop_threshold: REAL_64 = 0.01 -- radius of the circle which declares area of loop closure

	range_sens_angel: REAL_64 = 0.261799388 --15 degree
	range_sens_dist: REAL_64= 0.08
	minimal_distance: REAL_64=0.09
	min_thete_error: REAL_64=0.03
	min_dist_extern_senor:REAL_64=0.10
	avoid_obstacle_angel: REAL_64=1.5705 -- 90 degree
	default_offset: REAL_64=0.05
	v_leave_dist:REAL_64=0.05
	-- TBUG_STATE_TRANSITION



end
