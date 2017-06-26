json.array!(@groups) do |group|
  json.extract! group, :id, :name, :describe, :privacy, :image
  json.url group_url(group, format: :json)
end
