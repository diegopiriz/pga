json.array!(@adopters) do |adopter|
  json.extract! adopter, :id, :name, :phone, :email, :address
  json.url adopter_url(adopter, format: :json)
end
