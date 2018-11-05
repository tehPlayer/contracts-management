class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # 
  devise :database_authenticatable, :registerable, :validatable, :recoverable, :rememberable

  validates :full_name, presence: true
end
