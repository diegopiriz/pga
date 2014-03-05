class CreateAdopters < ActiveRecord::Migration
  def change
    create_table :adopters do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.text :address

      t.timestamps
    end
  end
end
