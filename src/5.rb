@day_number = 5
require_relative '../helpers.rb'

def run
    all_seat_ids = @data.map { |boarding_pass| decode_seat_id(boarding_pass) }

    (0..get_max_seat_id).to_a.each do |seat_id|
        return seat_id if !all_seat_ids.include?(seat_id) && all_seat_ids.include?(seat_id-1) && all_seat_ids.include?(seat_id+1)
    end

    nil
end

def get_max_seat_id
    max = -1
    @data.each do |boarding_pass|
        max = [max, decode_seat_id(boarding_pass)].max
    end
    
    max
end

def decode_seat_id(boarding_pass)
    row = binary_split((0..127).to_a, boarding_pass[0..6], ['F', 'B'])
    col = binary_split((0..7).to_a, boarding_pass[7..], ['L', 'R'])

    row * 8 + col
end

def binary_split(boundaries, instructions, split_keys)
    return boundaries[0] if instructions.length == 0
    lower_bound_key, upper_bound_key = split_keys
    
    if instructions[0] == lower_bound_key
        binary_split(boundaries[0..(boundaries.length/2)], instructions[1..], split_keys)
    elsif instructions[0] == upper_bound_key
        binary_split(boundaries[boundaries.length/2..], instructions[1..], split_keys)
    end
end

puts get_max_seat_id
puts run

# Alternative functions.

def decode_seat_id_non_recursive(boarding_pass)
    row = binary_split(boarding_pass[0..6], [0,127], ['F', 'B'])
    col = binary_split(boarding_pass[7..], [0,7], ['L', 'R'])

    row * 8 + col
end
    
def binary_split_non_recursive(space, boundaries, split_keys)
    min, max = boundaries
    lower_bound_key, upper_bound_key = split_keys
    num_iterations = space.length

    (0..num_iterations).to_a.each do |iter|
        if space[iter] == lower_bound_key
            max = max - (max+1-min)/2
        elsif space[iter] == upper_bound_key
            min = min + (max+1-min)/2
        end
    end
    puts "Something dun goofed" unless min == max
    return min
end
