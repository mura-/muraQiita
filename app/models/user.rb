class User < ActiveRecord::Base
  has_many :tips, dependent: :destroy, :through => :comments
  has_many :stocks

  before_validation do
    self.email_for_index = email.downcase if email
  end

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

  def self.create_with_omniauth(auth)
    logger.debug auth
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
