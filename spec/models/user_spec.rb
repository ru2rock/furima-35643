require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user) # Userのインスタンス生成
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全ての情報が入力されていれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが６文字以上で半角英数混合であれば登録できる' do
        @user.password = '123asd'
        @user.password_confirmation = '123asd'
        expect(@user).to be_valid
      end
      it 'last_nameが全角文字であれば登録できる' do
        @user.last_name = '山田'
        expect(@user).to be_valid
      end
      it 'first_nameが全角文字であれば登録できる' do
        @user.first_name = '太郎'
        expect(@user).to be_valid
      end
      it 'last_name_kanaが全角カナであれば登録できる' do
        @user.last_name_kana = 'ヤマダ'
        expect(@user).to be_valid
      end
      it 'first_name_kanaが全角カナであれば登録できる' do
        @user.first_name_kana = 'タロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = '' # nicknameの値を空にする
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空だと登録できない' do
        @user.email = '' # emailの値を空にする
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空だと登録できない' do
        @user.password = '' # passwordの値を空にする
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'password_confirmationが空だと登録できない' do
        @user.password_confirmation = '' # password_confirmationの値を空にする
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'first_nameがない場合は登録できない' do
        @user.first_name = '' # first_nameの値を空にする
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it 'last_nameがない場合は登録できない' do
        @user.last_name = '' # last_nameの値を空にする
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end
      it 'first_name_kanaがない場合は登録できない' do
        @user.first_name_kana = '' # first_name_kanaの値を空にする
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カタカナ）を入力してください")
      end
      it 'last_name_kanaがない場合は登録できない' do
        @user.last_name_kana = '' # last_name_kanaの値を空にする
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カタカナ）を入力してください")
      end
      it 'birthdayがない場合は登録できない' do
        @user.birthday = '' # birthdayの値を空にする
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
      it 'passwordが5文字以下だと登録できない' do
        @user.password = '000as' # passwordの値を6文字以下にする（英数混合で記述）
        @user.password_confirmation = '000as' # password_confirmationも定義する
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください') # errorメッセージのそれぞれの単語は必ずスペースをあけること
      end
      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password = '000as'
        @user.password_confirmation = '123as'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it '重複したemailが存在すると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します') # アポストロフィーのない文章の場合はシングルクォーテーションで文章を記載する
      end
      it 'emailに@が含まれていない場合登録できない' do
        @user.email = 'hogehuga.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordが半角英数混合でなければ登録できない（数字のみ）' do
        @user.password = '123456' # passwordの値を数字だけにする
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが半角英数混合でなければ登録できない（英字のみ）' do
        @user.password = 'asdfgh' # passwordの値を数字だけにする
        @user.password_confirmation = 'asdfgh'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが半角でなければ登録できない' do
        @user.password = '１２３ｍｊｋ'
        @user.password_confirmation = '１２３ｍｊｋ'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'first_nameが全角入力でなければ登録できない' do
        @user.first_name = 'taro' # first_nameを意図的に半角にする
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は不正な値です')
      end
      it 'last_nameが全角入力でなければ登録できない' do
        @user.last_name = 'yamada' # last_nameを意図的に半角にする
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字は不正な値です')
      end
      it 'first_name_kanaが全角カタカナでなければ登録できない' do
        @user.first_name_kana = 'taro' # first_name_kanaを意図的に半角にする
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（カタカナ）は不正な値です')
      end
      it 'last_name_kanaが全角カタカナでなければ登録できない' do
        @user.last_name_kana = 'yamada' # last_name_kanaを意図的に半角にする
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字（カタカナ）は不正な値です')
      end
    end
  end
end
