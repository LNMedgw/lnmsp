json.extract! live_datum, :id, :username, :liveurl, :streamstart, :thumbnailurl, :created_at, :updated_at
json.url live_datum_url(live_datum, format: :json)
