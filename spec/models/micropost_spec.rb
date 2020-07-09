require 'rails_helper'

RSpec.describe Micropost, type: :model do
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:micropost)).to be_valid
  end
  
  it "ユーザーとコンテンツがあれば有効であること" do
    @user = FactoryBot.create(:user)
    micropost = Micropost.new(
      user: @user,
      content: "hogehoge",
    )
    expect(micropost).to be_valid
  end
  
  describe "存在性の検証" do
    it "コンテンツが無ければ無効であること" do
      micropost = FactoryBot.build(:micropost, content: nil)
      expect(micropost).to_not be_valid
    end
    
    it "ユーザーが無ければ無効であること" do
      micropost = FactoryBot.build(:micropost, user: nil)
      expect(micropost).to_not be_valid
    end
  end
  
  describe "文字数の検証" do
    it "50文字以内であれば有効であること" do
      micropost = FactoryBot.create(:micropost)
      micropost.content = "a" * 50
      expect(micropost).to be_valid
    end
    
    it "50文字を超える場合無効であること" do
      micropost = FactoryBot.create(:micropost)
      micropost.content = "a" * 51
      expect(micropost).to_not be_valid
    end
  end
  
  describe "その他" do
    before do
      @micropost = FactoryBot.create(:micropost)
    end
    it "つぶやきが削除されると、そのつぶやきのいいねも削除されること" do
      
      skip "いいねが削除されることをマッチャーでどう検証すればよいか分からない"
      
      favorite = FactoryBot.create(:favorite, micropost_id: @micropost.id)
      expect(@micropost.destroy).to change(Favorite.count).by(-1)
    end
  end
end
