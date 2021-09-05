require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品を出品できるとき' do
      it '全ての情報が入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品を出品できないとき' do
      it '商品名が空だと出品できない' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品画像がなければ出品できない' do
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it '商品説明がなければ出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'カテゴリーが選択されていなければ出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it '商品状態が選択されていなければ出品できない' do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it '配送料負担が選択されていなければ出品できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      it '発送元の地域が選択されていなければ出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end
      it '発送までの日数が選択されていなければ出品できない' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      it '販売価格が選択されていなければ出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end
      it '販売価格が300円より少ない時は出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は設定範囲外の値です')
      end
      it '販売価格が9,999,999円より多い時は出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は設定範囲外の値です')
      end
      it '販売価格が半角数字でなければ保存できない' do
        @item.price = '２２２２'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は設定範囲外の値です')
      end
      it 'userが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('出品者を入力してください')
      end
      it '価格が半角英数混合では登録できない' do
        @item.price = 'asd123'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は設定範囲外の値です')
      end
      it '価格が半角英語だけでは登録できない' do
        @item.price = 'asder'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は設定範囲外の値です')
      end
    end
  end
end
