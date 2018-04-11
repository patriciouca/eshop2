class CreateDirectors < ActiveRecord::Migration
  def change
    create_table :directors do |t|
      t.string :first_name
      t.string :last_name
      t.timestamps :null => false
    end
  end
end
