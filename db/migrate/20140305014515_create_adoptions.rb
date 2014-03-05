class CreateAdoptions < ActiveRecord::Migration
  def change
    create_table :adoptions do |t|
      t.integer :adopter_id
      t.integer :dog_id
      t.date :date

      t.timestamps
    end
  end
end
