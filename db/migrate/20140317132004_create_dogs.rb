class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :name
      t.date :birthdate
      t.date :admission
      t.string :colors
      t.text :story
      t.string :personality
      t.integer :weight
      t.string :status

      t.timestamps
    end
  end
end
