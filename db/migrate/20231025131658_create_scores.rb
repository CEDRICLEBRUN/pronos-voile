class CreateScores < ActiveRecord::Migration[7.0]
  def change
    create_table :scores do |t|
      t.text :points_by_category
      t.references :user, null: false, foreign_key: true
      t.references :race, null: false, foreign_key: true

      t.timestamps
    end
  end
end
