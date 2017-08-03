class AddClickToShortUrls < ActiveRecord::Migration
  def change
    add_column :short_urls, :clicks, :integer
  end
end
