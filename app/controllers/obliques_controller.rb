class ObliquesController < ApplicationController
  def show
    @strategy = random_strategy
  end

  def random
    redirect_to oblique_path
  end

  private

  def random_strategy
    strategies = load_strategies
    strategies.sample
  end

  def load_strategies
    file_path = Rails.root.join('data', 'constellate_strategies.txt')
    content = File.read(file_path)

    # Split by "---" delimiter and clean up
    strategies = content.split(/^---$/).map(&:strip).reject(&:empty?)

    # Remove the header section (first element with # and ##)
    strategies.reject { |s| s.start_with?('#') || s.start_with?('Inspired by') }
  end
end
