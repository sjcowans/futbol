require_relative 'classes'

class TeamStats < Classes
  def initialize(locations)
    super
    @seasons = ["20122013", "20132014", "20142015", "20152016", "20162017", "20172018"]
    @goals_scored = []
    @win_loss_by_team = {}
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

  def average_win_percentage(team_id, season = false, post_season = false)
    total_games = Hash.new(0)
    wins = Hash.new(0)
    if season == false 
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
    elsif season != false
      @games.each do |game|
        if game.home == team_id && game.season == season && post_season == false
          if game.type == "Regular Season"
            total_games[team_id] += 1
            if game.home_goals > game.away_goals
              wins[team_id] += 1
            end
          end
        elsif game.away == team_id && game.season == season && post_season == false
          if game.type == "Regular Season"
            total_games[team_id] += 1
            if game.home_goals < game.away_goals
              wins[team_id] += 1
            end
          end
        elsif game.away == team_id && game.season == season && post_season == true
          if game.type == "Postseason"
            total_games[team_id] += 1
            if game.home_goals < game.away_goals
              wins[team_id] += 1
            end
          end
        elsif game.away == team_id && game.season == season && post_season == true
          if game.type == "Postseason"
            total_games[team_id] += 1
            if game.home_goals < game.away_goals
              wins[team_id] += 1
            end
          end
        end
      end
      if total_games[team_id] == 0
        0
      else
      (wins[team_id].to_f / total_games[team_id]).round(2)
      end
    end
  end

  def most_goals_scored(team_id)
    @games.each do |game|
      if game.home == team_id
        @goals_scored << game.home_goals
      elsif game.away == team_id
        @goals_scored << game.away_goals
      end
    end
    @goals_scored.sort[-1]
  end

  def least_goals_scored(team_id)
    most_goals_scored(team_id)
    @goals_scored.sort[0]
  end

  def favorite_opponent(team_id)
    wins = Hash.new(0)
    total_games = Hash.new(0)
    @games.each do |game|
      if game.home == team_id
        total_games[game.away] += 1
        if game.home_goals > game.away_goals
          wins[game.away] += 1
        end
      elsif game.away == team_id
        total_games[game.home] += 1
        if game.home_goals < game.away_goals
          wins[game.home] += 1
        end
      end
    end
    wins.each do |k,v|
      @win_loss_by_team[k] = (v.to_f / total_games[k])
    end
    teamid = @win_loss_by_team.max_by { |k,v| v }[0]
    @teams.each { |team| if team.team_id == teamid then return team.teamname end }
    
  end

  def rival(team_id)
    favorite_opponent(team_id)
    teamid = @win_loss_by_team.min_by { |k,v| v }[0]
    @teams.each { |team| if team.team_id == teamid then return team.teamname end }
  end
  
  def biggest_blowout(team_id)
    @goal_diff = []
    @games.each do |game|
      if game.home == team_id
        @goal_diff << (game.home_goals - game.away_goals)
      elsif game.away == team_id
        @goal_diff << (game.away_goals - game.home_goals)
      end
    end
    @goal_diff.sort[-1]
  end

  def worst_loss(team_id)
    biggest_blowout(team_id)
    @goal_diff.sort[0]
  end

  def head_to_head(team_id)
    favorite_opponent(team_id)
    @win_loss_by_team
  end

  def seasonal_summary(team_id)
    seasonal_summary = {}
    @seasons.each do |season|
    seasonal_summary[:"#{season}"] = {:regular_season => { :win_percentage => average_win_percentage(team_id, season), 
                                                     :total_goals_scored => season_total_goals_scored(team_id, season), 
                                                     :total_goals_against => season_total_goals_against(team_id, season), 
                                                     :average_goals_scored => season_average_goals_scored(team_id, season), 
                                                     :average_goals_against => season_total_goals_against(team_id, season)
                                                    },
                                :post_season => { :win_percentage => average_win_percentage(team_id, season, true), 
                                                  :total_goals_scored => season_total_goals_scored(team_id, season, true), 
                                                  :total_goals_against => season_total_goals_against(team_id, season, true), 
                                                  :average_goals_scored => season_average_goals_scored(team_id, season, true), 
                                                  :average_goals_against => season_total_goals_against(team_id, season, true)
                                                }
                              }
    end
    seasonal_summary
  end

  def season_total_goals_scored(team_id, season = false, post_season = false, average = false)
    total_goals = Hash.new(0)
    total_games = Hash.new(0)
    @games.each do |game|
      if post_season == false && game.home == team_id && game.season == season 
        if game.type == "Regular Season" 
          total_games[team_id] += 1
          total_goals[team_id] += game.home_goals
        end
      elsif post_season == false && game.away == team_id && game.season == season 
        if game.type == "Regular Season" 
          total_games[team_id] += 1
          total_goals[team_id] += game.away_goals
        end
      elsif post_season == true && game.home == team_id && game.season == season 
        if game.type == "Postseason"
          total_games[team_id] += 1
          total_goals[team_id] += game.home_goals
        end
      elsif post_season == true && game.away == team_id && game.season == season 
        if game.type == "Postseason" 
          total_games[team_id] += 1
          total_goals[team_id] += game.away_goals
        end
      end
    end
    if average == false
      total_goals[team_id]
    elsif average == true && total_games[team_id] == 0
      0
    elsif average == true
      (total_goals[team_id].to_f / total_games[team_id]).round(2)
    end
  end

  def season_total_goals_against(team_id, season = false, post_season = false, average = false)
    total_goals = Hash.new(0)
    total_games = Hash.new(0)
    @games.each do |game|
      if post_season == false && game.home == team_id && game.season == season 
        if game.type == "Regular Season" 
          total_games[team_id] += 1
          total_goals[team_id] += game.away_goals
        end
      elsif post_season == false && game.away == team_id && game.season == season 
        if game.type == "Regular Season" 
          total_games[team_id] += 1
          total_goals[team_id] += game.home_goals
        end
      elsif post_season == true && game.home == team_id && game.season == season 
        if game.type == "Postseason"
          total_games[team_id] += 1
          total_goals[team_id] += game.away_goals
        end
      elsif post_season == true && game.away == team_id && game.season == season 
        if game.type == "Postseason" 
          total_games[team_id] += 1
          total_goals[team_id] += game.home_goals
        end
      end
    end
    if average == false
      total_goals[team_id]
    elsif average == true
      (total_goals[team_id].to_f / total_games[team_id]).round(2)
    end
  end

  def season_average_goals_scored(team_id, season = false, post_season = false)
    season_total_goals_scored(team_id, season, post_season, true)
  end

  def average_goals_against(team_id, season = false, post_season = false)
    season_total_goals_against(team_id, season, post_season, true)
  end
end