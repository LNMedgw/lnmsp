json.extract! user, :id, :name, :character, :rank, :created_at, :updated_at
json.url user_url(user, format: :json)
