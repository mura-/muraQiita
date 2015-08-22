class User < ActiveRecord::Base
  has_many :tips, dependent: :destroy

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
end
