class TeamSerializer < ActiveModel::Serializer
  attributes :id, :city, :name, :conference, :division
  belongs_to :user
end
