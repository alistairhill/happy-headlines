module Filter

  def self.filter_headlines(raw_headline_array)
    # clean_array = []
    raw_headline_array.map do |readline|
      split_headline = readline.split(' ')

      good_news_headline = split_headline.select do |word|
        bad_news.include?(word)
      end
      unless good_news_headline.length >= 1
        NewsItem.good = true
        # clean_array << raw_headline_array
      end

      # p clean_array.flatten
    end
  end


### you might be able to put this in the seed file? not sure about that though...
  def self.bad_news
    bad_news_words_array = %w(worry bomb blast murder
    murdered killed stabbed beaten death burst nazi war
    warcrimes abuse withers Putin NSA Snowden politician
    climate suffering burned horrible terrible bad ugly
    Ukraine corrupt WHO same-sex die )
  end

  def self.good_news
    good_news_words_array = %w(happy peace great good
      rescued saved exonerated extension peace released
      peaceful )
  end

end

Filter.filter_headlines(["the murder candy store is great"])
