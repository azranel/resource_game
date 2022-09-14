class ChangeColumnTypesForLastUpdatedFields < ActiveRecord::Migration[7.0]
  def change
    change_column :user_games, :last_iron_resources_updated_at, :datetime
    change_column :user_games, :last_copper_resources_updated_at, :datetime
    change_column :user_games, :last_gold_resources_updated_at, :datetime
    change_column :user_games, :last_iron_factory_upgrade_at, :datetime
    change_column :user_games, :last_copper_factory_upgrade_at, :datetime
    change_column :user_games, :last_gold_factory_upgrade_at, :datetime
  end
end
