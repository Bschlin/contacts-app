class V1::ContactsController < ApplicationController

 # def first_contact_method
 #  contact = Contact.first
 #  render json: {
 #    first_name: contact.first_name,
 #    last_name: contact.last_name,
 #    email: contact.email,
 #    phone_number: contact.phone_number,
 #  }
 # end

 # def second_contact_method
 #  contact = Contact.second
 #  render json: {
 #    first_name: contact.first_name,
 #    last_name: contact.last_name,
 #    email: contact.email,
 #    phone_number: contact.phone_number,
 #  }
 # end

 # def third_contact_method
 #  contact = Contact.third
 #  render json: {
 #    first_name: contact.first_name,
 #    last_name: contact.last_name,
 #    email: contact.email,
 #    phone_number: contact.phone_number,
 #  }
 # end

 def index
   contact = Contact.all
   search_terms = params[:query]
   if search_terms
     contact = contact.where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{search_terms}%", "%#{search_terms}%", "%#{search_terms}%")
   end
   render json: contact.as_json
 end 

 def show
  contact_id = params["id"]
  contact = Contact.find_by(id: contact_id)
  render json: contact.as_json
end 

def create
 contact = Contact.new(
  first_name: params["input_first_name"],
  middle_name: params["input_middle_name"],
  last_name: params["input_last_name"],
  email: params["input_email"],
  phone_number: params["input_phone_number"]
  )
 if contact.save
  render json: contact.as_json
else 
  render json: {errors: contact.errors.full_messages}, status: 422
end
end 

def update
 contact_id = params["id"]
 contact = Contact.find_by(id: contact_id)
 contact.first_name = params["input_first_name"] || contact.first_name
 contact.middle_name = params["input_middle_name"] || contact.middle_name
 contact.last_name = params["input_last_name"] || contact.last_name
 contact.email = params["input_email"] || contact.email
 contact.phone_number = params["input_phone_number"] || contact.phone_number
 if product.save
  render json: contact.as_json
else
  render json: {errors: contact.errors.full_messages}, status: 422
end
end 


def destroy
 contact_id = params["id"]
 contact = Contact.find_by(id: contact_id)
 contact.destroy
 render json: contact.as_json
end 
end
