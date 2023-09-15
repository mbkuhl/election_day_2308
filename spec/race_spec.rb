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

  describe '#register_candidates' do
    it 'can register candidates' do
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      expect(candidate1.class).to eq(Candidate)
      expect(candidate1.name).to eq("Diana D")
      expect(candidate1.party).to eq(:democrat)
      expect(candidate1.votes).to eq(0)
      candidate2 = race.register_candidate!({name: "Roberto R", party: :republican})
      expect(@race.candidates).to eq([candidate1, candidate2])
    end
  end
end
