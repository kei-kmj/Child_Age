# frozen_string_literal: true

require_relative '../main'

describe 'correct_order?' do
  context '誕生日が文字列又は空文字のとき' do
    it '日付が不正ですと表示される' do
      expect do
        correct_order?(0, 20230101)
      end.to output("日付が不正です\n").to_stdout
    end
  end

  context '指定日が文字列又は空文字のとき' do
    it '日付が不正ですと表示される' do
      expect do
        correct_order?(20230101, 0)
      end.to output("日付が不正です\n").to_stdout
    end
  end

  context '誕生月に0が入力されたとき' do
    it '日付が不正ですと表示される' do
      expect do
        correct_order?(20220001, 20230101)
      end.to output("日付が不正です\n").to_stdout
    end
  end

  context '指定月に0が入力されたとき' do
    it '日付が不正ですと表示される' do
      expect do
        correct_order?(20220101, 20230001)
      end.to output("日付が不正です\n").to_stdout
    end
  end

  context '誕生月に13が入力されたとき' do
    it '日付が不正ですと表示される' do
      expect do
        correct_order?(20221301, 20230101)
      end.to output("日付が不正です\n").to_stdout
    end
  end

  context '指定月に13が入力されたとき' do
    it '日付が不正ですと表示される' do
      expect do
        correct_order?(20220101, 20231301)
      end.to output("日付が不正です\n").to_stdout
    end
  end

  context '誕生日に0が入力されたとき' do
    it '日付が不正ですと表示される' do
      expect do
        correct_order?(20220100, 20230101)
      end.to output("日付が不正です\n").to_stdout
    end
  end

  context '指定日に0が入力されたとき' do
    it '日付が不正ですと表示される' do
      expect do
        correct_order?(20220101, 20230100)
      end.to output("日付が不正です\n").to_stdout
    end
  end

  context '誕生日に32が入力されたとき' do
    it '日付が不正ですと表示される' do
      expect do
        correct_order?(20220132, 20230101)
      end.to output("日付が不正です\n").to_stdout
    end
  end

  context '指定日に32が入力されたとき' do
    it '日付が不正ですと表示される' do
      expect do
        correct_order?(20220101, 20230132)
      end.to output("日付が不正です\n").to_stdout
    end
  end

  context '誕生日に存在しない日時が入力されたとき' do
    it '日付が不正ですと表示される' do
      expect do
        correct_order?(20220431, 20230101)
      end.to output("日付が不正です\n").to_stdout
    end
  end

  context '指定日に存在しない日時が入力されたとき' do
    it '日付が不正ですと表示される' do
      expect do
        correct_order?(20220101, 20220431)
      end.to output("日付が不正です\n").to_stdout
    end
  end

  context '誕生日に、存在しないうるう日が入力されたとき' do
    it '日付が不正ですと表示される' do
      expect do
        correct_order?(20220229, 20230101)
      end.to output("日付が不正です\n").to_stdout
    end
  end

  context '指定日に、存在しないうるう日が入力されたとき' do
    it '日付が不正ですと表示される' do
      expect do
        correct_order?(20220101, 20220229)
      end.to output("日付が不正です\n").to_stdout
    end
  end

  context '指定日が誕生日より前の日付の時' do
    it '指定日は誕生日以後にしてくださいと表示される' do
      expect do
        correct_order?(20230101, 20220101)
      end.to output("指定日は誕生日以後にしてください\n").to_stdout
    end
  end
end

describe 'child_age' do
  context '1歳未満のとき' do
    context '指定日=誕生日' do
      it '生後 0ヶ月と表示される' do
        expect do
          child_age(20220101, 20220101)
        end.to output("生後 0ヶ月\n").to_stdout
      end
    end
    context '指定日が、1年後の誕生日の前日' do
      it '生後 11ヶ月と表示される' do
        expect do
          child_age(20230101, 20231231)
        end.to output("生後 11ヶ月\n").to_stdout
      end
    end
  end

  context '1歳以上2歳未満のとき' do
    context '1歳' do
      it '年齢と月齢が表示される' do
        expect do
          child_age(20230101, 20240101)
        end.to output("1歳 0ヶ月\n").to_stdout
      end
    end

    context '指定日が、2年後の誕生日の前日' do
      it '年齢と月齢が表示される' do
        expect do
          child_age(20230101, 20241231)
        end.to output("1歳 11ヶ月\n").to_stdout
      end
    end
  end

  context '2歳以上のとき' do
    context '2歳' do
      it '年齢が表示される' do
        expect do
          child_age(20230101, 20250101)
        end.to output("2歳\n").to_stdout
      end
    end

    context '2歳超' do
      it '年齢が表示される' do
        expect do
          child_age(20230101, 20410101)
        end.to output("18歳\n").to_stdout
      end
    end
  end

  context '2月29日（うるう日）生まれのとき' do
    context '指定日=誕生日' do
      it '生後 0ヶ月と表示される' do
        expect do
          child_age(20200229, 20200229)
        end.to output("生後 0ヶ月\n").to_stdout
      end
    end

    context '翌年2月28日生まれ' do
      it '生後 11ヶ月と表示される' do
        expect do
          child_age(20200229, 20210228)
        end.to output("生後 11ヶ月\n").to_stdout
      end
    end

    context '翌年3月1日生まれ' do
      it '1歳 0ヶ月と表示される' do
        expect do
          child_age(20200229, 20210301)
        end.to output("1歳 0ヶ月\n").to_stdout
      end
    end
    context '翌々年2月28日生まれ' do
      it '1歳 11ヶ月と表示される' do
        expect do
          child_age(20200229, 20220228)
        end.to output("1歳 11ヶ月\n").to_stdout
      end
    end

    context '翌々年3月1日生まれ' do
      it '2歳と表示される' do
        expect do
          child_age(20200229, 20220301)
        end.to output("2歳\n").to_stdout
      end
    end
  end
end
