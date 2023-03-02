require 'spec_helper'
require 'csv'

describe LeagueStats do
  let(:game_path) { './data/games.csv' }
  let(:team_path) { './data/teams.csv' }
  let(:game_teams_path) { './data/games.csv' }
  let(:locations) do {
          games: game_path,
          teams: team_path,
          game_teams: game_teams_path
          }
  end
  let(:stat_tracker) { StatTracker.from_csv(locations) }
  
  let(:league_stats) { LeagueStats.new(locations) }
  it 'can import team data' do
    expect(stat_tracker.league_stats.teams[0].team_id).to eq("1")
  end

  it 'can return a count of teams' do
    expect(stat_tracker.league_stats.count_of_teams).to eq(32)
  end
  it 'can store team total goals' do

    expect(stat_tracker.league_stats.lowest_scoring_home).to eq("Reign FC")
    expect(stat_tracker.league_stats.home_scores["54"]).to eq(132)
    expect(stat_tracker.league_stats.lowest_scoring_away).to eq("Reign FC")
    expect(stat_tracker.league_stats.away_scores["54"]).to eq(107)
  end

end