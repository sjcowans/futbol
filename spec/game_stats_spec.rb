require 'spec_helper'
require 'csv'

describe GameStats do
  let(:game_path) { './data/games.csv' }
  let(:team_path) { './data/teams.csv' }
  let(:game_teams_path) { './data/game_teams.csv' }
  let(:locations) do {
          games: game_path,
          teams: team_path,
          game_teams: game_teams_path
          }
  end
  let(:stat_tracker) { StatTracker.from_csv(locations) }
  
  let(:game_stats) { GameStats.new(locations) }

  it 'can import game data' do
  
  expect(stat_tracker.game_stats.games[0].id).to eq(2012030221)
  expect(stat_tracker.game_stats.games.length).to eq(7441)
  end

  it 'can list #home_wins' do
    expect(stat_tracker.game_stats.home_wins).to eq(3237)
  end

  it 'can list #away_wins' do
    expect(stat_tracker.game_stats.away_wins).to eq(2687)
  end

  it 'can list #ties' do
    expect(stat_tracker.game_stats.ties).to eq(1517.0)
  end

  it 'can list #total_games' do
    expect(stat_tracker.game_stats.total_games).to eq(7441)
  end

  it 'can list #percentage_home_wins' do
    expect(stat_tracker.game_stats.percentage_home_wins).to eq(0.44)
  end

  it 'can list #percentage_visitor_wins' do
    expect(stat_tracker.game_stats.percentage_visitor_wins).to eq(0.36)
  end

  it 'can list #percentage_ties' do
    expect(stat_tracker.game_stats.percentage_ties).to eq(0.2)
  end

  it 'can return #total_scores' do
    expect(stat_tracker.game_stats.total_scores).to be_instance_of(Array)
    expect(stat_tracker.game_stats.total_scores.include?(11)).to eq(true)
    expect(stat_tracker.game_stats.total_scores.include?(0)).to eq(true)
    expect(stat_tracker.game_stats.total_scores.include?(12)).to eq(false)
  end

  it 'can return #highest_total_score' do
    expect(stat_tracker.game_stats.highest_total_score).to eq(11)
  end

  it 'can return #lowest_total_score' do
    expect(stat_tracker.game_stats.lowest_total_score).to eq(0)
  end

  it 'can return a #count_of_games_by_season' do
    expect(stat_tracker.game_stats.count_of_games_by_season).to eq({"20122013"=>806, 
                                                    "20162017"=>1317, 
                                                    "20142015"=>1319, 
                                                    "20152016"=>1321, 
                                                    "20132014"=>1323, 
                                                    "20172018"=>1355})
  end
  
  it 'can return average_goals_per_game' do
    expect(stat_tracker.game_stats.average_goals_per_game).to eq(4.22)
  end

  it 'can return #average_goals_by_season' do
    expect(stat_tracker.game_stats.average_goals_by_season).to eq({ "20122013" => 4.12,
                                                    "20132014" => 4.19,
                                                    "20142015" => 4.14,
                                                    "20152016" => 4.16,
                                                    "20162017" => 4.23,
                                                    "20172018" => 4.44,})
  end

  it 'can return #goals_per_season' do

    expect(stat_tracker.game_stats.goals_per_season).to eq({"20122013"=>3322, 
                                            "20162017"=>5565, 
                                            "20142015"=>5461, 
                                            "20152016"=>5499, 
                                            "20132014"=>5547, 
                                            "20172018"=>6019})
  end

  it 'can return #games_per_season' do

    expect(stat_tracker.game_stats.games_per_season).to eq({"20122013"=>806, 
                                            "20162017"=>1317, 
                                            "20142015"=>1319, 
                                            "20152016"=>1321, 
                                            "20132014"=>1323, 
                                            "20172018"=>1355})
  end
end