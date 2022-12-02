# A  X Rock
# B  Y Paper
# C  Z Scissors 


#=== part one ===
# DRAWS = ["A X", "B Y", "C Z"].freeze
# WINS = ["A Y", "B Z", "C X"].freeze
# LOSSES = ["A Z", "B X", "C Y"].freeze
# VALUES = {"X" => 1, "Y" => 2, "Z" => 3}.freeze
# def calc_score(move)    
#     my_move = move.split(' ').last
#     if win?(move)
#         return VALUES[my_move] + 6
#     elsif draw?(move)
#         return VALUES[my_move] + 3
#     elsif loose?(move)
#         return VALUES[my_move]
#     end
# end

# def win?(move)
#     WINS.include? move
# end

# def loose?(move)
#     LOSSES.include? move
# end

# def draw?(move)
#     DRAWS.include? move 
# end

# === part two ===
WIN = "Z".freeze
LOSS = "X".freeze
DRAW = "Y".freeze
VALUES_TO_WIN = {"A" => 2, "B" => 3, "C" => 1}.freeze
VALUES_TO_LOOSE = {"A" => 3, "B" => 1, "C" => 2}.freeze
VALUES_TO_DRAW = {"A" => 1, "B" => 2, "C" => 3}.freeze
def calc_score(move)    
    opponent_move, outcome = move.split(' ')
    if win?(outcome)
        return VALUES_TO_WIN[opponent_move] + 6
    elsif draw?(outcome)
        return VALUES_TO_DRAW[opponent_move] + 3
    elsif loose?(outcome)
        return VALUES_TO_LOOSE[opponent_move]
    end
end

def win?(outcome)
    outcome == WIN
end

def loose?(outcome)
    outcome == LOSS
end

def draw?(outcome)
    outcome == DRAW
end

stream = File.open("input.txt")
total = 0

while item = stream.gets do
    total += calc_score(item.strip)
end
stream.close


puts total