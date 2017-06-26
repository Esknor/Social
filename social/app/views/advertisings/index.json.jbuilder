json.array!(@advertisings) do |advertising|
  json.extract! advertising, :id, :img, :header, :content
  json.url advertising_url(advertising, format: :json)
end
