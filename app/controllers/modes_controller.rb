class ModesController < ApplicationController
  def select
    # Show mode selection screen
  end

  def choose
    mode = params[:mode]
    player_count = params[:player_count].to_i if mode == "group"

    # Store mode in session for next step
    session[:mode] = mode
    session[:player_count] = player_count if mode == "group"

    redirect_to galaxies_path
  end
end
