class CreateKnowledgeBaseClassifiers < ActiveRecord::Migration
  def change
    create_table :knowledge_base_classifiers do |t|

      t.timestamps
    end
  end
end
