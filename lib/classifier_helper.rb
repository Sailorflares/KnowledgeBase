class ClassifierHelper < Classifier::Bayes 

  def initialize(topic)
    @topic = topic
  end

strings = [ ["Want to learn about The Scientific Method? Go Bake Some Cookies", :relevant],
          ["Exploring the Scientific Method: Cases and Questions", :relevant],
          ["The Scientific Method: A Vampire Queen Novel (Volume 10)", :irrelevant],
          ["A Beginner's Guide to Scientific Method", :relevant]]
strings.each {|x| lsi.add_item x.first, x.last}

end