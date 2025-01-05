require 'httparty'

class DailyVerseService
  BASE_URL = "https://read.rhapsodyofrealities.org/api/devotional/"

  def self.get_daily_verse
    date = Date.today.strftime("%Y-%m-%d") # format date : "2025-01-05"
    url = "#{BASE_URL}#{date}"
    
    response = HTTParty.get(url)
    json = response.parsed_response

    # Récupérer le verset "BA"
    json['result'][0]['BA']
  end
end
