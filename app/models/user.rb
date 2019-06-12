class User < ApplicationRecord
    has_secure_password
    validates_presence_of :name
    validates :email, presence: true, uniqueness: true

    has_one :team
    has_many :players, through: :team

    def self.find_or_create_by_omniauth(auth_hash)
        self.where(email: auth_hash["info"]["email"]).first_or_create do |user|
            user.password = SecureRandom.hex
            user.name = auth_hash["info"]["name"]
        end
    end

end
