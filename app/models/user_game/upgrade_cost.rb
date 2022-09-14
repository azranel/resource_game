class UserGame
  class UpgradeCost
    attr_reader :iron, :copper, :gold
    def initialize(iron:, copper:, gold:)
      @iron = iron
      @copper = copper
      @gold = gold
    end

    def can_afford?(user_game)
      user_game.iron_resources >= @iron && user_game.copper_resources >= @copper &&
        user_game.gold_resources >= @gold
    end

    def to_s
      "Iron: #{@iron}, Copper: #{@copper}, Gold: #{@gold}"
    end
  end
end