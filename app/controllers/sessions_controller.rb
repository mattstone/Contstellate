class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :prompt, :next_question, :save_reflection, :skip_question, :constellation, :complete]

  def show
    redirect_to prompt_session_path(@session)
  end

  def prompt
    # Get the current question or fetch next one
    @current_question = get_current_question

    if @current_question.nil?
      # No more questions, go to constellation
      redirect_to constellation_session_path(@session) and return
    end

    @mode = @session.mode
    @player_count = @session.player_count
    @current_player = session[:current_player] || 1
    @galaxies_visited = @session.galaxies_visited
  end

  def next_question
    # Get next question
    @current_question = get_next_question

    if @current_question
      # Update current player for group mode
      if @session.group?
        current_player = session[:current_player] || 1
        session[:current_player] = current_player < @session.player_count ? current_player + 1 : 1
      end

      session[:current_question_id] = @current_question.id
      redirect_to prompt_session_path(@session)
    else
      # Session complete
      redirect_to constellation_session_path(@session)
    end
  end

  def save_reflection
    question_id = params[:question_id]
    note = params[:note]
    voice_recording_url = params[:voice_recording_url]

    reflection_type = determine_reflection_type(note, voice_recording_url)

    @session.reflections.create!(
      question_id: question_id,
      note: note,
      voice_recording_url: voice_recording_url,
      reflection_type: reflection_type
    )

    # Mark question as used
    question = Question.find(question_id)
    question.mark_as_used!

    # Add galaxy to session if not already added
    @session.add_galaxy(question.galaxy) unless @session.galaxies.include?(question.galaxy)

    # Clear current question and get next one
    session[:current_question_id] = nil
    next_q = get_next_question

    if next_q
      # Update current player for group mode
      if @session.group?
        current_player = session[:current_player] || 1
        session[:current_player] = current_player < @session.player_count ? current_player + 1 : 1
      end

      redirect_to prompt_session_path(@session)
    else
      # No more questions, go to constellation
      redirect_to constellation_session_path(@session)
    end
  end

  def skip_question
    question_id = params[:question_id]

    # Create a skip reflection
    @session.reflections.create!(
      question_id: question_id,
      reflection_type: "skip"
    )

    # Still mark as used
    Question.find(question_id).mark_as_used!

    # Clear current question and get next one
    session[:current_question_id] = nil
    next_q = get_next_question

    if next_q
      # Update current player for group mode
      if @session.group?
        current_player = session[:current_player] || 1
        session[:current_player] = current_player < @session.player_count ? current_player + 1 : 1
      end

      redirect_to prompt_session_path(@session)
    else
      # No more questions, go to constellation
      redirect_to constellation_session_path(@session)
    end
  end

  def constellation
    @session.complete! unless @session.completed_at

    @visited_galaxies = @session.galaxies
    @reflection_count = @session.reflections.count
    @reflections_with_content = @session.reflections.select(&:has_content?).count
  end

  def complete
    @session.complete!
    redirect_to reflections_path, notice: "Session completed! Your constellation has been saved."
  end

  private

  def set_session
    @session = Session.find(params[:id])
  end

  def get_current_question
    # Check if we have a current question in session
    if session[:current_question_id]
      question = Question.find_by(id: session[:current_question_id])
      if question.present?
        # Check if this question was already answered in this session
        already_answered = @session.reflections.exists?(question_id: question.id)
        if already_answered
          # Question already answered, clear it and get next
          session[:current_question_id] = nil
          return get_next_question
        end
        return question
      end

      # If question doesn't exist (e.g., DB was reseeded), clear the session
      session[:current_question_id] = nil
    end

    # Otherwise, get next question
    get_next_question
  end

  def get_next_question
    random_mode = session[:random_mode]
    selected_galaxy_id = session[:selected_galaxy_id]

    if random_mode
      # Random mode - get question from any galaxy
      rotation_service = QuestionRotationService.new(session: @session)
      question = rotation_service.next_question

      # Add the question's galaxy to visited galaxies
      @session.add_galaxy(question.galaxy) if question
    elsif selected_galaxy_id.present?
      # Specific galaxy mode
      galaxy = Galaxy.find(selected_galaxy_id)
      rotation_service = QuestionRotationService.new(session: @session, galaxy: galaxy)
      question = rotation_service.next_question
    else
      # No galaxy selected - use the first galaxy from the session
      galaxy = @session.galaxies.first
      if galaxy
        rotation_service = QuestionRotationService.new(session: @session, galaxy: galaxy)
        question = rotation_service.next_question
        # Store galaxy ID for future requests
        session[:selected_galaxy_id] = galaxy.id
      else
        # No galaxies at all - return nil to end session
        question = nil
      end
    end

    # Store in session
    session[:current_question_id] = question&.id

    question
  end

  def determine_reflection_type(note, voice_url)
    has_note = note.present?
    has_voice = voice_url.present?

    if has_note && has_voice
      "both"
    elsif has_voice
      "voice"
    elsif has_note
      "note"
    else
      "skip"
    end
  end
end
