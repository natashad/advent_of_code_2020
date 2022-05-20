def load_data_to_array(day_number:, is_test: false)
    file = File.open("data/#{is_test ? 'test_' : ''}#{day_number}.txt")
    file.readlines.map(&:chomp)
end

@test_data = load_data_to_array(day_number: @day_number, is_test: true)
@data = load_data_to_array(day_number: @day_number)