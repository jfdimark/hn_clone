class User < ActiveRecord::Base
  include BCrypt

  attr_accessible :email, :password_digest, :username, :password_confirmation, :password
  has_secure_password
  has_many :links
  has_many :comments

  # validates_confirmation_of :password
  validates :password_digest, :presence => true, :on => :create
  validates :email, :username, :presence => true
  validates :username, :email, :uniqueness => true

  # def password
  #   # logger.info("------------ password -----------")
  #   # logger.info(password)
  #   # @password ||= Password.new(password)
  # end

  def password=(new_password)
    logger.info("------------ new password -----------")
    logger.info(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end
