require "pry"

def game_hash
  {
    away: { team_name: 'Charlotte Hornets',
            colors: ["Turquoise", "Purple"],
            players: [
              { player_name: 'Jeff Adrien',
                number: 4,
                shoe: 18,
                points: 10,
                rebounds: 1,
                assists: 1,
                steals: 2,
                blocks: 7,
                slam_dunks: 2 },
              { player_name: 'Bismack Biyombo',
                number: 0,
                shoe: 16,
                points: 12,
                rebounds: 4,
                assists: 7,
                steals: 22,
                blocks: 15,
                slam_dunks: 10 },
              { player_name: 'DeSagna Diop',
                number: 2,
                shoe: 14,
                points: 24,
                rebounds: 12,
                assists: 12,
                steals: 4,
                blocks: 5,
                slam_dunks: 5 },
              { player_name: 'Ben Gordon',
                number: 8,
                shoe: 15,
                points: 33,
                rebounds: 3,
                assists: 2,
                steals: 1,
                blocks: 1,
                slam_dunks: 0 },
              { player_name: 'Kemba Walker',
                number: 33,
                shoe: 15,
                points: 6,
                rebounds: 12,
                assists: 12,
                steals: 7,
                blocks: 5,
                slam_dunks: 12 }
            ] },
    home: { team_name: 'Brooklyn Nets',
            colors: ["Black", "White"],
            players: [
              { player_name: 'Alan Anderson',
                number: 0,
                shoe: 16,
                points: 22,
                rebounds: 12,
                assists: 12,
                steals: 3,
                blocks: 1,
                slam_dunks: 1 },
              { player_name: 'Reggie Evans',
                number: 30,
                shoe: 14,
                points: 12,
                rebounds: 12,
                assists: 12,
                steals: 12,
                blocks: 12,
                slam_dunks: 7 },
              { player_name: 'Brook Lopez',
                number: 11,
                shoe: 17,
                points: 17,
                rebounds: 19,
                assists: 10,
                steals: 3,
                blocks: 1,
                slam_dunks: 15 },
              { player_name: 'Mason Plumlee',
                number: 1,
                shoe: 19,
                points: 26,
                rebounds: 11,
                assists: 6,
                steals: 3,
                blocks: 8,
                slam_dunks: 5 },
              { player_name: 'Jason Terry',
                number: 31,
                shoe: 15,
                points: 19,
                rebounds: 2,
                assists: 2,
                steals: 4,
                blocks: 11,
                slam_dunks: 1 }
            ] 
          }
  }
end

def num_points_scored(name)
  game_hash.each do |location, team_hash|
    team_hash.each do |team_attr, attr_hash|
      next if team_attr != :players
      team_hash[team_attr].each do |player_hash|
        return player_hash[:points] if name == player_hash[:player_name]
      end
    end
  end
end

def shoe_size(name)
  game_hash.each do |location, team_hash|
    team_hash.each do |team_attr, attr_hash|
      next if team_attr != :players
      team_hash[team_attr].each do |player_hash|
        return player_hash[:shoe] if name == player_hash[:player_name]
      end
    end
  end
end

def team_colors(team)
  game_hash.each do |location, team_hash|
    if team_hash[:team_name] == team
      return team_hash[:colors]
    end
  end
end

def team_names
  game_hash.collect { |location, team_hash| team_hash[:team_name] }
end

def player_numbers(team)
  game_hash.collect do |location, team_hash|
    if team_hash[:team_name] == team
      return team_hash[:players].collect { |player| player[:number] } 
    end 
  end
end

def player_stats(name)
  game_hash.each do |location, team_hash|
    team_hash.each do |team_attr, attr_hash|
      next if team_attr != :players
      team_hash[team_attr].each do |player_hash|
        if name == player_hash[:player_name]
          player_hash.delete(:player_name)
          return player_hash
        end
      end
    end
  end
end

def big_shoe_rebounds
  players = []
  game_hash.each do |location, team_hash|
    players << team_hash[:players]
    players.flatten!
  end
  players.sort_by {|p| p[:shoe] }.reverse.first[:rebounds]
end

def most_points_scored
  players = []
  game_hash.each do |location, team_hash|
    players << team_hash[:players]
    players.flatten!
  end
  players.sort_by {|p| p[:points] }.reverse.first[:player_name]
end

def winning_team
  teams = []
  game_hash.each do |location, team_hash|
    points = 0
    team_hash[:players].each do |player_hash|
      points += player_hash[:points]
    end
    teams << {name: team_hash[:team_name], points: points}
  end
  teams.sort_by {|p| p[:points] }.reverse.first[:name]
end

def player_with_longest_name
  players = [] 
  game_hash.each do |location, team_hash|
    team_hash[:players].each {|p| players << p[:player_name]}
  end
  players.sort_by {|p| p.length}.reverse.first
end

def long_name_steals_a_ton?
  players = []
  game_hash.each do |location, team_hash|
    players << team_hash[:players]
    players.flatten!
  end
  player_with_longest_name == players.sort_by {|p| p[:steals] }.reverse.first[:player_name]

end
