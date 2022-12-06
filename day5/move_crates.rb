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
    def def initialize(raw_data)
      @raw_data = raw_data
    end

    def move(amount, from, to)
        amount.times do
            cargo[to].push(cargo[from].pop)
        end
    end

    private

    def cargo
        @cargo ||= Array.new(10)
    end

    def add(stack_number, value)
        cargo[stack_number].push value
    end

    def build_cargo_from_raw
        len = raw_data.size - 1
        for i in len..0 do
            while ch = raw_data[i].shift do
            end
        end
    end
end

stream = File.open("input.txt")
puts parse_input(stream)


# while row = stream.gets() do
# 
# end
stream.close
