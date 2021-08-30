require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '商品購入機能' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
      sleep(1)
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
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'prefectureが空欄だと保存できない' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'townが空欄だと保存できない' do
        @purchase_address.town = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Town can't be blank")
      end
      it 'plot_numberが空欄だと保存できない' do
        @purchase_address.plot_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Plot number can't be blank")
      end
      it 'phone_numberが空欄だと保存できない' do
        @purchase_address.phone_number =''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'postal_codeは半角のハイフンを含んだ正しい形でなければ保存できない' do
        @purchase_address.phone_number = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number has to be Half-width")
      end
      it 'phone_numberは半角でなければ保存できない' do
        @purchase_address.phone_number = '１２３４５６７８９'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number has to be Half-width')
      end

      it 'userが紐づいていないと保存できない' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐づいていないと保存できない' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空欄だと保存できない' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end

    end
  end
end
