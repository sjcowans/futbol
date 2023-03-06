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

  it "can show the most goals scored for a team" do
    expect(stat_tracker.team_stats.most_goals_scored("18")).to eq(7)
  end

  it "can show the least goals scored for a team" do
    expect(stat_tracker.team_stats.least_goals_scored("18")).to eq(0)
  end

  it "can show favorite_opponent" do
    expect(stat_tracker.team_stats.favorite_opponent("18")).to eq("DC United")
  end

  it "can show rival" do
    expect(stat_tracker.team_stats.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
  end

  it 'can show biggest blowout' do
    expect(stat_tracker.team_stats.biggest_blowout("18")).to eq(5)
  end

  it 'can show worst loss' do
    expect(stat_tracker.team_stats.worst_loss("18")).to eq(-4)
  end

  it 'can show head to head' do
    expect(stat_tracker.team_stats.head_to_head("18")).to eq({"19"=>0.4411764705882353,
                                                              "52"=>0.45161290322580644,
                                                              "21"=>0.4375,
                                                              "16"=>0.47368421052631576,
                                                              "1"=>0.5,
                                                              "29"=>0.4666666666666667,
                                                              "8"=>0.4,
                                                              "23"=>0.3333333333333333,
                                                              "15"=>0.3,
                                                              "25"=>0.48148148148148145,
                                                              "20"=>0.3333333333333333,
                                                              "28"=>0.44,
                                                              "24"=>0.41935483870967744,
                                                              "5"=>0.25,
                                                              "2"=>0.5,
                                                              "7"=>0.6,
                                                              "14"=>0.8,
                                                              "22"=>0.6666666666666666,
                                                              "3"=>0.4,
                                                              "10"=>0.2,
                                                              "9"=>0.6,
                                                              "26"=>0.3888888888888889,
                                                              "6"=>0.4,
                                                              "12"=>0.3,
                                                              "30"=>0.37037037037037035,
                                                              "27"=>0.3333333333333333,
                                                              "17"=>0.2857142857142857,
                                                              "53"=>0.5,
                                                              "4"=>0.3,
                                                              "54"=>0.3333333333333333,
                                                              "13"=>0.1
                                                              })
  end

  it 'can show seasonal summary' do
    expect(stat_tracker.team_stats.seasonal_summary("18")).to eq({:"20122013"=>
                                                                    {:regular_season=>
                                                                      {:win_percentage=>0.25,
                                                                      :total_goals_scored=>85,
                                                                      :total_goals_against=>103,
                                                                      :average_goals_scored=>1.77,
                                                                      :average_goals_against=>103},
                                                                    :post_season=>
                                                                      {:win_percentage=>0,
                                                                      :total_goals_scored=>0,
                                                                      :total_goals_against=>0,
                                                                      :average_goals_scored=>0,
                                                                      :average_goals_against=>0}},
                                                                  :"20132014"=>
                                                                    {:regular_season=>
                                                                      {:win_percentage=>0.38,
                                                                      :total_goals_scored=>166,
                                                                      :total_goals_against=>177,
                                                                      :average_goals_scored=>2.02,
                                                                      :average_goals_against=>177},
                                                                    :post_season=>
                                                                      {:win_percentage=>0,
                                                                      :total_goals_scored=>0,
                                                                      :total_goals_against=>0,
                                                                      :average_goals_scored=>0,
                                                                      :average_goals_against=>0}},
                                                                  :"20142015"=>
                                                                    {:regular_season=>
                                                                      {:win_percentage=>0.5,
                                                                      :total_goals_scored=>186,
                                                                      :total_goals_against=>162,
                                                                      :average_goals_scored=>2.27,
                                                                      :average_goals_against=>162},
                                                                    :post_season=>
                                                                      {:win_percentage=>0.33,
                                                                      :total_goals_scored=>17,
                                                                      :total_goals_against=>13,
                                                                      :average_goals_scored=>2.83,
                                                                      :average_goals_against=>13}},
                                                                  :"20152016"=>
                                                                    {:regular_season=>
                                                                      {:win_percentage=>0.45,
                                                                      :total_goals_scored=>178,
                                                                      :total_goals_against=>159,
                                                                      :average_goals_scored=>2.17,
                                                                      :average_goals_against=>159},
                                                                    :post_season=>
                                                                      {:win_percentage=>0.38,
                                                                      :total_goals_scored=>25,
                                                                      :total_goals_against=>33,
                                                                      :average_goals_scored=>1.79,
                                                                      :average_goals_against=>33}},
                                                                  :"20162017"=>
                                                                    {:regular_season=>
                                                                      {:win_percentage=>0.38,
                                                                      :total_goals_scored=>180,
                                                                      :total_goals_against=>170,
                                                                      :average_goals_scored=>2.2,
                                                                      :average_goals_against=>170},
                                                                    :post_season=>
                                                                      {:win_percentage=>0.36,
                                                                      :total_goals_scored=>48,
                                                                      :total_goals_against=>40,
                                                                      :average_goals_scored=>2.18,
                                                                      :average_goals_against=>40}},
                                                                  :"20172018"=>
                                                                    {:regular_season=>
                                                                      {:win_percentage=>0.44,
                                                                      :total_goals_scored=>187,
                                                                      :total_goals_against=>162,
                                                                      :average_goals_scored=>2.28,
                                                                      :average_goals_against=>162},
                                                                    :post_season=>
                                                                      {:win_percentage=>0.67,
                                                                      :total_goals_scored=>29,
                                                                      :total_goals_against=>28,
                                                                      :average_goals_scored=>2.23,
                                                                      :average_goals_against=>28}}})
  end
end