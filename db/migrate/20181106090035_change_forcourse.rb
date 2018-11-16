class ChangeForcourse < ActiveRecord::Migration
  def change
    add_column :courses,:course_degree,:string
  end
end
