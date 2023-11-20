class ProductSerializers < ActiveModel::Serializer
  attributes :id, :name, :description, :product_url, :created_at, :company_id
end
