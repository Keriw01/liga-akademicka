class User < ApplicationRecord
    belongs_to :team, optional: true
    has_secure_password

    validates :email, presence: true
    normalizes :email, with: ->(email) {email.strip.downcase}

end
