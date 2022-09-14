class CreateUserGames < ActiveRecord::Migration[7.0]
  def change
    create_table :user_games do |t|
      t.references :user
      t.integer :iron_resources, default: 0
      t.integer :cooper_resources, default: 0
      t.integer :gold_resources, default: 0
      t.integer :iron_factory_level, default: 1
      t.integer :cooper_factory_level, default: 1
      t.integer :gold_factory_level, default: 1

      t.timestamps
    end
  end
end
