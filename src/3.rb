@day_number = 3
require_relative '../helpers.rb'

X = 0
Y = 1

PART_1_SLOPE = [3, 1]
PART_2_SLOPES = [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2],
]

def run_1
    traverse_hill(@data, PART_1_SLOPE, [0,0], 0)
end

def run_2
    PART_2_SLOPES.reduce(1) { |acc, slope| acc *= traverse_hill(@data, slope, [0,0], 0) }
end

def traverse_hill(ski_map, slope, starting_point, tree_accumulator)
    height = ski_map.length
    width = ski_map[0].length
    
    return tree_accumulator if starting_point[Y] >= height - 1

    new_x, new_y = calculate_move_one(starting_point, slope)
    is_tree = ski_map[new_y][new_x%width] == '#' ? 1 : 0
    traverse_hill(ski_map, slope, [new_x, new_y], tree_accumulator + is_tree)
end

def calculate_move_one(starting_point, slope)
    return [starting_point[X] + slope[X], starting_point[Y] + slope[Y]]
end

puts run_1
puts run_2