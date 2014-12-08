require 'pry'

class Score < ActiveRecord::Base  

  def self.classify(topic, text)
    (self.classifications(topic, text).sort_by { |a| -a[1] })[0][0]
  end

  def self.classifications(topic, text)
    score = Hash.new
    training_count = Score.where(topic: topic).sum("count")
    ['relevant', 'irrelevant'].each do |category|
      score[category] = 0
      total = Score.where(topic: topic, category: category).sum("count")
      text.word_hash.each do |word, count|
        w = Score.where(topic: topic, category: category, word: word)
        w.size > 0 ? s = w.first.count : s = 0.1
        score[category] += Math.log(s/total.to_f)
      end
      c = Score.where(topic: topic, category: category)
      c.size > 0 ? s = c.sum("count") : s = 0.1
      score[category] += Math.log(s / training_count)
    end
    return score

  end

  def self.train (topic, category, text)
    text.word_hash.each do |word, count|
      score = Score.find_or_create_by(topic: topic, word: word, category: category)
      score.count += count
      score.save
    end
  end
end
