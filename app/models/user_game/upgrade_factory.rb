class UserGame
  class UpgradeFactory
    VALID_FACTORY_TYPES = [:iron, :copper, :gold].freeze

    def initialize(user_game:, factory_type:)
      raise ArgumentError, 'wrong factory type' if VALID_FACTORY_TYPES.exclude?(factory_type.to_sym)

      @user_game = user_game
      @factory_type = factory_type.to_sym
    end

    def upgrade
      return false, 'already max level' if already_max_level?
      return false, 'upgrade currently in progress' if any_upgrade_in_progress?
      return false, 'cannot afford upgrade' unless can_afford_to_upgrade?

      upgrade_factory
      return true, nil
    end

    private

    def upgrade_factory
      if @factory_type == :iron
        @user_game.last_iron_factory_upgrade_at = Time.zone.now
      elsif @factory_type == :copper
        @user_game.last_copper_factory_upgrade_at = Time.zone.now
      elsif @factory_type == :gold
        @user_game.last_gold_factory_upgrade_at = Time.zone.now
      else
        raise StandardError, 'should never get here'
      end
      deduct_factory_costs
      @user_game.save!
    end

    def deduct_factory_costs
      @user_game.iron_resources -= factory_upgrade_cost.iron
      @user_game.copper_resources -= factory_upgrade_cost.copper
      @user_game.gold_resources -= factory_upgrade_cost.gold
    end

    def already_max_level?
      factory_settings = UserGame::FactorySettings.get_factory_settings_for_factory_type(@factory_type)
      current_factory_level = case @factory_type
                              when :iron then @user_game.iron_factory_level
                              when :copper then @user_game.copper_factory_level
                              when :gold then @user_game.gold_factory_level
                              end
      factory_settings.keys.max == current_factory_level
    end

    def any_upgrade_in_progress?
      @user_game.currently_upgrading_factory?
    end

    def can_afford_to_upgrade?
      factory_upgrade_cost.can_afford?(@user_game)
    end

    def factory_upgrade_cost
      @factory_upgrade_cost ||= begin
        factory_settings = UserGame::FactorySettings.get_factory_settings_for_factory_type(@factory_type)
        current_factory_level = case @factory_type
                                when :iron then @user_game.iron_factory_level
                                when :copper then @user_game.copper_factory_level
                                when :gold then @user_game.gold_factory_level
                                end
        factory_settings.fetch(current_factory_level).fetch(:upgrade_cost)
      end
    end
  end
end