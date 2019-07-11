class TeamSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :city, :name, :conference, :division
  belongs_to :user
  has_many :players
end
