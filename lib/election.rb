class Election
  attr_reader :year, :races
  def initialize(year)
    @year = year
    @races = []
  end

  def add_race(race)
    races << race
  end

  def candidates
    races.reduce([]) { |candidates, race| candidates << race.candidates }.flatten
  end
  
  def vote_counts
    votes_hash = Hash.new
    candidates.each do |candidate|
      votes_hash[candidate.name] = candidate.votes
    end
    votes_hash
  end

  def winners
    winners = []
    races.each do |race|
      (winners << race.winner) if !race.open?
    end
    winners
  end
end