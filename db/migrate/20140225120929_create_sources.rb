class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :name
      t.string :alias
      t.text :homepage

      t.timestamps
    end
  end
end
