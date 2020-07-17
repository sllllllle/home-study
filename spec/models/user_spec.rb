require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  it '有効なファクトリを持つこと' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it '名前、メールアドレス、パスワードがあれば有効であること' do
    user = User.new(
      name: 'tester',
      email: 'tester@example.com',
      password: '2423abc',
      gender: '0',
      age: '70'
    )
    expect(user).to be_valid
  end

  describe '存在性の検証' do
    it 'ユーザー名がなければ無効であること' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'メールアドレスがなければ無効であること' do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it 'パスワードがなければ無効であること' do
      @user.password = nil
      expect(@user).to_not be_valid
    end

    it '性別がなければ無効であること' do
      @user.gender = nil
      expect(@user).to_not be_valid
    end

    it '年代がなければ無効であること' do
      @user.age = nil
      expect(@user).to_not be_valid
    end
  end

  describe '文字数の検証' do
    it '名前が10文字以内であれば有効であること' do
      @user.name = 'a' * 10
      expect(@user).to be_valid
    end

    it '名前が11文字以上であれば無効であること' do
      @user.name = 'a' * 11
      expect(@user).to_not be_valid
    end

    it 'メールアドレスが255文字以内であれば有効であること' do
      @user.email = 'a' * 243 + '@example.com'
      expect(@user).to be_valid
    end

    it 'メールアドレスが256文字以上であれば無効であること' do
      @user.email = 'a' * 244 + '@example.com'
      expect(@user).to_not be_valid
    end
  end

  describe '一意性の検証' do
    it 'メールアドレスが重複していれば場合無効であること' do
      user1 = FactoryBot.create(:user, name: 'ichiro', email: 'ichiro@example.com')
      user2 = FactoryBot.build(:user, name: 'jiro', email: user1.email)
      expect(user2).to_not be_valid
    end

    it 'メールアドレスは大文字小文字区別せず扱うこと' do
      FactoryBot.create(:user, email: 'sample@example.com')
      duplicate_user = FactoryBot.build(:user, email: 'SAMPLE@EXAMPLE.COM')
      expect(duplicate_user).to_not be_valid
    end
  end

  describe 'パスワードの検証' do
    it 'パスワードと確認用パスワードが異なっていれば無効であること' do
      @user.password = 'password'
      @user.password_confirmation = 'pass'
      expect(@user).to_not be_valid
    end

    it 'パスワードが暗号化されていること' do
      user = FactoryBot.create(:user, password: 'password')
      expect(user.password_digest).to_not eq 'password'
    end
  end

  describe 'フォーマットの検証' do
    it 'メールアドレスが正常なフォーマットであれば有効であること' do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end

    it 'メールアドレスが不正なフォーマットであれば無効であること' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to_not be_valid
      end
    end
  end

  describe 'メソッドの検証' do
    before do
      @ichiro = FactoryBot.create(:user, name: 'ichiro')
      @jiro = FactoryBot.create(:user, name: 'jiro')
    end

    describe 'フォロー関連のメソッド' do
      it 'ユーザーをフォロー/フォロー解除できること' do
        expect(@ichiro.following?(@jiro)).to eq false
        @jiro.follow(@ichiro)
        expect(@jiro.following?(@ichiro)).to eq true
        @jiro.unfollow(@ichiro)
        expect(@jiro.following?(@ichiro)).to eq false
      end

      it 'フォローユーザーのつぶやき投稿を取得できること' do
        @ichiro.follow(@jiro)
        micropost = @jiro.microposts.create(content: 'test')
        expect(@ichiro.feed_microposts).to include(micropost)
      end
    end

    describe 'いいね関連のメソッド' do
      before do
        @micropost = @jiro.microposts.create(content: 'test')
      end

      it 'いいね/いいね解除ができること' do
        @ichiro.favorite(@micropost)
        expect(@ichiro.favorite?(@micropost)).to eq true
        @ichiro.unfavorite(@micropost)
        expect(@ichiro.favorite?(@micropost)).to eq false
      end

      it 'いいねした投稿をいいね一覧として取得できること' do
        @ichiro.favorite(@micropost)
        expect(@ichiro.favorite_microposts).to include(@micropost)
      end

      it 'いいねしていない投稿はいいね一覧として取得されないこと' do
        micropost = FactoryBot.create(:micropost)
        expect(@ichiro.favorite_microposts).to_not include(micropost)
      end
    end

    describe '応援関連のメソッド' do
      before do
        @record = @jiro.records.create(label: 'test', finished: false, start_time: '2000-01-01 02:11:21')
      end

      it '応援/応援解除ができること' do
        @ichiro.support(@record)
        expect(@ichiro.support?(@record)).to eq true
        @ichiro.unsupport(@record)
        expect(@ichiro.support?(@record)).to eq false
      end

      it '終了した勉強は応援不可能であること' do
        @record.finished = true
        @ichiro.support(@record)
        expect(@ichiro.support?(@record)).to eq false
      end
    end
  end
end
