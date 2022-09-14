require 'rails_helper'

describe UserGame::UpgradeCost do
  describe '#can_afford?' do
    context 'when cost is too high' do
      it 'returns false' do
        upgrade_cost = described_class.new(iron: 100, copper: 200, gold: 300)
        user_game = UserGame.new(iron_resources: 101, copper_resources: 201, gold_resources: 299)
        expect(upgrade_cost.can_afford?(user_game)).to eq(false)
      end
    end

    context 'when cost is lower than available resources' do
      it 'returns true' do
        upgrade_cost = described_class.new(iron: 100, copper: 200, gold: 300)
        user_game = UserGame.new(iron_resources: 101, copper_resources: 201, gold_resources: 301)
        expect(upgrade_cost.can_afford?(user_game)).to eq(true)
      end
    end
  end

  describe '#to_s' do
    it 'returns nice string of upgrade cost' do
      upgrade_cost = described_class.new(iron: 100, copper: 200, gold: 300)
      expect(upgrade_cost.to_s).to eq("Iron: 100, Copper: 200, Gold: 300")
    end
  end
end
