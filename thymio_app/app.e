NOTE
	DESCRIPTION: "EXAMPLE APPLICATION OF THYMIO-II IN ROBOSCOOP."
	AUTHOR: "RUSAKOV ANDREY"
	DATE: "10.09.2014"

CLASS
	APP

INHERIT
	ROS_ENVIRONMENT

CREATE
	MAKE

FEATURE {NONE} -- INITIALIZATION

	MAKE
			-- CREATE AND LAUNCH THE ROBOT.
		LOCAL
			ROBO_NODE: SEPARATE ROBOSCOOP_NODE
			ROS_SPINNER: SEPARATE ROS_SPINNER
			THYMIO: SEPARATE THYMIO_ROBOT
			find_way:FIND_BEST_WAY
			get_info:READ_FROM_CONSOLE


		DO
			-- INITIALIZE THIS APPLICATION AS A ROS NODE.
			ROBO_NODE := (CREATE {ROS_NODE_STARTER}).ROBOSCOOP_NODE
			SYNCHRONIZE (ROBO_NODE)

			-- LISTEN TO ROS.
			CREATE ROS_SPINNER.MAKE
			START_SPINNING (ROS_SPINNER)

			CREATE THYMIO.MAKE
			-- Start  Algoryth finding way
			create find_way.make

		END
END
