class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.string :description
      t.integer :low
      t.integer :high

      t.timestamps
    end
  end
end
