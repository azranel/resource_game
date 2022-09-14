class UserGame
  class Calculations
    IRON_FACTORY_SETTINGS = {
      1 => { production_threshold: ProductionThroughput.new(units: 10, duration: 1.second), upgrade_duration: 15.seconds, upgrade_cost: UpgradeCost.new(iron: 300, copper: 100, gold: 1) },
      2 => { production_threshold: ProductionThroughput.new(units: 20, duration: 1.second), upgrade_duration: 30.seconds, upgrade_cost: UpgradeCost.new(iron: 800, copper: 250, gold: 2) },
      3 => { production_threshold: ProductionThroughput.new(units: 40, duration: 1.second), upgrade_duration: 60.seconds, upgrade_cost: UpgradeCost.new(iron: 1600, copper: 500, gold: 4) },
      4 => { production_threshold: ProductionThroughput.new(units: 80, duration: 1.second), upgrade_duration: 90.seconds, upgrade_cost: UpgradeCost.new(iron: 3000, copper: 1000, gold: 8) },
      5 => { production_threshold: ProductionThroughput.new(units: 150, duration: 1.second), upgrade_duration: 120.seconds, upgrade_cost: nil }
    }
    COPPER_FACTORY_SETTINGS = {
      1 => { production_threshold: ProductionThroughput.new(units: 3, duration: 1.second), upgrade_duration: 15.seconds, upgrade_cost: UpgradeCost.new(iron: 200, copper: 70, gold: 0) },
      2 => { production_threshold: ProductionThroughput.new(units: 7, duration: 1.second), upgrade_duration: 30.seconds, upgrade_cost: UpgradeCost.new(iron: 400, copper: 150, gold: 0) },
      3 => { production_threshold: ProductionThroughput.new(units: 14, duration: 1.second), upgrade_duration: 60.seconds, upgrade_cost: UpgradeCost.new(iron: 800, copper: 300, gold: 0) },
      4 => { production_threshold: ProductionThroughput.new(units: 30, duration: 1.second), upgrade_duration: 90.seconds, upgrade_cost: UpgradeCost.new(iron: 1600, copper: 600, gold: 0) },
      5 => { production_threshold: ProductionThroughput.new(units: 60, duration: 1.second), upgrade_duration: 120.seconds, upgrade_cost: nil }
    }
    GOLD_FACTORY_SETTINGS = {
      1 => { production_threshold: ProductionThroughput.new(units: 2, duration: 1.minute), upgrade_duration: 15.seconds, upgrade_cost: UpgradeCost.new(iron: 0, copper: 100, gold: 2) },
      2 => { production_threshold: ProductionThroughput.new(units: 3, duration: 1.minute), upgrade_duration: 30.seconds, upgrade_cost: UpgradeCost.new(iron: 0, copper: 200, gold: 4) },
      3 => { production_threshold: ProductionThroughput.new(units: 4, duration: 1.minute), upgrade_duration: 60.seconds, upgrade_cost: UpgradeCost.new(iron: 0, copper: 400, gold: 8) },
      4 => { production_threshold: ProductionThroughput.new(units: 6, duration: 1.minute), upgrade_duration: 90.seconds, upgrade_cost: UpgradeCost.new(iron: 0, copper: 800, gold: 16) },
      5 => { production_threshold: ProductionThroughput.new(units: 8, duration: 1.minute), upgrade_duration: 120.seconds, upgrade_cost: nil }
    }

    def initialize(user_game:)
      @user_game = user_game
    end

    def calculate
      # TODO: Do calulcations over here
      # 1. Check upgrades in progress
      # 2. Check resources generation
      # 3. Update all the required fields
    end
  end
end