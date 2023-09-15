class Race
  attr_reader :office, :candidates
  def initialize(office)
    @office = office
    @candidates = []
    @open = true
  end

  def register_candidate!(candidate_hash)
    candidate = Candidate.new(candidate_hash)
    @candidates << candidate
    candidate
  end

  def open?
    @open
  end

  def close!
    @open = false
  end

  def winner
    return false if @open
    @candidates.max_by { |candidate| candidate.votes }
  end

  def tie?
    winners = @candidates.sort { |candidate| candidate.votes }
    winners[-1].votes == winners[-2].votes
  end

end