class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.text :title
      t.text :summary
      t.text :content
      t.text :url
      t.attachment :picture
      t.timestamp :date
      t.references :category 
      t.references :sourcefeed
      t.references :source
      t.references :city
      t.timestamps
    end
  end
end
