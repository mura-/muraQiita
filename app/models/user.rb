class User < ActiveRecord::Base
  has_many :tips
  has_many :comments
  has_many :stocks, dependent: :destroy

  before_validation do
    self.email_for_index = email.downcase if email
    self.start_date = Date.current if start_date.blank?
  end

  validates :start_date, presence: true, date: {
    after_or_equal_to: Date.new(2000, 1, 1),
    before: -> (obj) { 1.year.from_now.to_date },
    allow_blank: true
  }
  validates :end_date, date: {
    after: :start_date,
    before: -> (obj) { 1.year.from_now.to_date },
    allow_blank: true
  }

  def password=(row_password)
    if row_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(row_password)
    elsif row_password.nil?
      self.hashed_password = nil
    end
  end

  def active?
    !suspended? 
  end

  # twitterからのuser登録用
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.email = auth['uid']
      user.email_for_index = auth['uid']
      user.screen_name = auth['info']['nickname']
      user.name = auth['info']['name']
      user.start_date = Time.current
    end
  end
end
