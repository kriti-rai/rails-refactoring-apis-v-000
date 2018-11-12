class GithubRepo

  attr_reader :name, :url

  def initialize(hash)
    @name = hash["name"]
    @url = hash["html_url"]
  end

  def authenticate!(client_id, client_secret, code)
    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = {"client_id": client_id, "client_secret": client_secret, "code": code}
      req.headers['Accept'] = 'application/json'
    end
    access_hash = JSON.parse(response.body)
    session[:username] = access_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session_token}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

  end


end
