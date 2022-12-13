# create Point class (x,y) 
# method to calc distance b/w two points
# check, if need to move tail after every head move
# keep memo of visited cells, return sum

# part one
class Point
    def initialize(x,y)
      @x,@y = x,y
    end

    def x
        @x
    end

    def y
        @y
    end

    def ==(p)
        self.x == p.x && self.y == p.y
    end

    def distance_to(p)
        if self == p
            0
        elsif self.y == p.y
            ((self.x).abs - (p.x).abs).abs
        elsif self.x == p.x
            ((self.y).abs - (p.y).abs).abs
        else # diagonal
            Math.sqrt((self.x - p.x)**2 + (self.y - p.y)**2)
        end
    end

    def move(dir, steps)
        case dir
        when 'L'
            @x = @x - steps
        when 'R'
            @x = @x + steps
        when 'U'
            @y = @y + steps
        when 'D'
            @y = @y - steps
        else
            raise 'Unknown move'
        end
    end

    def to_a
        [@x, @y]
    end

    def move_diagonally(p, steps)
        if p.x > self.x
            @x += steps
        else
            @x -= steps
        end

        if p.y > self.y
            @y += steps
        else
            @y -= steps
        end
    end
end

h, t = Point.new(0,0), Point.new(0,0)
memo = {[0,0] => 1}
prevMove = ''
stream = File.open("input.txt")
while row = stream.gets do
    dir, steps = row.strip.split(' ')
    steps.to_i.times do
        h.move(dir, 1)
        #pp "head: #{h.to_a}"
        if h.x == t.x || h.y == t.y
            if h.distance_to(t) > 1
                t.move(dir, 1)
            end
        else
            if h.distance_to(t) > Math.sqrt(2)
                t.move_diagonally(h, 1)
            end
        end
            #pp "tail: #{t.to_a}"
        memo[t.to_a] = 1
    end
    prevMove = dir
    #puts "==============="
end
stream.close

pp memo

puts memo.values.reduce(:+)