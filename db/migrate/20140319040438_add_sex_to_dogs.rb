class AddSexToDogs < ActiveRecord::Migration
  def change
    add_column :dogs, :sex, :string
  end
end
