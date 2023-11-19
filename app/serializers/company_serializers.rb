class CompanySerializers < ActiveModel::Serializer
  attributes :id, :name, :description, :product_url, :created_at, :user_id
end
