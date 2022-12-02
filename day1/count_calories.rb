stream = File.open("input.txt")
calories_per_elf = []
temp_sum = 0 
while item = stream.gets do
    if item != "\n" 
        temp_sum += item.to_i
    else
        calories_per_elf << temp_sum
        temp_sum = 0
    end
end

stream.close

puts calories_per_elf.max(3).inject(:+) # part two