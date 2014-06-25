json.array!(@habits) do |habit|
  json.extract! habit, :id, :title, :private, :polarity
  json.url habit_url(habit, format: :json)
end
