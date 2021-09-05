require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '商品購入機能' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
      sleep(0.5)
    end

    context '商品購入ができる時' do
      it '商品購入に必要な情報が全て入力されていれば保存できる' do
        expect(@purchase_address).to be_valid
      end
      it 'buildingは空欄でも保存できる' do
        @purchase_address.building = ''
        expect(@purchase_address).to be_valid
      end
    end

    context '商品購入ができない時' do
      it 'postal_codeが空欄だと保存できない' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'prefectureが空欄だと保存できない' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("都道府県を入力してください")
      end
      it 'townが空欄だと保存できない' do
        @purchase_address.town = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'plot_numberが空欄だと保存できない' do
        @purchase_address.plot_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空欄だと保存できない' do
        @purchase_address.phone_number =''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'postal_codeは半角のハイフンを含んだ正しい形でなければ保存できない' do
        @purchase_address.postal_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("郵便番号は不正な値です。ハイフンを含めてください")
      end
      it 'phone_numberは半角でなければ保存できない' do
        @purchase_address.phone_number = '１２３４５６７８９'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('電話番号は9桁から１２桁の半角で入力してください')
      end

      it 'userが紐づいていないと保存できない' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("出品者を入力してください")
      end
      it 'itemが紐づいていないと保存できない' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("商品を入力してください")
      end
      it 'tokenが空欄だと保存できない' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("カード情報を入力してください")
      end
      it '電話番号が9桁以下では購入できない' do
        @purchase_address.phone_number = '12345678'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号は9桁から１２桁の半角で入力してください")
      end
      it '電話番号が12桁以上では購入できない' do
        @purchase_address.phone_number = '1234567891011'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号は9桁から１２桁の半角で入力してください")
      end
      it '電話番号に半角数字以外が含まれている場合は購入できない' do
        @purchase_address.phone_number = '090-1234-5678'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("電話番号は数字のみで入力してください")
      end
    end
  end
end
