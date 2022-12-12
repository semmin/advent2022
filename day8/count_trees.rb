# the idea is to build "visibility map" (1 - visible, 0 - not)

# part one
class Array
    def column(index)
        columns[index]
    end

    def columns
        @columns ||= begin
            result = []
            height = self.length - 1
            for i in 0..height do
                result << self.map{|row|row[i]}
            end
            result
        end
    end
end

def visible?(grid, i, j)
    vis_left?(grid, i, j) || vis_right?(grid, i, j) || vis_top?(grid, i, j) || vis_bottom?(grid, i, j)
end

def vis_left?(grid, i, j)
    grid[i].first(j).all? {|el| el < grid[i][j]}
end

def vis_right?(grid, i, j)
    grid[i].last(grid[0].length - 1 - j).all? {|el| el < grid[i][j]}
end

def vis_top?(grid, i, j)
    grid.column(j).first(i).all? {|el| el < grid[i][j]}
end

def vis_bottom?(grid, i, j)
    grid.column(j).last(grid.length - 1 - i).all? {|el| el < grid[i][j]}
end

# read raw data into array
grid = []
stream = File.open("input.txt")
while row = stream.gets do
    grid << row.strip.split('').map(&:to_i)
end
stream.close

# initialize empty matrix
# visibility_map = []
# grid.each do
#     visibility_map << []
# end

# grid.each_with_index do |row,i|
#     row.each_with_index do |hight, j|
#         if i == 0 || j == 0 || i == grid.length-1 || j == row.length-1
#             visibility_map[i][j] = 1
#         elsif visible?(grid, i, j)
#             visibility_map[i][j] = 1
#         else
#             visibility_map[i][j] = 0
#         end
#     end
# end

# # part one
# total = 0
# visibility_map.each do |row|
#     total += row.reduce(:+)
# end
# puts total

# part two (build scenic score map)
def sscore(grid, i, j)
    ss_left(grid, i, j) * ss_right(grid, i, j) * ss_top(grid, i, j) * ss_bottom(grid, i, j)
end

def ss_left(grid, i, j)
    left = grid[i].first(j)
    score = 0
    (left.length - 1).downto(0) do |ii|
        score += 1
        break if left[ii] >= grid[i][j]
    end
    score
end

def ss_right(grid, i, j)
    right = grid[i].last(grid[0].length - 1 - j)
    score = 0
    right.each do |el|
        score += 1
        break if el >= grid[i][j]
    end
    score
end

def ss_top(grid, i, j)
    top = grid.column(j).first(i)
    score = 0
    (top.length - 1).downto(0) do |ii|
        score += 1
        break if top[ii] >= grid[i][j]
    end
    score
end

def ss_bottom(grid, i, j)
    bottom = grid.column(j).last(grid.length - 1 - i)
    score = 0
    bottom.each do |el|
        score += 1
        break if el >= grid[i][j]
    end
    score
end

max = sscore(grid,1,1)
grid.each_with_index do |row,i|
     row.each_with_index do |hight, j|
        next if i == 0 || j == 0 || i == grid.length-1 || j == row.length-1
        temp = sscore(grid,i,j)
        max = temp if temp > max
    end
end

pp max