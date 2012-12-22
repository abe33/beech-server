class CreateBeerColors < ActiveRecord::Migration
  def change
    create_table :beer_colors do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end
  end
end
