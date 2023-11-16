class UserSerializers < ActiveModel::Serializer
  attributes :id, :jti, :email, :created_at
end
