require 'spec_helper'
require 'csv'

describe StatTracker do
  let(:game_path) { './data/short_games.csv' }
  let(:team_path) { './data/teams.csv' }
  let(:game_teams_path) { './data/short_game_teams.csv' }
  let(:locations) do {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }
end
let(:stat_tracker) { StatTracker.from_csv(locations) }

  it 'can import shortened game data' do
    expect(stat_tracker.game_stats.games).to be_instance_of(Array)
    expect(stat_tracker.game_stats.games.length).to eq(15)
  end

  it 'can import shortened game_team data' do
    expect(stat_tracker.league_stats.game_teams).to be_instance_of(Array)
    expect(stat_tracker.league_stats.game_teams.length).to eq(30)
  end

  it 'can import team data' do
    expect(stat_tracker.season_stats.teams).to be_instance_of(Array)
    expect(stat_tracker.season_stats.teams.length).to eq(32)
  end

  it 'can list #home_wins' do
    expect(stat_tracker.game_stats.home_wins).to eq(7)
  end

  it 'can list #away_wins' do
    expect(stat_tracker.game_stats.away_wins).to eq(7)
  end

  it 'can list #ties' do
    expect(stat_tracker.game_stats.ties).to eq(1)
  end

  it 'can list #total_games' do
    expect(stat_tracker.game_stats.total_games).to eq(15)
  end

  it 'can list #percentage_home_wins' do
    expect(stat_tracker.game_stats.percentage_home_wins).to eq(0.47)
  end

  it 'can list #percentage_visitor_wins' do
    expect(stat_tracker.game_stats.percentage_visitor_wins).to eq(0.47)
  end

  it 'can list #percentage_ties' do
    expect(stat_tracker.game_stats.percentage_ties).to eq(0.07)
  end

  it 'can list #total_scores' do
    expect(stat_tracker.game_stats.total_scores).to eq(
      [1, 3, 3, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5])
  end

  it 'can list #highest_total_score' do
    expect(stat_tracker.game_stats.highest_total_score).to eq(5)
  end

  it 'can list #lowest_total_score' do
    expect(stat_tracker.game_stats.lowest_total_score).to eq(1)
  end

  it 'can list #count_of_games_by_season' do
    expect(stat_tracker.game_stats.count_of_games_by_season).to eq({"20122013" => 10,
                                                                    "20132014" => 3,
                                                                    "20152016" => 1,
                                                                    "20162017" => 1,})
  end

  it 'can list #average_goals_per_game' do
    expect(stat_tracker.game_stats.average_goals_per_game).to eq(4.07)
  end

  it 'can list #average_goals_by_season' do
    expect(stat_tracker.game_stats.average_goals_by_season).to eq({"20122013" => 3.9, 
                                                                   "20132014" => 5.0,
                                                                   "20152016" => 4.0,
                                                                   "20162017" => 3.0})
  end

  it 'can list #goals_per_season' do
    expect(stat_tracker.game_stats.goals_per_season).to eq({"20122013" => 39,
                                                            "20132014" => 15,
                                                            "20152016" => 4,
                                                            "20162017" => 3,})
  end

  it 'can list #games_per_season' do
    expect(stat_tracker.game_stats.games_per_season).to eq({"20122013" => 10,
                                                            "20132014" => 3,
                                                            "20152016" => 1,
                                                            "20162017" => 1,})
  end

  it 'can list #count_of_teams' do
    expect(stat_tracker.league_stats.count_of_teams).to eq(32)
  end

  it 'can list #best_offense' do
    expect(stat_tracker.league_stats.best_offense).to eq("FC Dallas")
  end

  it 'can list #worst_offense' do
    expect(stat_tracker.league_stats.worst_offense).to eq("Sporting Kansas City")
  end

  it 'can #convert_id_to_teamname' do
    expect(stat_tracker.league_stats.convert_id_to_teamname("3")).to eq("Houston Dynamo")
    expect(stat_tracker.league_stats.convert_id_to_teamname("4")).to eq("Chicago Fire")
    expect(stat_tracker.league_stats.convert_id_to_teamname("5")).to eq("Sporting Kansas City")
    expect(stat_tracker.league_stats.convert_id_to_teamname("6")).to eq("FC Dallas")
  end

  it 'can list #average_goals_per_team' do
    expect(stat_tracker.league_stats.average_goals_per_team).to eq({"3" => 1.75,
                                                                    "5" => 1.5,
                                                                    "6" => 2.5,})
  end

  it 'can list #goals_per_team' do
    expect(stat_tracker.league_stats.goals_per_team).to eq({"3" => 14,
                                                            "5" => 12,
                                                            "6" => 35})
  end

  it 'can list #games_per_team' do
    expect(stat_tracker.league_stats.games_per_team).to eq({"3" => 8,
                                                            "5" => 8,
                                                            "6" => 14,})
  end

  it 'can list #home_goals_per_team' do
    expect(stat_tracker.league_stats.home_goals_per_team).to eq({"3" => 3,
                                                                 "5" => 3,
                                                                 "6" => 23})
  end

  it 'can list #away_goals_per_team' do
    expect(stat_tracker.league_stats.away_goals_per_team).to eq({"3" => 11,
                                                                 "5" => 9,
                                                                 "6" => 12})
  end

  it 'can list #home_games_per_team' do
    expect(stat_tracker.league_stats.home_games_per_team).to eq({"3" => 2,
                                                                 "5" => 3,
                                                                 "6" => 10,})
  end

  it 'can list #away_games_per_team' do
    expect(stat_tracker.league_stats.away_games_per_team).to eq({"3" => 6,
                                                                 "5" => 5,
                                                                 "6" => 4,})
  end

  it 'can list #highest_scoring_home_team' do
    expect(stat_tracker.league_stats.highest_scoring_home_team).to eq("FC Dallas")
  end

  it 'can list #highest_scoring_visitor' do
    expect(stat_tracker.league_stats.highest_scoring_visitor).to eq("FC Dallas")
  end

  it 'can list #highest_scoring_away_team' do
    expect(stat_tracker.league_stats.highest_scoring_away_team).to eq("FC Dallas")
  end

  it 'can list #lowest_scoring_home_team' do
    expect(stat_tracker.league_stats.lowest_scoring_home_team).to eq("Sporting Kansas City")
  end

  it 'can list #lowest_scoring_visitor' do
    expect(stat_tracker.league_stats.lowest_scoring_visitor).to eq("Sporting Kansas City")
  end

  it 'can list #games_by_season' do
    season1 = stat_tracker.season_stats.games_by_season("20132014")
    season2 = stat_tracker.season_stats.games_by_season("20142015")
    season3 = stat_tracker.season_stats.games_by_season("20152016")

    expect(season1).to be_instance_of(Hash)
    expect(season1.length).to eq(6)

    expect(season2).to be_instance_of(Hash)
    expect(season2.length).to eq(0)

    expect(season3).to be_instance_of(Hash)
    expect(season3.length).to eq(2)
  end

  it 'can list #total_team_tackles' do
    season1 = stat_tracker.season_stats.games_by_season("20132014")
    season3 = stat_tracker.season_stats.games_by_season("20152016")

    expect(stat_tracker.season_stats.total_team_tackles(season1)).to eq({"3" => 33,
                                                                         "5" => 71,
                                                                         "6" => 85,})

    expect(stat_tracker.season_stats.total_team_tackles(season3)).to eq({"3" => 57,
                                                                         "5" => 25,})
  end

  it 'can list #most_team_tackles' do
    expect(stat_tracker.season_stats.most_team_tackles("20122013")).to eq("FC Dallas")
    expect(stat_tracker.season_stats.most_team_tackles("20132014")).to eq("FC Dallas")
    expect(stat_tracker.season_stats.most_team_tackles("20152016")).to eq("Houston Dynamo")
  end

  it 'can list #least_team_tackles' do
    expect(stat_tracker.season_stats.least_team_tackles("20122013")).to eq("Houston Dynamo")
    expect(stat_tracker.season_stats.least_team_tackles("20132014")).to eq("Houston Dynamo")
    expect(stat_tracker.season_stats.least_team_tackles("20152016")).to eq("Sporting Kansas City")
  end

  it 'can #gather_goals_info' do
    expect(stat_tracker.season_stats.gather_goals_info("20122013")).to eq({"3" => 8,
                                                                           "5" => 5,
                                                                           "6" => 26})
    expect(stat_tracker.season_stats.gather_goals_info("20132014")).to eq({"3" => 2,
                                                                           "5" => 5,
                                                                           "6" => 8,})
    expect(stat_tracker.season_stats.gather_goals_info("20152016")).to eq({"3" => 2,
                                                                           "5" => 2,})
  end

  it 'can #gather_shots_info' do
    expect(stat_tracker.season_stats.gather_shots_info("20122013")).to eq({"3" => 38,
                                                                           "5" => 38,
                                                                           "6" => 86,})
    expect(stat_tracker.season_stats.gather_shots_info("20132014")).to eq({"3" => 4,
                                                                           "5" => 14,
                                                                           "6" => 18,})
    expect(stat_tracker.season_stats.gather_shots_info("20152016")).to eq({"3" => 7,
                                                                           "5" => 7,})
  end

  it 'can #sort_by_accuracy' do
    expect(stat_tracker.season_stats.sort_by_accuracy("20122013")).to eq([["6", 3.308], ["3", 4.75], ["5", 7.6]])
    expect(stat_tracker.season_stats.sort_by_accuracy("20132014")).to eq([["3", 2.0], ["6", 2.25], ["5", 2.8]])
    expect(stat_tracker.season_stats.sort_by_accuracy("20152016")).to eq([["3", 3.5], ["5", 3.5]])
  end

  it 'can list #most_accurate_team' do
    expect(stat_tracker.season_stats.most_accurate_team("20122013")).to eq("FC Dallas")
    expect(stat_tracker.season_stats.most_accurate_team("20132014")).to eq("Houston Dynamo")
    expect(stat_tracker.season_stats.most_accurate_team("20152016")).to eq("Houston Dynamo")
  end

  it 'can list #least_accurate_team' do
    expect(stat_tracker.season_stats.least_accurate_team("20122013")).to eq("Sporting Kansas City")
    expect(stat_tracker.season_stats.least_accurate_team("20132014")).to eq("Sporting Kansas City")
    expect(stat_tracker.season_stats.least_accurate_team("20152016")).to eq("Sporting Kansas City")
  end

  it 'can #find_season_games' do
    expect(stat_tracker.season_stats.find_season_games("20122013")).to be_instance_of(Array)
    expect(stat_tracker.season_stats.find_season_games("20122013").length).to eq(10)

    expect(stat_tracker.season_stats.find_season_games("20132014")).to be_instance_of(Array)
    expect(stat_tracker.season_stats.find_season_games("20132014").length).to eq(3)

    expect(stat_tracker.season_stats.find_season_games("20152016")).to be_instance_of(Array)
    expect(stat_tracker.season_stats.find_season_games("20152016").length).to eq(1)
  end

  it 'can #create_coach_season_record' do
    expect(stat_tracker.season_stats.create_coach_season_record("20122013")).to eq({"Claude Julien" => {:games=>0, :wins=>0},
                                                                                    "Dan Bylsma" => {:games=>0, :wins=>0},
                                                                                    "John Tortorella" => {:games=>0, :wins=>0},})

    expect(stat_tracker.season_stats.create_coach_season_record("20132014")).to eq({"Alain Vigneault" => {:games=>0, :wins=>0},
                                                                                    "Claude Julien" => {:games=>0, :wins=>0},
                                                                                    "Dan Bylsma" => {:games=>0, :wins=>0},})

    expect(stat_tracker.season_stats.create_coach_season_record("20152016")).to eq({"Alain Vigneault" => {:games=>0, :wins=>0},
                                                                                    "Mike Sullivan" => {:games=>0, :wins=>0},})
  end

  it 'can list #coach_win_loss_record' do
    expect(stat_tracker.season_stats.coach_win_loss_record("20122013")).to eq({"Claude Julien" => {:games=>10, :wins=>9},
                                                                               "Dan Bylsma" => {:games=>5, :wins=>1},
                                                                               "John Tortorella" => {:games=>5, :wins=>0}})
    expect(stat_tracker.season_stats.coach_win_loss_record("20132014")).to eq({"Alain Vigneault" => {:games=>1, :wins=>0},
                                                                               "Claude Julien" => {:games=>3, :wins=>2},
                                                                               "Dan Bylsma" => {:games=>2, :wins=>1},})
    expect(stat_tracker.season_stats.coach_win_loss_record("20152016")).to eq({"Alain Vigneault" => {:games=>1, :wins=>0},
                                                                               "Mike Sullivan" => {:games=>1, :wins=>0},})
  end

  it 'can list #worst_coach' do
    expect(stat_tracker.season_stats.worst_coach("20122013")).to eq("John Tortorella")
    expect(stat_tracker.season_stats.worst_coach("20132014")).to eq("Alain Vigneault")
    expect(stat_tracker.season_stats.worst_coach("20152016")).to eq("Alain Vigneault")
  end

  it 'can list #winningest_coach' do
    expect(stat_tracker.season_stats.winningest_coach("20122013")).to eq("Claude Julien")
    expect(stat_tracker.season_stats.winningest_coach("20132014")).to eq("Claude Julien")
    expect(stat_tracker.season_stats.winningest_coach("20152016")).to eq("Mike Sullivan")
  end

end