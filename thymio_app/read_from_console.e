note
	description: "Summary description for {READ_FROM_CONSOLE}."
	author: "Kamil"
	date: "$Date$"
	revision: "$Revision$"

class
	READ_FROM_CONSOLE
create
	make

feature

	make
		do
			print("Type start point: %N")
			print("X= %N")
			io.read_double
			xstart:=io.last_double
			print("Y= %N")
			io.read_double
			ystart:=io.last_double
			print("Z is default 0 ;)%N")

			print("Type goal point: %N")
			print("X= %N")
			io.read_double
			xgoal:=io.last_double
			print("Y= %N")
			io.read_double
			ygoal:=io.last_double
			print("Once again Z is default 0 ;)%N")

			print("Is robot a point? write its radius [in meters]  or typ 0 %N")
			io.read_double
			radius:=io.last_double
			print("Ooo and each node should have 6 or 26 neighbours? Just type 6 or 26  ;)%N")
			io.read_double
			strategy:=io.last_integer

			print( "start computing %N")

		end

feature
	xstart,ystart,zstart:REAL_64
	xgoal,ygoal,zgoal:REAL_64
	radius:REAL_64
	strategy:INTEGER

feature

	give_value
	do

		
	end

end
