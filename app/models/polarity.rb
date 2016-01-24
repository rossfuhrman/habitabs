class Polarity
  def self.polarity_class polarity
    return "positive" if polarity == POSITIVE
    return "negative" if polarity == NEGATIVE
    "neutral"
  end
end
