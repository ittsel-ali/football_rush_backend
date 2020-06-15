require 'test_helper'

class RushTest < ActiveSupport::TestCase

  test "load_json method: should load json" do
    expected = 
    ActiveSupport::JSON.decode( 
      File.read( 
        Rails.root.join('test/fixtures/files/rushing.json') 
        ) 
      )
    
    rush = Rush.new
    assert_equal rush.records, expected
  end

  test "sort method with no args: should return the same set of records as fixture" do
    expected = 
    ActiveSupport::JSON.decode( 
      File.read( 
        Rails.root.join('test/fixtures/files/rushing.json') 
        ) 
      )
    
    rush = Rush.new
    assert_equal rush.sort, expected
  end

  test "Search Player by name: should return three unsorted records" do
    expected = 
    [
      {
        "Player"=>"Travis Benjamin", "Team"=>"SD", "Pos"=>"WR", "Att"=>2, "Att/G"=>0.1, "Yds"=>-3, "Avg"=>-1.5, 
        "Yds/G"=>-0.2, "TD"=>0, "Lng"=>-1, "1st"=>0, "1st%"=>0, "20+"=>0, "40+"=>0, "FUM"=>0
      },
      {
        "Player"=>"Travis Kelce", "Team"=>"KC", "Pos"=>"TE", "Att"=>1, "Att/G"=>0.1, "Yds"=>-5, 
        "Avg"=>-5, "Yds/G"=>-0.3, "TD"=>0, "Lng"=>-5, "1st"=>0, "1st%"=>0, "20+"=>0, "40+"=>0, "FUM"=>0
      }, 
      {
        "Player"=>"Travaris Cadet", "Team"=>"NO", "Pos"=>"RB", "Att"=>4, "Att/G"=>0.3, "Yds"=>19, "Avg"=>4.8, 
        "Yds/G"=>1.3, "TD"=>0, "Lng"=>"16", "1st"=>1, "1st%"=>25, "20+"=>0, "40+"=>0, "FUM"=>0
      }
    ]
    rush = Rush.new
    rush.filter(field: "Player", search: "tra")

    assert_equal rush.records, expected
  end

  test "Ascending sort method with Longest Rush option: should return three sorted records by Lng field" do
    expected = 
    [
      {
        "Player"=>"Travis Kelce", "Team"=>"KC", "Pos"=>"TE", "Att"=>1, "Att/G"=>0.1, "Yds"=>-5, 
        "Avg"=>-5, "Yds/G"=>-0.3, "TD"=>0, "Lng"=>-5, "1st"=>0, "1st%"=>0, "20+"=>0, "40+"=>0, "FUM"=>0
      }, 
      {
        "Player"=>"Travis Benjamin", "Team"=>"SD", "Pos"=>"WR", "Att"=>2, "Att/G"=>0.1, "Yds"=>-3, "Avg"=>-1.5, 
        "Yds/G"=>-0.2, "TD"=>0, "Lng"=>-1, "1st"=>0, "1st%"=>0, "20+"=>0, "40+"=>0, "FUM"=>0
      }, 
      {
        "Player"=>"Travaris Cadet", "Team"=>"NO", "Pos"=>"RB", "Att"=>4, "Att/G"=>0.3, "Yds"=>19, "Avg"=>4.8, 
        "Yds/G"=>1.3, "TD"=>0, "Lng"=>"16", "1st"=>1, "1st%"=>25, "20+"=>0, "40+"=>0, "FUM"=>0
      }
    ]
    rush = Rush.new
    rush.filter(field: "Player", search: "tra")

    assert_equal rush.sort(field: "Lng"), expected
  end

  
  test "sort Longest Rush with offset/limit option: should return sorted records with offset and limit" do
    expected = 
    [
      {
        "Player"=>"Travis Kelce", "Team"=>"KC", "Pos"=>"TE", "Att"=>1, "Att/G"=>0.1, "Yds"=>-5, 
        "Avg"=>-5, "Yds/G"=>-0.3, "TD"=>0, "Lng"=>-5, "1st"=>0, "1st%"=>0, "20+"=>0, "40+"=>0, "FUM"=>0
      }, 
      {
        "Player"=>"Travis Benjamin", "Team"=>"SD", "Pos"=>"WR", "Att"=>2, "Att/G"=>0.1, "Yds"=>-3, "Avg"=>-1.5, 
        "Yds/G"=>-0.2, "TD"=>0, "Lng"=>-1, "1st"=>0, "1st%"=>0, "20+"=>0, "40+"=>0, "FUM"=>0
      }, 
      {
        "Player"=>"Travaris Cadet", "Team"=>"NO", "Pos"=>"RB", "Att"=>4, "Att/G"=>0.3, "Yds"=>19, "Avg"=>4.8, 
        "Yds/G"=>1.3, "TD"=>0, "Lng"=>"16", "1st"=>1, "1st%"=>25, "20+"=>0, "40+"=>0, "FUM"=>0
      }
    ]

    rush = Rush.new
    rush.filter(field: "Player", search: "tra")
    
    assert_equal rush.sort(field: "Lng", offset: 0, limit: 1), [ expected[0] ] 
    assert_equal rush.sort(field: "Lng", offset: 1, limit: 1), [ expected[1] ] 
    assert_equal rush.sort(field: "Lng", offset: 0, limit: 3),   expected 
  end

  test "Generate CSV of rushing records correctly" do
    records = 
    [
      {
        "Player"=>"Travis Kelce", "Team"=>"KC", "Pos"=>"TE", "Att"=>1, "Att/G"=>0.1, "Yds"=>-5, 
        "Avg"=>-5, "Yds/G"=>-0.3, "TD"=>0, "Lng"=>-5, "1st"=>0, "1st%"=>0, "20+"=>0, "40+"=>0, "FUM"=>0
      }, 
      {
        "Player"=>"Travis Benjamin", "Team"=>"SD", "Pos"=>"WR", "Att"=>2, "Att/G"=>0.1, "Yds"=>-3, "Avg"=>-1.5, 
        "Yds/G"=>-0.2, "TD"=>0, "Lng"=>-1, "1st"=>0, "1st%"=>0, "20+"=>0, "40+"=>0, "FUM"=>0
      }, 
      {
        "Player"=>"Travaris Cadet", "Team"=>"NO", "Pos"=>"RB", "Att"=>4, "Att/G"=>0.3, "Yds"=>19, "Avg"=>4.8, 
        "Yds/G"=>1.3, "TD"=>0, "Lng"=>"16", "1st"=>1, "1st%"=>25, "20+"=>0, "40+"=>0, "FUM"=>0
      }
    ]
    
    expected = []
    expected << "Player,Team,Pos,Att,Att/G,Yds,Avg,Yds/G,TD,Lng,1st,1st%,20+,40+,FUM\n"
    expected << "Travis Kelce,KC,TE,1,0.1,-5,-5,-0.3,0,-5,0,0,0,0,0\n"
    expected << "Travis Benjamin,SD,WR,2,0.1,-3,-1.5,-0.2,0,-1,0,0,0,0,0\n"
    expected << "Travaris Cadet,NO,RB,4,0.3,19,4.8,1.3,0,16,1,25,0,0,0\n"
    
    rush = Rush.new
    assert_equal rush.generate_csv(records), expected.join 
  end

  
end
