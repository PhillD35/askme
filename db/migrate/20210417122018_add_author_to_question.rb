class AddAuthorToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :author_id, :integer, foreign_key: {to_table: :users}
  end
end
