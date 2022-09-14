class RenameUserGameCooperFields < ActiveRecord::Migration[7.0]
  def change
    rename_column :user_games, :cooper_resources, :copper_resources
    rename_column :user_games, :cooper_factory_level, :copper_factory_level
  end
end
