class UserGame
  class ProductionThroughput
    attr_reader :duration, :units

    def initialize(units:, duration:)
      @duration = duration
      @units = units
    end

    def to_s
      "#{@units} per #{@duration.value} #{@duration.parts.keys.first.to_s.pluralize(@duration.value)}"
    end
  end
end
