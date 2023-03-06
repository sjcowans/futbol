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

  describe '#Team Statistics' do

    it 'can return team info for a specific team id' do
      expected = {
        "team_id" => "18",
        "franchise_id" => "34",
        "team_name" => "Minnesota United FC",
        "abbreviation" => "MIN",
        "link" => "/api/v1/teams/18"
      }

      expect(@stat_tracker.team_info('18')).to eq(expected)
    end
    it 'can return best and worst season for a particular team' do

      expect(@stat_tracker.best_season('6')).to eq('20132014')
      expect(@stat_tracker.worst_season('6')).to eq('20142015')
    end

    it 'can return average win percentage for a particular team' do

      expect(@stat_tracker.average_win_percentage('6')).to eq(0.49)
    end

    it 'can return fewest and most goals for a specific team' do

      expect(@stat_tracker.most_goals_scored('18')).to eq(7)
      expect(@stat_tracker.fewest_goals_scored('18')).to eq(0)
    end

    it 'can return a teams favorite opponent' do

      expect(@stat_tracker.favorite_opponent('18')).to eq('DC United')
    end

    it 'can show a teams rival' do 

      expect(@stat_tracker.rival('18')).to eq('Houston Dash').or(eq('LA Galaxy'))
    end

    it 'can show biggest blowout + worst loss for a specific team' do

      expect(@stat_tracker.biggest_blowout('18')).to eq(5)
      expect(@stat_tracker.worst_loss('18')).to eq(-4)
    end

    it 'can show head to head with each other team' do
      expected = {
        "Philadelphia Union"=>0.4411764705882353,
        "Portland Thorns FC"=>0.45161290322580644,
        "Vancouver Whitecaps FC"=>0.4375,
        "New England Revolution"=>0.47368421052631576,
        "Atlanta United"=>0.5,
        "Orlando Pride"=>0.4666666666666667,
        "New York Red Bulls"=>0.4,
        "Montreal Impact"=>0.3333333333333333,
        "Portland Timbers"=>0.3,
        "Chicago Red Stars"=>0.48148148148148145,
        "Toronto FC"=>0.3333333333333333,
        "Los Angeles FC"=>0.44,
        "Real Salt Lake"=>0.41935483870967744,
        "Sporting Kansas City"=>0.25,
        "Seattle Sounders FC"=>0.5,
        "Utah Royals FC"=>0.6,
        "DC United"=>0.8,
        "Washington Spirit FC"=>0.6666666666666666,
        "Houston Dynamo"=>0.4,
        "North Carolina Courage"=>0.2,
        "New York City FC"=>0.6,
        "FC Cincinnati"=>0.3888888888888889,
        "FC Dallas"=>0.4,
        "Sky Blue FC"=>0.3,
        "Orlando City SC"=>0.37037037037037035,
        "San Jose Earthquakes"=>0.3333333333333333,
        "LA Galaxy"=>0.2857142857142857,
        "Columbus Crew SC"=>0.5,
        "Chicago Fire"=>0.3,
        "Reign FC"=>0.3333333333333333,
        "Houston Dash"=>0.1
      }

      expect(@stat_tracker.head_to_head('18')).to eq(expected)
    end
  end
end