require 'spec_helper'
require 'csv'

describe TeamStats do
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
  
  let(:league_stats) { LeagueStats.new(locations) }

  it 'can list #team_info' do

  expect(stat_tracker.team_stats.team_info("18")).to eq({
                                                          "team_id" => "18",
                                                          "franchise_id" => "34",
                                                          "team_name" => "Minnesota United FC",
                                                          "abbreviation" => "MIN",
                                                          "link" => "/api/v1/teams/18"
                                                        })
  end 

  it 'can show best season for a team' do
    expect(stat_tracker.team_stats.best_season("6")).to eq("20132014")
  end

  it 'can show worst season for a team' do
    expect(stat_tracker.team_stats.worst_season("6")).to eq("20142015")
  end

  it 'can show average_win_percentage for a team' do
    expect(stat_tracker.team_stats.average_win_percentage("6")).to be{0.49}
  end
end