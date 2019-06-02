class Team < ApplicationRecord
    belongs_to :user
    has_many :players

    def full_division
        self.conference + " " + self.division
    end

end
