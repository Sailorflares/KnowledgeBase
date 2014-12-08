class KnowledgeBaseClassifier < ActiveRecord::Base

  #def initialize(topic)
  #  @topic = topic
  #  @classifier = Classifier::Bayes.new 'relevant', 'irrelevant' #problem with persisting the classifier
  #end
=begin  
  def upvote(title)
    @classifier.add_item(title, :relevant)
  end

  def downvote(title)
    @classifier.add_item(title, :irrelevant)
  end
=end
  def classify(text)
  end

  def classifications(text)

  end

  def train (category, text)

  end
end
