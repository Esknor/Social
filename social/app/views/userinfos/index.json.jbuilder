json.array!(@userinfos) do |userinfo|
  json.extract! userinfo, :id, :firstname, :lastname, :status, :permission
  json.url userinfo_url(userinfo, format: :json)
end
