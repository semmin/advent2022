
#=== part one ===
# stream = File.open("input.txt")
# count = 0
# while row = stream.gets() do
#     one, two = row.strip.split(',')
#     sections1, sections2 = Range.new(*(one.split('-').map(&:to_i))), Range.new(*(two.split('-').map(&:to_i)))
    
#     if sections1.cover?(sections2) || sections2.cover?(sections1)
#         count += 1
#     end
# end
# stream.close

# puts count

# === part two ===
class Range
    def overlaps?(other)
        cover?(other.first) || other.cover?(first)
    end
end


stream = File.open("input.txt")
count = 0
while row = stream.gets() do
    one, two = row.strip.split(',')
    sections1, sections2 = Range.new(*(one.split('-').map(&:to_i))), Range.new(*(two.split('-').map(&:to_i)))
    
    if sections1.overlaps?(sections2)
        count += 1
    end
end
stream.close

puts count