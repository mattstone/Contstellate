class GalaxiesController < ApplicationController
  def index
    @galaxies = Galaxy.all
    @mode = session[:mode] || "solo"
  end

  def choose
    galaxy_id = params[:galaxy_id]
    mode = session[:mode] || "solo"
    player_count = session[:player_count] || 1

    # Create a new session
    @session = Session.create!(
      mode: mode,
      player_count: player_count,
      started_at: Time.current
    )

    # Add the selected galaxy
    galaxy = Galaxy.find(galaxy_id)
    @session.add_galaxy(galaxy)

    # Store session ID for use in question flow
    session[:current_session_id] = @session.id
    session[:selected_galaxy_id] = galaxy_id

    redirect_to prompt_session_path(@session)
  end

  def random
    mode = session[:mode] || "solo"
    player_count = session[:player_count] || 1

    # Create a new session
    @session = Session.create!(
      mode: mode,
      player_count: player_count,
      started_at: Time.current
    )

    # Mark as random mode (we'll select galaxies as we go)
    session[:current_session_id] = @session.id
    session[:random_mode] = true
    session[:selected_galaxy_id] = nil

    redirect_to prompt_session_path(@session)
  end
end
