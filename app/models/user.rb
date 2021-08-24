class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password_confirmation, presence: true
  validates :password, length: {minimum: 6}

  def self.authenticate_with_credentials(email, password)
    modiefied_email = email.strip.downcase
    @user = User.find_by_email(modiefied_email).try(:authenticate, password)
    if @user
      @user
    else
      nil
    end
  end
end