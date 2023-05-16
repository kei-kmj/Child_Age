# frozen_string_literal: true

require_relative '../main'

describe 'child_age' do
  context '1歳未満の確認' do
    it '誕生日=指定日のときは生後 0ヶ月と表示される' do
      allow_any_instance_of(Object).to receive(:receive_date).and_return([20_230_101, 20_230_101])
      expect(child_age).to eq '生後 0ヶ月'
    end

    it '1年後の前日は生後 11ヶ月と表示される' do
      allow_any_instance_of(Object).to receive(:receive_date).and_return([20_230_101, 20_231_201])
      expect(child_age).to eq '生後 11ヶ月'
    end
  end

  context '2歳未満の確認' do
    it '1歳を越えると年齢と月齢が表示される' do
      allow_any_instance_of(Object).to receive(:receive_date).and_return([20_230_101, 20_240_101])
      expect(child_age).to eq '1歳 0ヶ月'
    end

    it '2歳未満は年齢と月齢が表示される' do
      allow_any_instance_of(Object).to receive(:receive_date).and_return([20_230_101, 20_241_231])
      expect(child_age).to eq '1歳 11ヶ月'
    end
  end

  context '2歳以上の確認' do
    it '2歳になると年齢が表示される' do
      allow_any_instance_of(Object).to receive(:receive_date).and_return([20_230_101, 20_250_101])
      expect(child_age).to eq '2歳'
    end

    it '2歳以上の時は年齢が表示される' do
      allow_any_instance_of(Object).to receive(:receive_date).and_return([20_230_101, 20_410_101])
      expect(child_age).to eq '18歳'
    end
  end

  context '2月29日生まれ（うるう日）の確認' do
    it '翌年2月28日は生後11ヶ月' do
      allow_any_instance_of(Object).to receive(:receive_date).and_return([20_200_229, 20_210_228])
      expect(child_age).to eq '生後 11ヶ月'
    end

    it '翌年3月1日に1歳になる' do
      allow_any_instance_of(Object).to receive(:receive_date).and_return([20_200_229, 20_210_301])
      expect(child_age).to eq '1歳 0ヶ月'
    end
  end
end
