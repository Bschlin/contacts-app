require "unirest"

system "clear"
puts "Welcome to Contacts app! Choose an option:"
puts "[signup] Signup (create a user)"
puts "[login] Login (create a JSON web token)"
puts "[logout] Logout (delete the JSON web token)"

input_option = gets.chomp
if input_option == "signup"
  params = {}
  print "Name: "
  params[:name] = gets.chomp
  print "Email: "
  params[:email] = gets.chomp
  print "Password: "
  params[:password] = gets.chomp
  print "Password Confirmation: "
  params[:password_confirmation] = gets.chomp
  response = Unirest.post("http://localhost:3000/v1/users", parameters: params)
  p response.body
  elsif input_option == "login"
    params = {}
    puts "Please enter your email"
    input_email = gets.chomp
    puts "Enter a password"
    input_password = gets.chomp 
    response = Unirest.post(
    "http://localhost:3000/user_token",
    parameters: {
      auth: {
        email: input_email,
        password: input_password
      }
    }
  )
    jwt = response.body["jwt"]
    Unirest.default_header("Authorization", "Bearer #{jwt}")
  elsif input_option == "logout"
    jwt = ""
    Unirest.clear_default_headers()

end


system "clear"
puts "Choose an option"
puts "[1] See Contact list"
puts "[1.1] Select contact by attribute"
puts "[2] See one Contact"
puts "[3] Create a Contact"
puts "[4] Update a Contact"
puts "[5] Delete a Contact"

# input_option = gets.chomp
# if input_option == "1"
#   response = Unirest.get("http://localhost:3000/v1/contact_list_url")
#   contact = response.body
#   puts JSON.pretty_generate(contact)
# elsif input_option == "2"
#   response = Unirest.get("http://localhost:3000/v1/contact_list1_url")
#   contact = response.body
#    puts JSON.pretty_generate(contact)
# elsif input_option == "3"
#   response = Unirest.get("http://localhost:3000/v1/contact_list2_url")
#   contact = response.body
#   puts JSON.pretty_generate(contact)
# end

input_option = gets.chomp
if input_option == "1"
  response = Unirest.get("http://localhost:3000/v1/contacts")
  contact = response.body
  puts JSON.pretty_generate(contact)
elsif input_option == "1.1"
  response = Unirest.get("http://localhost:3000/v1/contacts?query=ack")
  contacts = response.body
  puts JSON.pretty_generate(contacts)
elsif input_option == "2"
  print "Enter a contact id: "
  contact_id = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/contacts/#{contact_id}")
  contact = response.body
  puts JSON.pretty_generate(contact)
elsif input_option == "3"
 params = {}
 print "first name: "
 params["input_first_name"] = gets.chomp
 print "last name: "
 params["input_last_name"] = gets.chomp
 print "midde_name: "
 params["input_middle_name"] = gets.chomp
 print "email: "
 params["input_email"] = gets.chomp
 print "phone number: "
 params["input_phone_number"] = gets.chomp
 response = Unirest.post("http://localhost:3000/v1/contacts", parameters: params)
 contact = response.body 
 if contact["errors"]
    puts "Uh oh! Something went wrong..."
    p contact["errors"]
  else
    puts "Here is your contact info:"
    puts JSON.pretty_generate(contact)
  end
elsif input_option == "4"
  print "Enter a contact id: "
  contact_id = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/contact/#{contact_id}")
  contact = response.body
  params = {}
  print "first name(#{contact["first name"]}): "
  params["input_first_name"] = gets.chomp
  print "middle name (#{contact["middle name"]}): "
  params["input_middle_name"] = gets.chomp
  print "last name (#{contact["last name"]}): "
  params["input_last_name"] = gets.chomp
  print "email (#{contact["email"]}): "
  params["input_email"] = gets.chomp
  print "phone number (#{contact["phone number"]}): "
  params["input_phone_number"] = gets.chomp
  params.delete_if { |_key, value| value.empty? }
  response = Unirest.patch("http://localhost:3000/v1/contacts/#{contact_id}", parameters: params)
  contact = response.body
  if contact["errors"]
    puts "Uh oh! Something went wrong..."
    p contact["errors"]
  else
    puts "Here is your contact info:"
    puts JSON.pretty_generate(contact)
  end
elsif input_option == "5"
  print "Enter a contact id: "
  contact_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/v1/contacts/#{contact_id}")
  body = response.body 
  puts JSON.pretty_generate(contact)
end 