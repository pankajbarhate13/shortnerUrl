json.extract! short_url, :id, :title, :url, :created_at, :updated_at
json.url short_url_url(short_url, format: :json)
