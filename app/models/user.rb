class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :id, :email, :password, :password_confirmation, :remember_me, :role_id, :firstname, :lastname
  # attr_accessible :title, :body

  before_save :ensure_authentication_token

  has_many :requests
  has_many :users_roles
  has_and_belongs_to_many :roles

  def role?(role)
    !!self.roles.find_by_name(role.to_s.camelize)
  end

  def user_type
    if role?(:admin)
      2
    elsif role?(:manager)
      1
    elsif role?(:regular)
      0
    end
  end
end
