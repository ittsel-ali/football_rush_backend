require 'test_helper'

class RushTest < ActiveSupport::TestCase

  test "load_json method: should load json" do
    expected = 
    ActiveSupport::JSON.decode( 
      File.read( 
        Rails.root.join('test/fixtures/files/rushing.json') 
        ) 
      )

    assert_equal Rush.load_json, expected
  end

  test "sort method with no args: should return the same set of records as fixture" do
    expected = 
    ActiveSupport::JSON.decode( 
      File.read( 
        Rails.root.join('test/fixtures/files/rushing.json') 
        ) 
      )

    assert_equal Rush.sort, expected
  end

  test "sort method with Longest Rush option: should return two desc sorted records with Lng <= -4" do
    expected = 
    [
      {
        "Player"=>"Travis Kelce", "Team"=>"KC", "Pos"=>"TE", "Att"=>1, "Att/G"=>0.1, "Yds"=>-5, "Avg"=>-5, 
        "Yds/G"=>-0.3, "TD"=>0, "Lng"=>-5, "1st"=>0, "1st%"=>0, "20+"=>0, "40+"=>0, "FUM"=>0
      },
      {
        "Player"=>"Taiwan Jones", "Team"=>"OAK", "Pos"=>"RB", "Att"=>1, "Att/G"=>0.1, "Yds"=>-8, "Avg"=>-8, 
        "Yds/G"=>-0.6, "TD"=>0, "Lng"=>-8, "1st"=>0, "1st%"=>0, "20+"=>0, "40+"=>0, "FUM"=>0
      }
    ]
    
    assert_equal Rush.sort(options: {"Lng"=>"-4"}), expected
  end

  test "sort method with Longest Rush and Total Rushing Yards option: should return one desc sorted records with Lng <= -4 and Yds <= -8" do
    expected = 
    [
      {
        "Player"=>"Taiwan Jones", "Team"=>"OAK", "Pos"=>"RB", "Att"=>1, "Att/G"=>0.1, "Yds"=>-8, "Avg"=>-8, 
        "Yds/G"=>-0.6, "TD"=>0, "Lng"=>-8, "1st"=>0, "1st%"=>0, "20+"=>0, "40+"=>0, "FUM"=>0
      }
    ]
    
    assert_equal Rush.sort(options: {"Lng"=>"-4", "Yds"=>"-8"}), expected
  end

  test "sort method with Longest Rush option and offset/limit: should return sorted records with offset and limit" do
    expected = 
    [
      {
        "Player"=>"Travis Kelce", "Team"=>"KC", "Pos"=>"TE", "Att"=>1, "Att/G"=>0.1, "Yds"=>-5, "Avg"=>-5, 
        "Yds/G"=>-0.3, "TD"=>0, "Lng"=>-5, "1st"=>0, "1st%"=>0, "20+"=>0, "40+"=>0, "FUM"=>0
      },
      {
        "Player"=>"Taiwan Jones", "Team"=>"OAK", "Pos"=>"RB", "Att"=>1, "Att/G"=>0.1, "Yds"=>-8, "Avg"=>-8, 
        "Yds/G"=>-0.6, "TD"=>0, "Lng"=>-8, "1st"=>0, "1st%"=>0, "20+"=>0, "40+"=>0, "FUM"=>0
      }
    ]
    
    assert_equal Rush.sort(options: {"Lng"=>"-4"}, offset: 0, limit: 1), [ expected[0] ] 
    assert_equal Rush.sort(options: {"Lng"=>"-4"}, offset: 1, limit: 1), [ expected[1] ] 
    assert_equal Rush.sort(options: {"Lng"=>"-4"}, offset: 0, limit: 2),   expected 
  end

  
end
