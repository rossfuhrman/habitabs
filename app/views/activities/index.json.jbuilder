json.array!(@activities) do |activity|
  json.extract! activity, :id, :title, :private, :polarity
  json.url activity_url(activity, format: :json)
end
