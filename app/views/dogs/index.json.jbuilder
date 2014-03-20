json.array!(@dogs) do |dog|
  json.extract! dog, :id, :name, :birthdate, :admission, :colors, :story, :personality, :weight, :status
  json.url dog_url(dog, format: :json)
end
