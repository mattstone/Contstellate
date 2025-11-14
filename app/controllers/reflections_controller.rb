class ReflectionsController < ApplicationController
  def index
    @sessions = Session.completed.recent.includes(:galaxies, :reflections)
    @total_reflections = Reflection.with_notes.count + Reflection.with_voice.count
  end

  def show
    @session = Session.find(params[:id])
    @reflections = @session.reflections.includes(:question).order(created_at: :asc)
    @visited_galaxies = @session.galaxies
  end
end
