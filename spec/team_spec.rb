require 'spec_helper'

describe Team do
  data = {
    "team_id" => "1",
    "franchiseId" => "23",
    "teamName" => "Atlanta United",
    "abbreviation" => "ATL",
    "Stadium" => "Mercedes-Benz Stadium",
    "link" => "/api/v1/teams/1",
    
  }
  

team = Team.new(data)

  it 'exists' do
     expect(team.team_id).to eq("1")
     expect(team.franchiseid).to eq("23")
     expect(team.teamname).to eq("Atlanta United")
     expect(team.abbreviation).to eq("ATL")
     expect(team.stadium).to eq("Mercedes-Benz Stadium")
     expect(team.link).to eq("/api/v1/teams/1") 
  end
end