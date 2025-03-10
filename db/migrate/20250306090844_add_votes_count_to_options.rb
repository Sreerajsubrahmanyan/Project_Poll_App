class AddVotesCountToOptions < ActiveRecord::Migration[8.0]
  def change
    add_column :options, :votes_count, :integer, default: 0, null: false
  end
end
