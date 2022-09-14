class AddLastResourceUpdateAndFactoryUpdateTimestamps < ActiveRecord::Migration[7.0]
  def change
    add_column :user_games, :last_iron_resources_updated_at, :timestamp
    add_column :user_games, :last_copper_resources_updated_at, :timestamp
    add_column :user_games, :last_gold_resources_updated_at, :timestamp
    add_column :user_games, :last_iron_factory_upgrade_at, :timestamp
    add_column :user_games, :last_copper_factory_upgrade_at, :timestamp
    add_column :user_games, :last_gold_factory_upgrade_at, :timestamp
  end
end
