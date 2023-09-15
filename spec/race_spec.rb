require './spec/spec_helper'

RSpec.describe Race do
  before(:each) do
    @race = Race.new("Texas Governor")
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@race.office).to eq("Texas Governor")
      expect(@race.candidates).to eq([])
    end
  end

  describe '#register_candidate!' do
    it 'can register candidates' do
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      expect(candidate1.class).to eq(Candidate)
      expect(candidate1.name).to eq("Diana D")
      expect(candidate1.party).to eq(:democrat)
      expect(candidate1.votes).to eq(0)
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
      expect(@race.candidates).to eq([candidate1, candidate2])
    end
  end

  describe '#open? and #close!' do
    it 'can tell if a race is still open' do
      expect(@race.open?).to be true
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
      expect(@race.open?).to be true
    end

    it 'can close a race' do
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
      @race.close!
      expect(@race.open?).to be false
    end
  end

  describe '#winner and #tie?' do
    it 'can show the winner of a race or false if open' do
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
      candidate1.vote_for!
      expect(@race.winner).to be false
      @race.close!
      expect(@race.winner).to eq(candidate1)
    end

    it 'can show if there was a tie' do
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
      candidate1.vote_for!
      candidate2.vote_for!
      @race.close!
      expect(@race.tie?).to be true
    end

    it 'can show if there was not a tie' do
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
      candidate1.vote_for!
      @race.close!
      expect(@race.tie?).to be false
    end
end
