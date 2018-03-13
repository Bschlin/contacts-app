class Contact < ApplicationRecord

  def friendly_updated_at
    created_at.strftime("%B %e, %Y")
  end

  def full_name
    full_name = "#{first_name} #{last_name}"
  end

  def prefix
    "+81 #{phone_number}"
  end 


  def as_json
    {
      id: id,
      full_name: full_name,
      first_name: first_name,
      last_name: last_name,
      email: email,
      phone_number: prefix,
      created_at: friendly_updated_at
    }
  end

end
