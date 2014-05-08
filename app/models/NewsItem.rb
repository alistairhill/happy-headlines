require_relative 'nytimes'

class NewsItem
  attr_accessor :headline, :snippet, :good

  def initialize(snippet, headline)
    @headline = headline
    @snippet = snippet
    # @image = image
    # @link = link
    # @date = date
    @good = headline_is_good
  end

  def bad_news_words
    bad_news_words_array = %w(worry bomb blast murder 
    murdered killed stabbed beaten death burst nazi war 
    warcrimes abuse withers putin nsa snowden politician 
    climate suffering burned horrible terrible bad ugly 
    ukraine corrupt who die kill die russia lost lose 
    venting dementia )
  end

  def headline_is_good
    bad_news_words.each do |word|
      is_bad = @headline.downcase.include?(word) || @snippet.downcase.include?(word)
      return false if is_bad
    end
    true
  end
end


