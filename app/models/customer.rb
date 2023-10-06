class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipes, dependent: :destroy

  # フォローをした、されたの関係
  # has_many :(アソシエーションが繋がっているテーブル名)、class_name: (実際のモデル名)、foreign_key: (外部キー)
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  # has_many :(架空のテーブル名)、source:(実際にデータを取得しにいくテーブル名)
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # フォローするときの処理
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end
  # フォローを外すときの処理
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end
  # フォローしているか判定
  def following?(customer)
    followings.include?(customer)
  end



  def self.guest
    #'guest@example.com'に一致するレコードをDBから探し、見つからなかった場合に新しいレコードを作成
    find_or_create_by!(email: 'guest@example.com') do |customer|
      #安全に使用できるパスワードを生成する
      customer.password = SecureRandom.urlsafe_base64
      # name を入力必須としている場合は， user.name = "ゲスト" なども必要
    end
  end

end
