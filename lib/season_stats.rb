require_relative 'classes'

class SeasonStats < Classes

  def initialize(locations)
    super
  end
  
  def total_team_tackles
    total_team_tackles_hash = Hash.new(0)
    @game_teams.each do |team|
      total_team_tackles_hash[team.team_id] += team.tackles
    end
    total_team_tackles_hash
  end

  def most_team_tackles
    team_id = total_team_tackles.max_by { |k, v| v }[0]
    @teams.each do |team|
      if team.team_id == team_id
        team_id = team.teamname
      end
    end
    team_id
  end

  def least_team_tackles
    team_id = total_team_tackles.min_by { |k, v| v }[0]
    @teams.each do |team|
      if team.team_id == team_id
        team_id = team.teamname
      end
    end
    team_id
  end

  def total_team_tackles(team_by_year)
    total_team_tackles_hash = Hash.new(0)
    team_by_year.each do |team|
      total_team_tackles_hash[team[0].team_id] += team[0].tackles
    end
    total_team_tackles_hash
  end

  def games_by_season(date)
    team_by_year = {}
    @games.each do |k , v| 
      if k.season == date
        @game_teams.each do |k2, v2|
          if k2.game_id == k.id
            team_by_year[k2] = v2
          end
        end
      end
    end
    team_by_year
  end

  def most_team_tackles(date)
    team_by_year = games_by_season(date)
    team_id = total_team_tackles(team_by_year).max_by { |k, v| v }[0]
    team_by_year.each do |team|
      if team[0].team_id == team_id
        @teams.each do |k, v|
          if k.team_id == team[0].team_id
            team_id = k.teamname
          end
        end
      end
    end
    team_id
  end

  def least_team_tackles(date)
    team_by_year = games_by_season(date)
    team_id = total_team_tackles(team_by_year).min_by { |k, v| v }[0]
    team_by_year.each do |team|
      if team[0].team_id == team_id
        @teams.each do |k, v|
          if k.team_id == team[0].team_id
            team_id = k.teamname
          end
        end
      end
    end
    team_id
  end

  def convert_id_to_teamname(id_string)
    team = @teams.select{|team|team.team_id == id_string}
    team[0].teamname
  end
  #Helper method for most/least accurate team   
  def gather_goals_info(season_string)
    infohash = Hash.new(0)
    @games.each do |game|
      if game.season == season_string
        infohash[game.away] += game.away_goals
        infohash[game.home] += game.home_goals
      end
    end
    infohash
  end
  #Helper method for most/least accurate team
  def gather_shots_info(season_string)
    valid_game_ids = []
    @games.each do |game|
      if game.season == season_string
        valid_game_ids << game.id
      end
    end

    infohash = Hash.new(0)
    @game_teams.each do |game|
      if valid_game_ids.include?(game.game_id)
        infohash[game.team_id] += game.shots
      end
    end
    infohash
  end
  #Helper method for most/least accurate team
  def sort_by_accuracy(season_string)
    shots_info = gather_shots_info(season_string)
    goals_info = gather_goals_info(season_string)
    
    merged = shots_info.merge(goals_info){|key,oldval,newval| (oldval.to_f / newval.to_f).round(3) }
    merged = merged.sort_by { |_,v| v }
    merged
  end

  def most_accurate_team(season_string)
    array = sort_by_accuracy(season_string)
    team_id = array.first[0]
    convert_id_to_teamname(team_id)
  end

  def least_accurate_team(season_string)
    array = sort_by_accuracy(season_string)
    team_id = array.last[0]
    convert_id_to_teamname(team_id)
  end
end