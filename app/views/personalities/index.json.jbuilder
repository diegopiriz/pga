json.array!(@personalities) do |personality|
  json.extract! personality, :id, :description
  json.url personality_url(personality, format: :json)
end
