class Player < ApplicationRecord
    belongs_to :team
    has_one :user, through: :team

    validates_uniqueness_of :espn_id

    def self.sort_position
        preferred_order = ["QB", "RB", "WR", "TE", "K", "DT"]
        self.all.sort_by { |a| preferred_order.index(a[:position]) }
    end

    def espn_page
        "http://www.espn.com/nfl/player/_/id/#{self.espn_id}"
    end

end
