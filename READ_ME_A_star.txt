--Functionality
The application enables to find optimal way from  start point to goal using A* algorithm.  User deffines both points and application create path, which avoid obstacles. User can define the size of robot, which implies different path than treating robot as a point mass. Path can be displayed in rviz or can be used  in  next group assigment.

--Usage
Required software packages: EiffelStudio and map as a graphical file+ information about map in *.yamal file. Application uses ROS map server to load a map.  Rviz is not needed to  calculate path but is very useful to dispaly the result path.


-- File/directory Structure
->thymio_app/app.e --here is creating object which enables to find optimal path
->thymio_app/read_from_console.e -- this class  obtains  useful data from user, such as: start and goal  point, size of robot, type of map connection
->thymio_app/assigment_2/finding_best_way.e --this class  is main class- here is called graph creation, A* and rviz displaying
->thymio_app/assigment_2/nodes.e -- here is  graph creation and all  stuff which graph need ex. type of connection between nodes, obstacles position, and obtaing all info to create a graph from *.yamal  file
->thymio_app/assigment_2/astar.e -- type of algorith which enables to  compute  optimal path-   main function "do_star" needs graph to  calculate path; class need information about  start&goal
->thymio_app/assigment_2/cost_to_go.e -- class which make easier to calculate  cost between two nodes
->thymio_app/assigment_2/heuristics.e -- class which computes heuristic cost
->thymio_app/assigment_2/grid_connect6.e -- class  creates grid of neighbors between nodes, in this case, each node can have max 6 neighbors and distance to each is 1; 6 is for  spatian nodes, for 2D it is 4 
->thymio_app/assigment_2/grid_connect26.e --in this case, each node can have 26 neighbors in 3D, so distance between node and neighbor is 1 OR sqrt(2), depends on neighbor's position
->thymio_app/assigment_2/up_heap_cost.e -- this is class which contain relevant information about each point-node which algorithm has to  visit- mainly  position, cost_g, cost_f of  current node and its parrent. Such construction enables to sort objects by its cost in open_set in Astar algorithm. 
->thymio_app/assigment_2/rviz_path.e -- class need set of points, which show the path computed by  A*, and  send it to rviz-> thanks to this class finally we can see what are we looking for! ;)

--Workflow
*application quite well computes optimal path for both types of connections (in 2D-> 4 or 3D->8 neighbors), it follows, that  time for path computng  for  graph, where  node has max 4  neighbors is longer than for 8 neighbors (even 3x). Next, also path is shorter   for 8 neighbors. 
*  In algorithm is used bubble sort, which has time performance O(n^2). If computing path is very long and  graph consists of many nodes, then time rises quadratically. Unfortunately author's approaches to use quicksort or binarysort have failed, but   new approaches will be continued. 
*To enable non-point mass robot reach a goal, it is posibility to inflate obstacles. If robot is very big, then alorithm will  indicates, that  goal is unreachable. If robot will  be surronded by walls and  goal will be beneath them, then  application also will scan all possibilities and will give answer about unreachable goal.

 
