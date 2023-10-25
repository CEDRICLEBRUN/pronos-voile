class CreateTotalScores < ActiveRecord::Migration[7.0]
  def change
    create_table :total_scores do |t|
      t.integer :points
      t.references :user, null: false, foreign_key: true
      t.references :race, null: false, foreign_key: true

      t.timestamps
    end
  end
end
