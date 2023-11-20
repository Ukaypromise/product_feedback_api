class CompanySerializers < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :user_id
end
