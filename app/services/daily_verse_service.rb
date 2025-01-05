require 'httparty'

class DailyVerseService
  BASE_URL = "https://read.rhapsodyofrealities.org/api/devotional/"

  BIBLE_TRANSLATION = {
    "Genesis" => "Genèse",
    "Exodus" => "Exode",
    "Leviticus" => "Lévitique",
    "Numbers" => "Nombres",
    "Deuteronomy" => "Deutéronome",
    "Joshua" => "Josué",
    "Judges" => "Juges",
    "Ruth" => "Ruth",
    "Samuel" => "Samuel",
    "Kings" => "Rois",
    "Chronicles" => "Chroniques",
    "Ezra" => "Esdras",
    "Nehemiah" => "Néhémie",
    "Esther" => "Esther",
    "Job" => "Job",
    "Psalms" => "Psaumes",
    "Proverbs" => "Proverbes",
    "Ecclesiastes" => "Ecclésiaste",
    "Song of Solomon" => "Cantique des cantiques",
    "Isaiah" => "Ésaïe",
    "Jeremiah" => "Jérémie",
    "Lamentations" => "Lamentations",
    "Ezekiel" => "Ézéchiel",
    "Daniel" => "Daniel",
    "Hosea" => "Osée",
    "Joel" => "Joël",
    "Amos" => "Amos",
    "Obadiah" => "Abdias",
    "Jonah" => "Jonas",
    "Micah" => "Michée",
    "Nahum" => "Nahum",
    "Habakkuk" => "Habacuc",
    "Zephaniah" => "Sophonie",
    "Haggai" => "Aggée",
    "Zechariah" => "Zacharie",
    "Malachi" => "Malachie",
    "Matthew" => "Matthieu",
    "Mark" => "Marc",
    "Luke" => "Luc",
    "John" => "Jean",
    "Acts" => "Actes",
    "Romans" => "Romains",
    "Corinthians" => "Corinthiens",
    "Galatians" => "Galates",
    "Ephesians" => "Éphésiens",
    "Philippians" => "Philippiens",
    "Colossians" => "Colossiens",
    "Thessalonians" => "Thessaloniciens",
    "Timothy" => "Timothée",
    "Titus" => "Tite",
    "Philemon" => "Philémon",
    "Hebrews" => "Hébreux",
    "James" => "Jacques",
    "Peter" => "Pierre",
    "Jude" => "Jude",
    "Revelation" => "Apocalypse"
  }

  def self.get_daily_verse
    date = Date.today.strftime("%Y-%m-%d")
    url = "#{BASE_URL}#{date}"
    
    response = HTTParty.get(url)
    json = response.parsed_response

    verse = json['result'][0]['BA']

    testament_passages = verse.split(';')

    old_testament = testament_passages[1].strip
    new_testament = testament_passages[0].strip

    old_testament = translate_bible_books(old_testament)
    new_testament = translate_bible_books(new_testament)

    day_of_week = Date.today.strftime('%A')
    translated_day_of_week = {
      'Monday' => 'Lundi', 'Tuesday' => 'Mardi', 'Wednesday' => 'Mercredi', 'Thursday' => 'Jeudi',
      'Friday' => 'Vendredi', 'Saturday' => 'Samedi', 'Sunday' => 'Dimanche'
    }[day_of_week]

    month_of_year = Date.today.strftime('%B')
    translated_month_of_year = {
      'January' => 'Janvier', 'February' => 'Février', 'March' => 'Mars', 'April' => 'Avril',
      'May' => 'Mai', 'June' => 'Juin', 'July' => 'Juillet', 'August' => 'Août',
      'September' => 'Septembre', 'October' => 'Octobre', 'November' => 'Novembre', 'December' => 'Décembre'
    }[month_of_year]

    message = <<-MESSAGE
#{translated_day_of_week.upcase} #{Date.today.strftime('%d')} #{translated_month_of_year.upcase} #{Date.today.strftime('%Y')}

*Ancien Testament* 📜
#{old_testament};

*Nouveau Testament* 📖
#{new_testament}; 
MESSAGE

    message
  end

  private

  def self.translate_bible_books(text)
    BIBLE_TRANSLATION.each do |english, french|
      text.gsub!(/\b#{english}\b/, french)
    end
    text
  end
end
