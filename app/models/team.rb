class Team < ApplicationRecord
    belongs_to :user
    has_many :players

    scope :afc_east, -> { where(conference: "AFC", division: "East") }
    scope :afc_north, -> { where(conference: "AFC", division: "North") }
    scope :afc_south, -> { where(conference: "AFC", division: "South") }
    scope :afc_west, -> { where(conference: "AFC", division: "West") }
    scope :nfc_east, -> { where(conference: "NFC", division: "East") }
    scope :nfc_north, -> { where(conference: "NFC", division: "North") }
    scope :nfc_south, -> { where(conference: "NFC", division: "South") }
    scope :nfc_west, -> { where(conference: "NFC", division: "West") }

    def full_name
        self.city + " " + self.name
    end

    # def self.by_division(conf, div)
    #     self.all.where(conference: conf, division: div)
    # end

end
