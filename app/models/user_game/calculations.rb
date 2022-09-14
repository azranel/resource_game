class UserGame
  class Calculations
    def initialize(user_game:)
      @user_game = user_game
    end

    def calculate!
      now = Time.zone.now

      # 1. Check upgrades in progress
      check_iron_factory_upgrades(now)
      check_copper_factory_upgrades(now)
      check_gold_factory_upgrades(now)
      # 2. Check resources generation
      add_iron_resources(now)
      add_copper_resources(now)
      add_gold_resources(now)
      # 3. Update all the required fields
      @user_game.save!
    end

    private

    def check_iron_factory_upgrades(now)
      factory_settings = UserGame::FactorySettings.get_factory_settings_for_factory_type(:iron)
      upgrade_duration = factory_settings.fetch(@user_game.iron_factory_level).fetch(:upgrade_duration)

      if check_factory_upgrades(now, @user_game.last_iron_factory_upgrade_at, upgrade_duration)
        @user_game.iron_factory_level += 1
        @user_game.last_iron_factory_upgrade_at = nil
      end
    end

    def check_copper_factory_upgrades(now)
      factory_settings = UserGame::FactorySettings.get_factory_settings_for_factory_type(:copper)
      upgrade_duration = factory_settings.fetch(@user_game.copper_factory_level).fetch(:upgrade_duration)

      if check_factory_upgrades(now, @user_game.last_copper_factory_upgrade_at, upgrade_duration)
        @user_game.copper_factory_level += 1
        @user_game.last_copper_factory_upgrade_at = nil
      end
    end

    def check_gold_factory_upgrades(now)
      factory_settings = UserGame::FactorySettings.get_factory_settings_for_factory_type(:gold)
      upgrade_duration = factory_settings.fetch(@user_game.gold_factory_level).fetch(:upgrade_duration)

      if check_factory_upgrades(now, @user_game.last_gold_factory_upgrade_at, upgrade_duration)
        @user_game.gold_factory_level += 1
        @user_game.last_gold_factory_upgrade_at = nil
      end
    end

    def add_iron_resources(now)
      factory_settings = UserGame::FactorySettings.get_factory_settings_for_factory_type(:iron)
      throughput = factory_settings.fetch(@user_game.iron_factory_level).fetch(:production_throughput)
      return if ((now - @user_game.last_iron_resources_updated_at) / throughput.duration).floor.zero?

      @user_game.iron_resources += calculate_generated_resources_since_last_update(now, @user_game.last_iron_resources_updated_at, throughput)
      @user_game.last_iron_resources_updated_at = now
    end

    def add_copper_resources(now)
      factory_settings = UserGame::FactorySettings.get_factory_settings_for_factory_type(:copper)
      throughput = factory_settings.fetch(@user_game.copper_factory_level).fetch(:production_throughput)
      return if ((now - @user_game.last_copper_resources_updated_at) / throughput.duration).floor.zero?

      @user_game.copper_resources += calculate_generated_resources_since_last_update(now, @user_game.last_copper_resources_updated_at, throughput)
      @user_game.last_copper_resources_updated_at = now
    end

    def add_gold_resources(now)
      factory_settings = UserGame::FactorySettings.get_factory_settings_for_factory_type(:gold)
      throughput = factory_settings.fetch(@user_game.gold_factory_level).fetch(:production_throughput)
      return if ((now - @user_game.last_gold_resources_updated_at) / throughput.duration).floor.zero?

      @user_game.gold_resources += calculate_generated_resources_since_last_update(now, @user_game.last_gold_resources_updated_at, throughput)
      @user_game.last_gold_resources_updated_at = now
    end

    def calculate_generated_resources_since_last_update(now, last_resource_updated_at, current_throughput)
      time_difference = ((now - last_resource_updated_at) / current_throughput.duration).floor
      current_throughput.units * time_difference
    end

    def check_factory_upgrades(now, last_factory_upgrade_at, upgrade_duration)
      return false if last_factory_upgrade_at.nil?

      (now - last_factory_upgrade_at) > upgrade_duration
    end
  end
end