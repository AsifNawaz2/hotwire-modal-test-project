# frozen_string_literal: true

# Post table migration
#
class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, unique: true
      t.text :body

      t.index :title, unique: true

      t.timestamps
    end
  end
end
