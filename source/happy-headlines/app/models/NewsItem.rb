require_relative 'nytimes'

class NewsItem
  attr_accessor :headline, :snippet, :image, :good

  def initialize(snippet, headline)
    @headline = headline
    @snippet = snippet
    # @image = image
    @good = headline_is_good
  end

  def bad_news_words
    bad_news_words_array = %w(worry bomb blast murder 
    murdered killed stabbed beaten death burst nazi war 
    warcrimes abuse withers Putin nsa snowden politician 
    climate suffering burned horrible terrible bad ugly 
    ukraine corrupt who same-sex die kill die )
  end

  def headline_is_good
    # bad_news_words_array = %w(worry bomb blast murder 
    # murdered killed stabbed beaten death burst nazi war 
    # warcrimes abuse withers Putin nsa snowden politician 
    # climate suffering burned horrible terrible bad ugly 
    # ukraine corrupt who same-sex die kill die )

    bad_news_words.each do |word|
      is_bad = @headline.downcase.include?(word.downcase)
      return false if is_bad
    end
    true
  end

end