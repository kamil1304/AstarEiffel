note
	description: "Summary description for {READ_PID}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	READ_PID
create
	make
feature
	make(file_name: STRING)
	do
		 create input.make_open_read(file_name)
		 create list_ratios.make (0)
		 take_number
	end

feature
	input : PLAIN_TEXT_FILE

i: INTEGER
list_ratios: ARRAYED_LIST [REAL_64]

feature

	take_number
	do
		from
			input.start
		until
			i>2
		loop
		input.read_word
		input.read_character
		input.read_word
		list_ratios.extend (input.last_string.to_double)
		i:=i+1
		end

	end
end
