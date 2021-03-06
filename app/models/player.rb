class Player < ApplicationRecord
    belongs_to :team
    has_one :user, through: :team
    
    # attr_accessor :pass_yards

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

    def headshot
        # ESPN:
        # "https://a.espncdn.com/combiner/i?img=/i/headshots/nfl/players/full/#{self.espn_id}.png"
        # Fantasy Data:
        "https://s3-us-west-2.amazonaws.com/static.fantasydata.com/headshots/nfl/low-res/#{self.espn_id}.png"
    end

    def not_defense
        self.position != "DT"
    end

    def previous
        player = Player.where("id < ?", self.id).last

        player ? player : Player.last
    end

    def next
        player = Player.where("id > ?", self.id).first

        player ? player : Player.first
    end

end
