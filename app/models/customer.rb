class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def self.guest
    #'guest@example.com'に一致するレコードをDBから探し、見つからなかった場合に新しいレコードを作成
    find_or_create_by!(email: 'guest@example.com') do |user|
      #安全に使用できるパスワードを生成する
      user.password = SecureRandom.urlsafe_base64
      # name を入力必須としている場合は， user.name = "ゲスト" なども必要
    end
  end
end
