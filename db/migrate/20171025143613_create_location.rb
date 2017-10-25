class CreateLocation < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.st_polygon :area, geographic: true, srid: 4326

      t.timestamps null: false
    end

    change_table :locations do |t|
      t.index :area, using: :gist
    end
  end
end
