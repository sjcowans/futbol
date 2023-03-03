require 'spec_helper'
require 'csv'
describe Classes do
  let(:game_path) { './data/games.csv' }
  let(:team_path) { './data/teams.csv' }
  let(:game_teams_path) { './data/game_teams.csv' }
  let(:locations) do {
          games: game_path,
          teams: team_path,
          game_teams: game_teams_path
          }
  end

   it 'exists' do
      classes = Classes.new(locations)
      expect(classes).to be_instance_of(Classes)

      expect(classes.games).to be_instance_of(Array)
      expect(classes.teams).to be_instance_of(Array)
      expect(classes.game_teams).to be_instance_of(Array)

      expect(classes.games.length).to eq(7441)
      expect(classes.teams.length).to eq(32)
      expect(classes.game_teams.length).to eq(14882)
   end
 end