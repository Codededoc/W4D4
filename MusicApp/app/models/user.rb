# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord

#  ActiveRecord::Base instance methods that run validations:
  #create
  #create!
  #save
  #save!
  #update
  #update_attributes
  #update_attributes!

  #User.find_by(key: value)
    #is a class method that allows you to search by key-value pair

  validates :email, presence: true, uniqueness: true
  validates :password_digest,  presence: true, uniqueness: true
  validates :password,  length: { minimum: 8, allow_nil: true }
  validates :session_token,  presence: true, uniqueness: true

  after_initialize  :ensure_session_token
    #sets session_token before validation if it's not present

  attr_reader :password

  # F => self.find_by_credentials(username, password)
  # R => reset_session_token!
  # I => is_password?(password)
  # P => password=(password)
  # private
  # E => ensure_session_token
  # G => self.generate_session_token


  def self.find_by_credentials(e_mail, password)
    #First, find user by username/email, save as variable
    # return user if found
    # && password matches!!
    # else, return nil
    user = User.find_by(email: e_mail)
    return nil unless user && user.is_password?(password)
    user
  end

  def reset_session_token!
    # resets session_token each time user logs in
    self.session_token = SecureRandom::urlsafe_base64
    # remember to SAVE user's session_token attribute!
    self.save!
    # return this new session_token
    self.session_token
  end

  def is_password?(password)
    #generate a BCrypted_password from the user's password_digest
    b_crypt_password = BCrypt::Password.new(self.password_digest)
    #check if the b_crypted_password matches user's inputted password
    b_crypt_password.is_password?(password)
                  # |^ this is bcrypt::password's "is_password?" method
  end

  def password=(password)
    #create an password instance for this user
    # create a corresponding password_digest for user by BCrypting it
    @password = password
    self.password_digest = BCrypt::Password.create(password)
    #self._____= calls a setter method defined for us by ActiveRecord
      # which is the state saved by self.save
  end

  private

  #ensure_session_token to be used "after_initialize"
  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def ensure_session_token
    # uses self.session_token OR
    # self.session_token is_now = self.class.generate_session_token
    self.session_token ||= self.class.generate_session_token
  end


end
