require 'httparty'

class DevotionalApi
  include HTTParty
  base_uri 'https://read.rhapsodyofrealities.org/api/devotional'

  def self.get_devotional(date)
    response = get("/#{date}")
    response.parsed_response if response.code == 200
  end
end
