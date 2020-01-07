class AddReadToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :read, :boolean, default: false
  end
end
