
#=== part one ===
common_items = []

lower = Array('a'..'z')
upper = Array('A'..'Z') 
all_letters = lower + upper
item_values = {}
all_letters.each_with_index do |v,i|
    item_values[v] = i + 1
end

# stream = File.open("input.txt")

# while racksuck = stream.gets() do
#     a = racksuck.strip.split('')
#     half = racksuck.length/2
#     first, second = a.first(half), a.last(half)
#     common = first & second
#     if common.length > 0
#         common_items += common.map{|el| item_values[el]}
#     end
# end
# stream.close

# puts common_items.reduce(:+)

# === part two ===
def read_three_lines(f)
    lines = []
    3.times do
        s = f.gets
        lines << s if s
    end
    lines
end

stream = File.open("input.txt")
batch = read_three_lines(stream)
while batch.length > 0 do
    one, two, three = *batch
    common = one.strip.split('') & two.strip.split('') & three.strip.split('')
    if common.length > 0
        common_items += common.map{|el| item_values[el]}
    end
    batch = read_three_lines(stream)
end
stream.close

puts common_items.reduce(:+)