class CreateSourcefeeds < ActiveRecord::Migration
  def change
    create_table :sourcefeeds do |t|
      t.text :url
      t.string :name
      t.references :source, index: true
      t.references :city, index: true
      t.references :category
      t.timestamps
    end
  end
end
