@day_number = 4
require_relative '../helpers.rb'


def birth_validator(data)
    year = data.to_i
    return data.length == 4 && year >= 1920 && year <= 2002
end

def iss_validator(data)
    year = data.to_i
    return data.length == 4 && year >= 2010 && year <= 2020
end

def exp_validator(data)
    year = data.to_i
    return data.length == 4 && year >= 2020 && year <= 2030
end

def height_validator(data)
    num = data[0..data.length-3]
    return false unless num.to_i.to_s == num.to_s
    num = num.to_i

    unit = "#{data[-2]}#{data[-1]}"

    if unit == "cm"
        return num >= 150 && num <= 193
    elsif unit == "in"
        return num >= 59 && num <= 76
    else
        return false
    end
end

def hair_color_validator(data)
    return !!data.match(/^#[a-f|0-9]{6}$/)
end

def eye_color_validator(data)
    return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(data)
end

def pid_validator(data)
    return !!data.match(/^[0-9]{9}$/)
end

PASSPORT_SCHEMA = {
    byr: ->(data) { birth_validator(data) } ,
    iyr: ->(data) { iss_validator(data) },
    eyr: ->(data) { exp_validator(data) },
    hgt: ->(data) { height_validator(data) },
    hcl: ->(data) { hair_color_validator(data) },
    ecl: ->(data) { eye_color_validator(data) },
    pid: ->(data) { pid_validator(data) },
}

def read_next_passport(passports, line_idx)
    idx = line_idx
    passport = {}
    return false if passports.length < line_idx

    while passports[idx] && passports[idx].strip != '' do
        key_vals = passports[idx].split
        key_vals.each do |pair|
            key, val = pair.split(':')
            passport[key] = val
        end
        idx += 1
    end
    return [passport, idx+1]
end

def validate_passport_1(passport)
    PASSPORT_SCHEMA.each do |entry, _|
        return false if !passport.keys.include?(entry.to_s)
    end

    true
end

def validate_passport_2(passport)
    PASSPORT_SCHEMA.each do |entry, validator|
        return false if !passport.keys.include?(entry.to_s) || !validator.call(passport[entry.to_s])
    end

    true
end

def run
    count_1 = 0
    count_2 = 0
    next_passport, next_idx = read_next_passport(@data, 0)
    while next_passport do
        count_1 += 1 if validate_passport_1(next_passport)
        count_2 += 1 if validate_passport_2(next_passport)

        next_passport, next_idx = read_next_passport(@data, next_idx)
    end

    [count_1, count_2]
end

puts run