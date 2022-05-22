@day_number = 6
require_relative '../helpers.rb'

def run
    count_any_yes = 0
    count_all_yes = 0
    groups = read_groups(@data, [])
    groups.each do |group|
        count_any_yes = count_any_yes + group.reduce(:+).uniq.length

        all_yes_for_group = group[1..].reduce(group[0]) do |acc, entry| 
            new_acc = []
            entry.each { |e| new_acc.append(e) if acc.include?(e) }
            acc = new_acc.join
        end
        count_all_yes = count_all_yes + all_yes_for_group.length
    end
    
    [count_any_yes, count_all_yes]
end

def read_groups(data, accumulator)
    return accumulator if data.length == 0
    index = 0
    accumulator.append([])
    while data[index] != nil do
        return read_groups(data[index+1..], accumulator) if data[index].strip == ''
        accumulator[-1].append(data[index].split(''))
        index += 1
    end

    accumulator
end

puts run