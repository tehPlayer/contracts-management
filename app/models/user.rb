# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # , :recoverable, :rememberable
  devise :database_authenticatable, :registerable, :validatable

  validates :full_name, presence: true

  has_many :contracts

  def first_name
    full_name.split(' ').first
  end
end
