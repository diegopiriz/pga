json.array!(@dogs) do |dog|
  json.extract! dog, :id, :name, :birtdate, :admission, :primary_color, :secondary_color, :origin, :personality, :size_id, :status_id
  json.url dog_url(dog, format: :json)
end
