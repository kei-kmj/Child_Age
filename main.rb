# frozen_string_literal: true

JANUARY = 1
DECEMBER = 12
FIRST_DAY = 1
LAST_DAY = 31
ONE_YEAR = 12
YEARLY_COUNT = 10000
MONTHLY_COUNT = 100


#
def child_age(birthday, specified_date)
  return unless valid_dates?(birthday, specified_date)

  age = calc_age(birthday, specified_date)
  moon_age = calc_moon_age(birthday, specified_date)

  print_child_age(age, moon_age)
end

def valid_dates?(birthday, specified_date)
  if !valid?(birthday) || !valid?(specified_date)
    puts '日付が不正です'
    false
  elsif birthday > specified_date
    puts '指定日は誕生日より後にしてください'
    false
  else
    true
  end
end

def valid?(date)
  # 文字列や空文字など不正な値が入力された場合
  return false if date.zero?

  year = date / YEARLY_COUNT
  month = date % YEARLY_COUNT / MONTHLY_COUNT
  day = date % MONTHLY_COUNT

  # 月又は日が不正な値の場合
  return false if month < JANUARY || month > DECEMBER || day < FIRST_DAY || day > LAST_DAY

  # 不正な年月日の場合
  Time.new(year, month, day).strftime('%F') == \
    "#{year.to_s.rjust(4, '0')}-#{month.to_s.rjust(2, '0')}-#{day.to_s.rjust(2, '0')}"
end

def calc_age(birthday, specified_date)
  (specified_date - birthday) / YEARLY_COUNT
end

def calc_moon_age(birthday, specified_date)
  moon_age = ((specified_date % YEARLY_COUNT) - (birthday % YEARLY_COUNT)) / MONTHLY_COUNT
  moon_age += ONE_YEAR if moon_age.negative?
  moon_age
end

def print_child_age(age, moon_age)
  if age < 1
    puts "生後 #{moon_age}ヶ月"
  elsif age < 2
    puts "#{age}歳 #{moon_age}ヶ月"
  else
    puts "#{age}歳"
  end
end

# エントリポイント
# 西暦でYYYYDDMM形式で誕生日と指定日を入力する
birthday = gets.to_i
specified_date = gets.to_i
child_age(birthday, specified_date)
