class QuestionRotationService
  attr_reader :session, :galaxy

  def initialize(session:, galaxy: nil)
    @session = session
    @galaxy = galaxy
  end

  # Get next question(s) for the session
  # Returns 1-2 questions depending on session state
  def next_questions(count: 1)
    if @galaxy
      # Specific galaxy mode
      get_questions_for_galaxy(@galaxy, count)
    else
      # Random mode - mix questions from different galaxies
      get_random_questions(count)
    end
  end

  # Get a single next question
  def next_question
    next_questions(count: 1).first
  end

  private

  def get_questions_for_galaxy(galaxy, count)
    # Get questions from this galaxy that haven't been asked in this session
    already_asked_ids = session.reflections.pluck(:question_id)

    available_questions = galaxy.questions
      .where.not(id: already_asked_ids)
      .least_used
      .limit(count)

    # If we've asked all questions from this galaxy in this session,
    # reset and get least used overall
    if available_questions.empty?
      available_questions = galaxy.questions.least_used.limit(count)
    end

    available_questions.to_a
  end

  def get_random_questions(count)
    # Get questions from galaxies not yet visited in this session, if possible
    visited_galaxy_ids = session.galaxies.pluck(:id)
    already_asked_ids = session.reflections.pluck(:question_id)

    # Try to get questions from unvisited galaxies first
    unvisited_questions = Question
      .where.not(galaxy_id: visited_galaxy_ids)
      .where.not(id: already_asked_ids)
      .least_used
      .limit(count)

    if unvisited_questions.size >= count
      return unvisited_questions.to_a
    end

    # If not enough unvisited questions, get any unused questions
    Question
      .where.not(id: already_asked_ids)
      .least_used
      .limit(count)
      .to_a
  end

  # Check if there are more questions available
  def has_more_questions?
    if @galaxy
      @galaxy.questions.count > session.reflections.count
    else
      Question.count > session.reflections.count
    end
  end

  # Get a random galaxy that hasn't been visited yet
  def self.random_unvisited_galaxy(session)
    visited_galaxy_ids = session.galaxies.pluck(:id)

    Galaxy.where.not(id: visited_galaxy_ids).order("RANDOM()").first ||
      Galaxy.order("RANDOM()").first
  end
end
