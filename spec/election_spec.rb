require './spec/spec_helper'

RSpec.describe Election do
  before(:each) do
    @election = Election.new("2023")
    @race = Race.new("Texas Governor")
    @candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
    @candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})
    @race2 = Race.new("Colorado")
    @candidate3 = @race2.register_candidate!({name: "BB", party: :democrat})
    @candidate4 = @race2.register_candidate!({name: "CC", party: :republican})
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@election.year).to eq("2023")
      expect(@election.races).to eq([])
      # expect(@election.candidates).to eq([])
      # expect(@election.vote_counts).to eq({})
    end
  end
  
  describe '#add_race(race)' do
    it 'can add races' do
      @election.add_race(@race)
      expect(@election.races).to eq([@race])
      @election.add_race(@race2)
      expect(@election.races).to eq([@race, @race2])
    end
  end
  
  describe '#candidates' do 
    it 'can return an array of all candidates in an election' do
      expect(@election.candidates).to eq([])
      @election.add_race(@race)
      expect(@election.races).to eq([@race])
      expect(@election.candidates).to eq([@candidate1, @candidate2])
      @election.add_race(@race2)
      expect(@election.candidates).to eq([@candidate1, @candidate2, @candidate3, @candidate4])
    end
  end

  describe '#vote_counts' do
    it 'can return a  has with all candidates and their votes' do
      @election.add_race(@race)
      expect(@election.races).to eq([@race])
      expect(@election.vote_counts).to eq({"Diana D" => 0, "Roberto R" => 0})
      10.times { @candidate1.vote_for! }
      5.times { @candidate2.vote_for! }
      expect(@election.vote_counts).to eq({"Diana D" => 10, "Roberto R" => 5})
      @election.add_race(@race2)
      expect(@election.vote_counts).to eq({"Diana D" => 10, "Roberto R" => 5, "BB" => 0, "CC" => 0})
      10.times { @candidate1.vote_for! }
      5.times { @candidate2.vote_for! }
      10.times { @candidate3.vote_for! }
      5.times { @candidate4.vote_for! }
      expect(@election.vote_counts).to eq({"Diana D" => 20, "Roberto R" => 10, "BB" => 10, "CC" => 5})
    end
  end

  describe '#winners' do
    it 'can etermine the winners of all races' do
      @election.add_race(@race)
      expect(@election.races).to eq([@race])
      10.times { @candidate1.vote_for! }
      5.times { @candidate2.vote_for! }
      @election.add_race(@race2)
      10.times { @candidate1.vote_for! }
      5.times { @candidate2.vote_for! }
      10.times { @candidate3.vote_for! }
      5.times { @candidate4.vote_for! }
      @race.close!
      expect(@election.winners).to eq([@candidate1])
      @race2.close!
      expect(@election.winners).to eq([@candidate1, @candidate3])
    end
  end
end
      