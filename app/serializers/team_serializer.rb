class TeamSerializer < ActiveModel::Serializer
  attributes :id, :city, :name, :conference, :division
  belongs_to :user
  has_many :players
end
