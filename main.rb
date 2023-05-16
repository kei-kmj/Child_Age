# frozen_string_literal: true

def child_age
  birthday, specified_date = receive_date

  age = calc_age(birthday, specified_date)
  moon_age = calc_moon_age(birthday, specified_date)

  if age < 1
    "生後 #{moon_age}ヶ月"
  elsif age < 2
    "#{age}歳 #{moon_age}ヶ月"
  else
    "#{age}歳"
  end
end

def receive_date
  puts '誕生日をYYYYMMDDの形式で入力してください'
  birthday = gets.to_i

  puts '指定日をYYYYMMDDの形式で入力してください'
  specified_date = gets.to_i
  [birthday, specified_date]
end

def calc_age(birthday, specified_date)
  (specified_date - birthday) / 10_000
end

def calc_moon_age(birthday, specified_date)
  moon_age = ((specified_date % 10_000) - (birthday % 10_000)) / 100
  moon_age += 12 if moon_age.negative?
  moon_age
end

puts child_age
