class CreateVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.references :visitor, foreign_key: true
      t.references :url, foreign_key: true
      t.timestamps
    end
  end
end
