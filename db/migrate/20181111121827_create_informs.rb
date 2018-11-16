class CreateInforms < ActiveRecord::Migration
  def change
    create_table :informs do |t|
      t.string :name
      t.string :context

      t.timestamps null: false
    end
  end
end
