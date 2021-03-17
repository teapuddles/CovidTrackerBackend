class UserSerializer < ActiveModel::Serializer
attributes :username, :id

has_one :location
end



