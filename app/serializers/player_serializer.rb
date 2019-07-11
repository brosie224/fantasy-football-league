class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :position
  belongs_to :team
end