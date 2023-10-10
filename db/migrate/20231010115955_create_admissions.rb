class CreateAdmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :admissions do |t|
      t.string :status, default: 'pending'
      t.references :user, null: false, foreign_key: true
      t.references :crew, null: false, foreign_key: true

      t.timestamps
    end
  end
end
