class User < ActiveRecord::Base
  require 'securerandom'
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :role_id, :username
  @change_password = false

  has_one :role

  before_save :preSave
  after_save :clear_password

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :format => EMAIL_REGEX

  validates :password,
            :confirmation => true


  validates_length_of :password, :in => 6..20, :on => :create


  def self.authenticate(username_or_email="", login_password="")
    if EMAIL_REGEX.match(username_or_email)
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_username(username_or_email)
    end

    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end

  def change_password
    @change_password = true
  end

  def preSave
    if @change_password || new_record?
        self.salt = SecureRandom.urlsafe_base64(32)
        self.password = self.encrypt_password(password)
    end
  end

  def validate_password?

    if new_record?
      return true
    else
      if password.blank?
        return false
      else
        return true
      end
    end
  end


  def match_password(login_password)
    return password == self.encrypt_password(login_password)
  end


  def encrypt_password(password)
    return Digest::SHA1.hexdigest("#{password}--#{self.salt}")
  end


  def clear_password
    self.password = nil
  end
end
