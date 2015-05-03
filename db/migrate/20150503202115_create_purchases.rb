class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :purchaser, index: true, foreign_key: true
      t.references :book, index: true,      foreign_key: true

      t.timestamps null: false
    end
  end
end
