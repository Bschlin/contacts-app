class Contact < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def friendly_updated_at
    created_at.strftime("%B %e, %Y")
  end

  def full_name
    full_name = "#{first_name} #{middle_name} #{last_name}"
  end

  def prefix
    "+81 #{phone_number}"
  end 


  def as_json
    {
      id: id,
      full_name: full_name,
      first_name: first_name,
      middle_name: middle_name,
      last_name: last_name,
      email: email,
      phone_number: prefix,
      created_at: friendly_updated_at
    }
  end

end
