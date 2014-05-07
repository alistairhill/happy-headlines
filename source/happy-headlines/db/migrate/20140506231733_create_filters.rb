class CreateFilters < ActiveRecord::Migration
  def change
    create_table :filters do |table|
      table.string :bad_words
      table.string :good_words

      table.timestamps
    end
  end
end
