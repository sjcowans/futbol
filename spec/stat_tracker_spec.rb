require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:all) do
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

    it 'exists' do
      expect(@stat_tracker).to be_a(StatTracker)
    end

  describe '#Game Statistics' do
    it 'can list highest and lowest total scores' do

      expect(@stat_tracker.highest_total_score).to eq(11)
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end

    it 'can list percentage home + away wins + ties' do

      expect(@stat_tracker.percentage_home_wins).to eq(0.44)
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
      expect(@stat_tracker.percentage_ties).to eq(0.20)
    end

    it 'can list count of games by season' do
      expected = {
        "20122013"=>806,
        "20132014"=>1323,
        "20142015"=>1319,
        "20152016"=>1321,
        "20162017"=>1317,
        "20172018"=>1355
      }

      expect(@stat_tracker.count_of_games_by_season).to eq(expected)
    end

    it 'can list average goals by game + per season' do
      expected = {
        "20122013"=>4.12,
        "20132014"=>4.19,
        "20142015"=>4.14,
        "20152016"=>4.16,
        "20162017"=>4.23,
        "20172018"=> 4.44
      }

      expect(@stat_tracker.average_goals_per_game).to eq(4.22)
      expect(@stat_tracker.average_goals_by_season).to eq(expected)
    end
  end

  describe '#League Statistics' do
    it 'can return count of teams' do

      expect(@stat_tracker.count_of_teams).to eq(32)
    end

    it 'can return best + worst offenses' do

      expect(@stat_tracker.best_offense).to eq('Reign FC')
      expect(@stat_tracker.worst_offense).to eq('Utah Royals FC')
    end

    it 'can return highest + lowest scoring home + away teams' do

      expect(@stat_tracker.highest_scoring_home_team).to eq('Reign FC')
      expect(@stat_tracker.highest_scoring_visitor).to eq('FC Dallas')
      expect(@stat_tracker.lowest_scoring_home_team).to eq('Utah Royals FC')
      expect(@stat_tracker.lowest_scoring_visitor).to eq('San Jose Earthquakes')
    end
  end

  describe '#Season Statistics' do
    it 'can return winningest + worst coaches' do
      
      expect(@stat_tracker.winningest_coach('20132014')).to eq('Claude Julien')
      expect(@stat_tracker.winningest_coach('20152016')).to eq('Barry Trotz')
      expect(@stat_tracker.worst_coach('20132014')).to eq('Peter Laviolette')
      expect(@stat_tracker.worst_coach('20152016')).to eq('Todd Richards')
    end

    it 'can return most + least accurate team' do

      expect(@stat_tracker.most_accurate_team('20132014')).to eq('Real Salt Lake')
      expect(@stat_tracker.least_accurate_team('20132014')).to eq('New York City FC')
    end

    it 'can return most + fewest tackles' do

      expect(@stat_tracker.most_tackles('20132014')).to eq('FC Cincinnati')
      expect(@stat_tracker.fewest_tackles('20132014')).to eq('Atlanta United')
    end
  end
end