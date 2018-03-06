require "unirest"

system "clear"
puts "Choose an option"
puts "[1] Contact 1"
puts "[2] Contact 2"
puts "[3] Contact 3"

input_option = gets.chomp
if input_option == "1"
  response = Unirest.get("http://localhost:3000/contact_list_url")
  contact = response.body
  puts JSON.pretty_generate(contact)
elsif input_option == "2"
  response = Unirest.get("http://localhost:3000/contact_list1_url")
  contact = response.body
   puts JSON.pretty_generate(contact)
elsif input_option == "3"
  response = Unirest.get("http://localhost:3000/contact_list2_url")
  contact = response.body
  puts JSON.pretty_generate(contact)
end




# require "unirest"

# system "clear"
# puts "Here is the first contact!"


#   response = Unirest.get("http://localhost:3000/contact_list_url")
#   contact = response.body
#   puts contact
