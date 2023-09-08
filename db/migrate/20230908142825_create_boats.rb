class CreateBoats < ActiveRecord::Migration[7.0]
  def change
    create_table :boats do |t|
      t.string :name
      t.string :first_skipper_name
      t.string :first_skipper_nationality
      t.string :second_skipper_name
      t.string :second_skipper_nationality
      t.string :category
      t.references :race, null: false, foreign_key: true

      t.timestamps
    end
  end
end
