# 1. read input one char at the time
# 2. keep fixed buffer of last 4
# 3. on every step, check equality

# part one
# BUFF_SIZE = 4

# part two
BUFF_SIZE = 14

def all_different?(a)
    return false unless a.is_a? Enumerable
    a.uniq.size == a.size
end

stream = File.open("input.txt")
position = 0
buff = []
stream.each_char do |ch|
    position += 1
    if buff.length < BUFF_SIZE
        buff.push(ch)
    elsif buff.length == BUFF_SIZE
        buff.shift # remove first element
        buff.push(ch) # add new to the buffer
        break if all_different?(buff)
    else
        raise 'buffer overflow'
    end
end
stream.close

puts position
