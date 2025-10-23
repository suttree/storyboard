class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :text, null: false
      t.integer :position, null: false, default: 0
      t.timestamps
    end
    add_index :questions, :position
  end
end
