@day_number = 2
require_relative '../helpers.rb'

def run_test
    run(data: @test_data)
end

def run(data: @data)
    parsed_data = data.map{|line| parse_line(line)}

    first_valid_password_count, second_valid_password_count = [0, 0]

    parsed_data.each do |entry|
        first_valid_password_count += 1 if check_validity_for_policy1(entry[:policy], entry[:password])
        second_valid_password_count += 1 if check_validity_for_policy2(entry[:policy], entry[:password])
    end

    [first_valid_password_count, second_valid_password_count]
end

def check_validity_for_policy1(policy, password)
    char_count = 0
    password.split('').each do |symbol|
        char_count += 1 if symbol == policy[:character]
    end
    return char_count <= policy[:second_number] && char_count >= policy[:first_number]
end

def check_validity_for_policy2(policy, password)
    char_count = 0
    first_check = password[policy[:first_number] - 1] == policy[:character] ? 1 : 0
    second_check = password[policy[:second_number] - 1] == policy[:character] ? 1 : 0

    return first_check + second_check == 1
end

def parse_line(line)
    split_line = line.split(' ')
    char_counts = split_line[0].split('-')
    {
        policy: {
            character: split_line[1][0],
            first_number: char_counts[0].to_i,
            second_number: char_counts[1].to_i,
        },
        password: split_line[2],
    }
end

puts run