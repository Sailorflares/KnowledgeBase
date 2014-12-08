class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.string :category
      t.string :topic
      t.string :word
      t.integer :count, :default => 0

      t.timestamps
    end
  end
end
