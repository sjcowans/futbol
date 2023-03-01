require 'spec_helper'
describe GameTeamData do
  before(:each) do
    @dataset = GameTeamData.new
    @dataset.add_game_team
  end

  it 'can import team data' do
    expect(@dataset.game_teams[0].game_id).to eq("2012030221")
  end

  it 'can return team with best offense' do
    expect(@dataset.best_offense).to eq("Reign FC")
  end

  it 'can return team with worst offense' do
    expect(@dataset.worst_offense).to eq("Utah Royals FC")
  end
end