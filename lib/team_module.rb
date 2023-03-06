module SeasonTeams
  

  def convert_id_to_teamname(id_string)
    team = @teams.select{|team|team.team_id == id_string}
    team[0].teamname
  end

  def find_season_games(season_string)
    valid_game_ids = []
    @games.find_all do |game|
      if game.season == season_string
        valid_game_ids << game.id
      end
    end
    valid_game_ids
  end
end