require 'rails_helper'

describe UserGame::UpgradeFactory do
  describe '#upgrade' do
    subject(:upgrade) { described_class.new(user_game: user_game, factory_type: factory_type).upgrade }

    context 'when factory is already at max level' do
      let(:user_game) { UserGame.new(iron_factory_level: 5) }
      let(:factory_type) { :iron }

      it 'returns false and a message' do
        ok, msg = upgrade
        expect(ok).to eq(false)
        expect(msg).to eq('already max level')
      end
    end

    context 'when another upgrade is in progress' do
      let(:user_game) { UserGame.new(last_copper_factory_upgrade_at: Time.zone.now) }
      let(:factory_type) { :iron }

      it 'returns false and a message' do
        ok, msg = upgrade
        expect(ok).to eq(false)
        expect(msg).to eq('upgrade currently in progress')
      end
    end

    context 'when cannot afford upgrade' do
      let(:user_game) { UserGame.new(iron_resources: 0, copper_resources: 0, gold_resources: 0, iron_factory_level: 1) }
      let(:factory_type) { :iron }

      it 'returns false and a message' do
        ok, msg = upgrade
        expect(ok).to eq(false)
        expect(msg).to eq('cannot afford upgrade')
      end
    end

    context 'when can afford and there is no other upgrade in progress' do
      let(:user_game) { UserGame.new(iron_resources: 1000, copper_resources: 1000, gold_resources: 1000, iron_factory_level: 1) }
      let(:factory_type) { :iron }

      it 'returns true' do
        ok, msg = upgrade
        expect(ok).to eq(true)
        expect(msg).to be_nil
      end

      it 'marks last factory upgrade at timestamp' do
        upgrade
        expect(user_game.last_iron_factory_upgrade_at).not_to be_nil
      end
    end
  end
end
