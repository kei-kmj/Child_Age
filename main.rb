# frozen_string_literal: true

JANUARY = 1
DECEMBER = 12
FIRST_DAY = 1
LAST_DAY = 31
ONE_YEAR = 12
YEARLY_COUNT = 10000
MONTHLY_COUNT = 100

# 年齢計算ロジックについて
# 誕生日と指定日を整数値(YYYYMMDD形式)で受け取り、差分を10000で割ることで、
# うるう年や月末日の計算を考慮せずに満年齢を計算することができる

# 例えば、誕生日が20230115で指定日が20240114の場合、
# (20240114 - 20230115) / 10000 = 0.9999 ≒ 0(歳) となり、
# 誕生日が20230115で指定日が20240115の場合、
# (20240115 - 20230115) / 10000 = 1(歳) となる。

# 月齢に関しても同じ考え方で、誕生日と指定日を10000で割った余りの差分を100で割ることで、
# 月齢を計算することができる。

# 例えば、誕生日が20230215で指定日が20230314の場合、
# ((20230314 % 10000) - (20230215 % 10000)) / 100 = 0.99 ≒ 0(ヶ月) となり、
# 誕生日が20230215で指定日が20230315の場合、
# ((20230315 % 10000) - (20230215 % 10000)) / 100 = 1(ヶ月) となる。

# うるう日を挟んでも計算が可能で、
# 誕生日が20200228で指定日が20200327の場合、
# ((20200327 % 10000) - (20200228 % 10000)) / 100 = 0.99 ≒ 0(ヶ月) となり、
# 誕生日が20200228で指定日が20200328の場合、
# ((20200328 % 10000) - (20200228 % 10000)) / 100 = 1(ヶ月) となる。

def child_age(birthday, specified_date)
  return unless correct_order?(birthday, specified_date)

  age = calc_age(birthday, specified_date)
  moon_age = calc_moon_age(birthday, specified_date)

  print_child_age(age, moon_age)
end

def correct_order?(birthday, specified_date)
  if !valid?(birthday) || !valid?(specified_date)
    print_error_message('日付が不正です')
    false
  elsif birthday > specified_date
    print_error_message('指定日は誕生日以後にしてください')
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

  # 不正な年月日でないかチェックする
  Time.new(year, month, day).strftime('%F') == \
    "#{year.to_s.rjust(4, '0')}-#{month.to_s.rjust(2, '0')}-#{day.to_s.rjust(2, '0')}"
end

def print_error_message(message)
  puts message
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
# 西暦でYYYYMMDD形式で誕生日と指定日を入力する
birthday = gets.to_i
specified_date = gets.to_i
child_age(birthday, specified_date)
