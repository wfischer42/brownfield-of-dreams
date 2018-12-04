class GithubService
  def initialize(user)
    @key = ENV["GITHUB_API_KEY"]
  end

  def get_followers
    get_json("/user/followers")
  end

  private

  def get_json(url)
    response ||= conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = @key
      faraday.adapter Faraday.default_adapter
    end
  end
end
