class Player < ApplicationRecord
    belongs_to :team
    has_one :user, through: :team
    
    validates_uniqueness_of :espn_id, if: :not_defense

    scope :free_agents, -> { where(team_id: 0) }

    def full_name
        self.first_name + " " + self.last_name
    end

    def self.sort_position
        preferred_order = ["QB", "RB", "WR", "TE", "K", "DT"]
        self.all.sort_by { |a| preferred_order.index(a[:position]) }
    end

    def espn_page
        "http://www.espn.com/nfl/player/_/id/#{self.espn_id}"
    end

    def not_defense
        self.position != "DT"
    end

end
