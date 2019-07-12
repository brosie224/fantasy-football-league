class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_one :team
  has_many :players
end
