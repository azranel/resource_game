class UserGame
  class ProductionThroughput
    attr_reader :duration, :units

    def initialize(units:, duration:)
      @duration = duration
      @units = units
    end
  end
end
