class HomeController < ApplicationController
  def index
    @daily_verse = DailyVerseService.get_daily_verse
  end
end
