
-- Functionality of PID controller
The application allow user to move Thymio II from point where it is now to the point, which is  proposed by the user, using PID controller.

-- Usage
Robot has to be connected with ROS. Next, when we compile the application, we are asked for typing  a point (x,y) where we would like to  move the robot.  All values of PID controller are storage in a file "test" where we can modyfy it.
 
-- File/directory structure
In the roboscoop_app directory:
* app.e - main file, where  we create object "READ_FROM_CONSOLE" which provide us a target point. It allows us to create an object "GO_CLASS" which is responsible for launching a journey.

* read_from_console.e -file which provides the  main file information about the target point- user has to typy it using console

*GO_CLASS.e- file responsible for a ride. Thanks to it robot 'knows' when to start and stop its journe. Here is implemented information about odometry- pose of the robot, distance to go, light status and command "go" and "stop", which are included in the most broad function "launch_go"  

*PID.e- file with implemented PID regulator. All ratios  are taken from object of type "READ_PID".  Here are computed information about error (previous, actual, difference), angle of ride, each P,I and D part of controller. There is also method "clear_integral" which set value of integral part to 0- this is to not use cumulated error in next step. It is to decrease influence of this ratio, when robot changes its movement  (from only rotation to trans+rot). 

*READ_PID.e - this file enables us to take values of coefficents from the file named "test"

-- How it works?
At the begining, robot rotates around its own z axis to set a direction in which it has to go. To achieve this goal, it is using PID controller and try to set its position whith accuracy less than 0.008 rad. Then  robot  tries to ride forward to meet a target point. During this ride PID controller tries to minimize an angle between robot and direction.  The target is reached when  robot's distance to a target is less than 0.004 m or when one of the pose components has beem reached. 
In D part of regulator variable 'dt' is set to 0.001 s. This information is taken from class TIMER.current_time_millis. This is a max resolution of shown records. 

