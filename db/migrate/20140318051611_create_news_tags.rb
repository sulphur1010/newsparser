class CreateNewsTags < ActiveRecord::Migration
  def change
    create_table :news_tags do |t|
      t.references :news, index: true
      t.references :tag, index: true

      t.timestamps
    end
    add_index :news_tags, [:news_id, :tag_id]
    

  end
end
