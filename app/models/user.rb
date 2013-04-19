class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,:token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :full_name, :mobile_no, :mobile_code
  validates_presence_of :full_name, :on => :create
  validates_presence_of :mobile_no,:on => :create
  validates_presence_of :password,:on => :create
  validates_presence_of :password_confirmation, :on => :create
  validates_uniqueness_of :email, :mobile_no
  # attr_accessible :title, :body
end
