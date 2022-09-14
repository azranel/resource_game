class UserGame < ApplicationRecord
  validates :iron_resources, :copper_resources, :gold_resources,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :iron_factory_level, :copper_factory_level, :gold_factory_level,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
