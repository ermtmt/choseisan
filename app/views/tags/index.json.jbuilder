json.array!(@tags) do |tag|
  json.extract! tag, :id, :label, :color
  json.url tag_url(tag, format: :json)
end
