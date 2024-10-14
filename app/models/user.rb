class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:username]

  validates :username, uniqueness: true

  has_many :movies
  has_many :reviews

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end
end
