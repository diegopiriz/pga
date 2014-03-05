json.array!(@adoptions) do |adoption|
  json.extract! adoption, :id, :adopter_id, :dog_id, :date
  json.url adoption_url(adoption, format: :json)
end
