# IMHO, the challenge with this problem is process input into convinient form
# (array of stacks) and then replay all of the moves on this DS

# 1) parse input and instantiate struct
def parse_input(stream)
    buffer = []
    row = stream.gets
    while row[1] != '1' do
        buffer << row
        row = stream.gets
    end
    buffer
end

class Ship
    STACK_POSITIONS = { 1 => 1, 5 => 2, 9 => 3, 13 => 4, 17 => 5,
                        21 => 6, 25 => 7, 29 => 8, 33 => 9}

    def initialize(raw_data)
      @raw_data = raw_data
    end

    def raw_data
        @raw_data
    end

    def move(args)
        amount, from, to = *args
        # === part one (moving one at the time) ===
        # amount.to_i.times do
        #     cargo[to.to_i].push(cargo[from.to_i].pop)
        # end

        # === part two ===
        cargo[to.to_i].push(*cargo[from.to_i].pop(amount.to_i))
    end

    def cargo
        @cargo ||= Array.new(10)
    end

    def add(stack_number, value)
        if cargo[stack_number].nil?
            cargo[stack_number] = []
        end
        stack = cargo[stack_number]
        stack.push value
    end

    def build_cargo_from_raw_data
        len = raw_data.size - 1
        len_row = raw_data[0].length - 1
        len.downto(0) do |i|
            for j in 0..len_row do
                if raw_data[i][j] =~ /\w/
                    add(STACK_POSITIONS[j], raw_data[i][j])
                end
            end
        end
    end
end

# build array of stacks
stream = File.open("input.txt")
s = Ship.new(parse_input(stream))
s.build_cargo_from_raw_data

# rewind emty line
stream.gets

# replay moves
while row = stream.gets() do
    s.move(row.scan(/\d+/))
end
stream.close

puts s.cargo.map{|stack| stack.last unless stack.nil?}.join('')