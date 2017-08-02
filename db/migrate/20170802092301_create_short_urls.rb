class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.string :title
      t.string :url
      t.string :short_url
      t.string :jmp_url

      t.timestamps null: false
    end
  end
end
