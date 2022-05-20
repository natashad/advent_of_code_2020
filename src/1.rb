@day_number = 1
require_relative '../helpers.rb'

data = @data
data = data.map(&:to_i).sort
DESIRED_SUM = 2020


def get_satisfying_two_numbers(data, desired_sum)
    data.each_with_index do |num, index|
        required_number = desired_sum - num
        
        data[(index + 1)..].each do |num2|
            return [num, num2] if required_number == num2
        end
    end
    return []
end

def get_satisfying_three_numbers(data)
    data.each_with_index do |num, index|
        new_desired_sum = DESIRED_SUM - num
        
        satisfying_two_numbers = get_satisfying_two_numbers(data[(index+1)..], new_desired_sum)
        if satisfying_two_numbers.length > 0
            return [num, *satisfying_two_numbers]
        end
    end
    return []
end

solution1 = get_satisfying_two_numbers(data, DESIRED_SUM)
solution2 = get_satisfying_three_numbers(data)

puts solution1.reduce(:*)
puts solution2.reduce(:*)