class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :first_name, :last_name, :position, :espn_page, :headshot
  belongs_to :team
  has_one :user
end