require 'spec_helper'
require 'csv'

describe SeasonStats do
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

  it 'can import team data' do
    expect(stat_tracker.season_stats.game_teams[0].game_id).to eq(2012030221)
    expect(stat_tracker.season_stats.game_teams[0].team_id).to eq("3")
    expect(stat_tracker.season_stats.game_teams[0].hoa).to eq('away')
    expect(stat_tracker.season_stats.game_teams[0].result).to eq('LOSS')
    expect(stat_tracker.season_stats.game_teams[0].settled_in).to eq('OT')
    expect(stat_tracker.season_stats.game_teams[0].head_coach).to eq('John Tortorella')
  end

  it 'can find winningest + worst coach' do
    expect(stat_tracker.season_stats.find_season_games('20132014')).to be_a(Array)
    expect(stat_tracker.season_stats.create_coach_season_record('20132014')).to be_a(Hash)
    expect(stat_tracker.season_stats.create_coach_season_record('20132014')).to be_a(Hash)

    expect(stat_tracker.season_stats.winningest_coach('20132014')).to eq('Claude Julien')
    expect(stat_tracker.season_stats.winningest_coach('20142015')).to eq('Alain Vigneault')
    expect(stat_tracker.season_stats.worst_coach('20132014')).to eq('Peter Laviolette')
    expect(stat_tracker.season_stats.worst_coach('20142015')).to eq('Craig MacTavish').or(eq('Ted Nolan'))
  end

  it 'can find most + least accurate team' do
    expect(stat_tracker.season_stats.gather_shots_info('20132014')).to be_a(Hash)
    expect(stat_tracker.season_stats.gather_goals_info('20132014')).to be_a(Hash)
    expect(stat_tracker.season_stats.most_accurate_team('20132014')).to eq('Real Salt Lake') #24
    expect(stat_tracker.season_stats.most_accurate_team('20142015')).to eq('Toronto FC') #20
    expect(stat_tracker.season_stats.least_accurate_team('20132014')).to eq('New York City FC') #9
    expect(stat_tracker.season_stats.least_accurate_team('20142015')).to eq('Columbus Crew SC') #53
  end

  it 'can list most + least tackles' do
    expect(stat_tracker.season_stats.total_team_tackles({})).to be_a(Hash)
    expect(stat_tracker.season_stats.most_team_tackles('20132014')).to eq('FC Cincinnati')
    expect(stat_tracker.season_stats.most_team_tackles('20142015')).to eq("Seattle Sounders FC")
    expect(stat_tracker.season_stats.least_team_tackles('20132014')).to eq('Atlanta United')
    expect(stat_tracker.season_stats.least_team_tackles('20142015')).to eq('Orlando City SC')
  end
end