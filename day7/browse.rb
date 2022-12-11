# 1. build adjacency list

def read_dir(stream, memo, abs_path)
    row = stream.gets
    while row && !row.start_with?('$') do
        a = row.strip.split(' ')
        if a[0] =~ /\d/ # file size
            memo[abs_path.join('/')] << a[0].to_i
        elsif a[0].start_with?('dir')
            memo[abs_path.join('/')] << [abs_path.join('/'), a[1]].join('/')
        end
        row = stream.gets
    end
    if row  # we haven't reached EOF
        stream.pos = stream.tell - row.length 
    end
end

stream = File.open("input.txt")
al = {} # 
abs_path = []
while row = stream.gets do
   case row.strip.split(' ')
   in ['$', 'cd', '..']
        abs_path.pop
        next
   in ['$', 'cd', dir_name]
        abs_path << dir_name
        al[abs_path.join('/')] = []
        stream.gets # rewind ls
        read_dir(stream, al, abs_path)
   end
end
stream.close

# calculate sizes recursievly
def calc_size(al, memo, dir_name='/')
    sum = 0
    al[dir_name].each do |el|
        if el.is_a? Numeric
            sum += el
        else
            sum += memo[el] || calc_size(al, memo, el)
        end
    end
    memo[dir_name] = sum
    sum
end

def calc_sizes(al)
    sizes = {}
    memo = {}
    al.each do |k, v|
        sizes[k] = calc_size(al, memo, k)
    end
    sizes
end

sizes = calc_sizes(al)

# ==== part_one ====
# pp sizes.select {|k,v| v <= 100000}.inject(0) {|acc, (k,v)| acc + v}


# === part two ===
# sort sizes, find closest to SHORT using BS
TOTAL_SPACE = 70_000_000
NEEDED = 30_000_000
used_space = sizes['/']
pp "Used: #{used_space}"
unused_space = TOTAL_SPACE - used_space
pp "Unused: #{unused_space}"
short = (unused_space - NEEDED).abs
pp "Short: #{short}"

class Array
    def binary_search(needle)
        l,r = 0, self.length - 1

        while l < r
            pivot = (l+r)/2
            if self[pivot] < needle
                l = pivot + 1
            elsif self[pivot] > needle
                r = pivot - 1
            else
                return pivot
            end
        end
        r
    end
end

sizes_a = sizes.values.sort
pp sizes_a[sizes_a.binary_search(short)]