# String
output_string = "Hello world! Life is beautiful!"

IO.puts output_string

# List
output_list = ["Hello ", ["world!"], [" ", "Life ", ["is", " ", "beautiful"]]]

IO.puts IO.iodata_to_binary(output_list)

# HTML String
output = "<h1 class=\"text-sm m-5\">Hello World</h1>"

# HTML List
output_list = ["<h1 class=\"", "text-sm m-5", "\" ",">Hello World", "</h1>"]
IO.puts IO.iodata_to_binary(output_list)

# HTML List with conditional class
output_list = ["<h1 class=\"", true && "i-need-this-class ", false && "i-do-not-need-this-class ", "text-sm m-5", "\" ",">Hello World", "</h1>"]

IO.iodata_to_binary(Enum.reject(output_list, & &1 == false))
