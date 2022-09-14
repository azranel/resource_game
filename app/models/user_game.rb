class UserGame < ApplicationRecord
  validates :iron_resources, :copper_resources, :gold_resources,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :iron_factory_level, :copper_factory_level, :gold_factory_level,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  def factory_throughput(type)
    current_factory_level = case type
                            when :iron then iron_factory_level
                            when :copper then copper_factory_level
                            when :gold then gold_factory_level
                            end
    FactorySettings.get_factory_settings_for_factory_type(type)[current_factory_level][:production_throughput]
  end

  def factory_upgrade_costs(type)
    current_factory_level = case type
                            when :iron then iron_factory_level
                            when :copper then copper_factory_level
                            when :gold then gold_factory_level
                            end
    FactorySettings.get_factory_settings_for_factory_type(type)[current_factory_level][:upgrade_cost]
  end

  def currently_upgrading_factory?
    last_iron_factory_upgrade_at ||
      last_copper_factory_upgrade_at ||
      last_gold_factory_upgrade_at
  end

  def remaining_factory_upgrade_time(type, current_factory_level)
    upgrade_duration = FactorySettings.get_factory_settings_for_factory_type(type)[current_factory_level][:upgrade_duration]
    upgrade_started_at = case type
                         when :iron then last_iron_factory_upgrade_at
                         when :copper then last_copper_factory_upgrade_at
                         when :gold then last_gold_factory_upgrade_at
                         end
    now = Time.zone.now
    (upgrade_started_at + upgrade_duration) - now
  end
end
