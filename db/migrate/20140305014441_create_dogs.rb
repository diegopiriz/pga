class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :name
      t.date :birtdate
      t.date :admission
      t.string :primary_color
      t.string :secondary_color
      t.text :origin
      t.text :personality
      t.integer :size_id
      t.integer :status_id

      t.timestamps
    end
  end
end
