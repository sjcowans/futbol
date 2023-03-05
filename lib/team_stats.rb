require_relative 'classes'

class TeamStats < Classes
  def initialize(locations)
    super
    @seasons = ["20122013", "20132014", "20142015", "20152016", "20162017", "20172018"]
  end

  def team_info(team_id)
  info = nil
  @teams.each { |team| if team.team_id == team_id then info = team end }
  info_hash = {
    "team_id" => info.team_id,
    "franchise_id" => info.franchiseid,
    "team_name" => info.teamname,
    "abbreviation" => info.abbreviation,
    "link" => info.link
  }
  end
  
  def best_season(team_id)
    season_wins = Hash.new(0)
    season_total_games = Hash.new(0)
    @games.each do |game|
      if game.home == team_id
        season_total_games[game.season] += 1
        if game.home_goals > game.away_goals
          season_wins[game.season] += 1
        end
      elsif game.away == team_id
        season_total_games[game.season] += 1
        if game.home_goals < game.away_goals
          season_wins[game.season] += 1
        end
      end
    end
    season_win_loss = {}
    season_wins.each do |k,v|
      season_total_games.each do |k2, v2|
        if k == k2
          season_win_loss[k] = v.to_f / v2
        end
      end
    end
    season_win_loss.max_by { |k,v| v }[0]
  end

  def worst_season(team_id)
    season_wins = Hash.new(0)
    season_total_games = Hash.new(0)
    @games.each do |game|
      if game.home == team_id
        season_total_games[game.season] += 1
        if game.home_goals > game.away_goals
          season_wins[game.season] += 1
        end
      elsif game.away == team_id
        season_total_games[game.season] += 1
        if game.home_goals < game.away_goals
          season_wins[game.season] += 1
        end
      end
    end
    season_win_loss = {}
    season_wins.each do |k,v|
      season_total_games.each do |k2, v2|
        if k == k2
          season_win_loss[k] = v.to_f / v2
        end
      end
    end
    season_win_loss.min_by { |k,v| v }[0]
  end

  def average_win_percentage(team_id)
    total_games = Hash.new(0)
    wins = Hash.new(0)
    @games.each do |game|
      if game.home == team_id
        total_games[team_id] += 1
        if game.home_goals > game.away_goals
          wins[team_id] += 1
        end
      elsif game.away == team_id
        total_games[team_id] += 1
        if game.home_goals < game.away_goals
          wins[team_id] += 1
        end
      end
    end
    (wins[team_id].to_f / total_games[team_id]).round(2)
  end
end