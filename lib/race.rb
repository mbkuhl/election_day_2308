class Race
  attr_reader :office, :candidates
  def initialize(office)
    @office = office
    @candidates = []
  end

  def register_candidate!(candidate_hash)
    candidate = Candidate.new(candidate_hash)
    @candidates << candidate
    candidate
  end
end