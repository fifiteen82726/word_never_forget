class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.string :name
      t.text :description
      t.text :audio
      t.text :example
      t.integer :review_time

      t.timestamps
    end
  end
end
