class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipes, dependent: :destroy

  # フォローをした、されたの関係
  # has_many :(アソシエーションが繋がっている)、class_name: (実際のモデル名)、foreign_key: (外部キー)
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  # has_many :(好きな命名)、source:(実際にデータを取得しにいく)
  # フォローしているユーザーの情報
  has_many :followings, through: :relationships, source: :followed
  # フォローされているユーザーの情報
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  has_one_attached :profile_image

  # フォローするときの処理
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end
  # フォローを外すときの処理
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end
  # 既にフォローしているか判定
  def following?(customer)
    followings.include?(customer)
  end

  def self.guest
    #'guest@example.com'に一致するレコードをDBから探し、見つからなかった場合に新しいレコードを作成
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.nickname = 'Guest User'
      customer.password = SecureRandom.urlsafe_base64 #安全に使用できるパスワードを生成する
      customer.birth_date = Date.new(2000, 1, 1)
    end
  end

  # プロフィール画像
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
