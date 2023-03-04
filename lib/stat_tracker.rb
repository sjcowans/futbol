require 'csv'
require_relative 'classes'
require_relative 'game_stats'
require_relative 'season_stats'
require_relative 'league_stats'
require_relative 'team_stats'

class StatTracker
  attr_reader :game_stats,
              :league_stats,
              :season_stats,
              :team_stats

  def self.from_csv(locations)
    new(locations)
  end

  def initialize(locations)
    @game_stats = GameStats.new(locations)
    @league_stats = LeagueStats.new(locations)
    @season_stats = SeasonStats.new(locations)
    @team_stats = TeamStats.new(locations)
  end

  ##### Game Statistics #####

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season
  end

  def average_goals_per_game
    @game_stats.average_goals_per_game
  end

  def average_goals_by_season
    @game_stats.average_goals_by_season
  end

  ##### League Statistics #####

  def count_of_teams
    @league_stats.count_of_teams
  end

  def best_offense
    @league_stats.best_offense
  end

  def worst_offense
    @league_stats.worst_offense
  end

  def highest_scoring_visitor
    @league_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_stats.lowest_scoring_home_team
  end

  ##### Season Statistics #####

  def winningest_coach(season_string)
    @season_stats.winningest_coach(season_string)
  end

  def worst_coach(season_string)
    @season_stats.worst_coach(season_string)
  end

  def most_accurate_team(season_string)
    @season_stats.most_accurate_team(season_string)
  end

  def least_accurate_team(season_string)
    @season_stats.least_accurate_team(season_string)
  end

  def most_tackles(season_string)
    @season_stats.most_team_tackles(season_string)
  end

  def fewest_tackles(season_string)
    @season_stats.least_team_tackles(season_string)
  end

  ##### Team Statistics #####

  def team_info(team_id)
    @team_stats.team_info(team_id)
  end

  def best_season(team_id)
    @team_stats.best_season(team_id)
  end

  def worst_season(team_id)
    @team_stats.worst_season(team_id)
  end

  def average_win_percentage(team_id)
    @team_stats.average_win_percentage(team_id)
  end

end