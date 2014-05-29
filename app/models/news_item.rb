require_relative 'nytimes'

class NewsItem
  attr_reader :headline, :snippet, :good, :url, :image

  def initialize(snippet, headline, url) #make into hash
    @headline = headline
    @snippet = snippet[0..-2]
    @url = url
    # @image = image
    # @date = date
    @good = positive_news
    @ok = boring_news
  end

  def good_news_words
    good_news_array = %w(happy peace great good 
    rescued saved exonerated extension peace released
    peaceful reward award kittens dolphins love dbc)
  end

  def bad_news_words
    bad_news_array = %w(worry bomb blast murder marriage 
    murdered killed stabbed beaten death burst nazi war 
    warcrimes abuse withers putin nsa snowden politician 
    climate suffering burned horrible terrible bad ugly 
    ukraine corrupt who die kill die lost lose kgb cia
    venting dementia attack kidnap kidnapped victim army
    suspended punch drugs crime broken gop politican gun
    guns ammo explosion ripped hurt egypt sues rwanda
    holocaust genocide nuclear assault greed mh370 terror
    poorly lethal sinking friction lawsuit crashed korea
    indicted arrested disaster economy phase2 rao)
  end

  def positive_news
    good_news_words.each do |word|
      is_good = @headline.downcase.include?(word) || @snippet.downcase.include?(word)
      return true if is_good
    end
    false
  end

  def boring_news
    bad_news_words.each do |word|
      is_ok = @headline.downcase.include?(word) || @snippet.downcase.include?(word)
      return false if is_ok
    end
    true
  end
end


